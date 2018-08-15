Set-StrictMode -Version 2.0

Function Install-SitecoreConfiguration {
    [Alias('Invoke-SitecoreInstall')]
    [Alias('scinst')]
    [CmdletBinding(SupportsShouldProcess = $true)]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '')]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateScript( { $_ -like '*.json' })]
        [ValidateScript( { Test-Path $_ -Type Leaf })]
        [string]$Path,
        [string[]]$Tasks = @(),
        [string]$From,
        [string]$To,
        [string[]]$Skip = @(),
        [ValidateScript( { Test-Path $_ -Type Container })]
        [string]$WorkingDirectory = $null
    )

    DynamicParam {
        $localPath = Get-Variable path -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Value
        if ($localPath) {
            $dynamicParams = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $json = Invoke-ReadJsonConfigFunction -Path $localPath
            if ($params = GetSection -Section 'Parameters' -InputObject $json) {
                # foreach parameter create a new entry
                foreach ($member in $params.GetMembers()) {
                    $attributes = new-object System.Collections.ObjectModel.Collection[System.Attribute]
                    $attr = New-Object System.Management.Automation.ParameterAttribute

                    $isMandatory = -not($member.Value.HasMember('DefaultValue'))

                    if ($member.Value.HasMember('Reference')) {
                        $isMandatory = $false
                    }

                    $attr.Mandatory = $isMandatory

                    if ($member.Value.HasMember('Description')) {
                        $attr.HelpMessage = $member.Value.Description
                    }
                    $attributes.Add($attr)
                    $newParam = New-Object System.Management.Automation.RuntimeDefinedParameter($member.Name, $member.Value.Type, $attributes)
                    $dynamicParams.Add($newParam.Name, $newParam)
                }
            }
            return $dynamicParams
        }
    }

    Process {

        # Ensure WhatIf is false so we can process the configuration file
        $givenWhatIfPref = $WhatIfPreference
        $WhatIfPreference = $false

        # Resolve full path to config _before_ changing working directory
        if ($Path) {
            $Path = (Resolve-Path $Path).ProviderPath
        }

        # Get settings from configuration
        $rawConfig = Invoke-ReadJsonConfigFunction -Path $Path
        $jsonSettings = GetSection -Section 'Settings' -InputObject $rawConfig
        $settings = MergeSettings -Config $jsonSettings -Command $PSBoundParameters

        # Set working directory - log file will be created in working directory
        $initDirectory = $pwd
        if ($WorkingDirectory) {
            Set-Location -Path $WorkingDirectory
        }

        # Resolve log path
        $logPath = ResolveLogPath -SourceFile $Path -DestinationFolder $pwd

        # Complete settings population
        $settings.WorkingDirectory = (Resolve-Path $pwd).ProviderPath
        $settings.Configuration = $Path
        $settings.LogPath = $logPath
        $settings.Debug = $DebugPreference
        $settings.Verbose = $VerbosePreference
        $settings.WhatIf = $givenWhatIfPref

        # Apply action preferences now for scope of processing configuration
        $InformationPreference = $settings.InformationAction
        $WarningPreference = $settings.WarningAction
        $ErrorActionPreference = $settings.ErrorAction

        # Create log file (only if actually processing)
        New-Item -Path $logPath -ItemType File -WhatIf:$($settings.WhatIf) | Out-Null

        try {

            Start-Transcript -Path $logPath -IncludeInvocationHeader -WhatIf:$($settings.WhatIf)
            $stopWatch = [Diagnostics.Stopwatch]::StartNew()
            WriteHeader -Settings $settings

            # Collect dynamic parameters that are overriding config parameters
            $dynamicParameters = @{}
            $params = $MyInvocation.MyCommand.Parameters
            $dynamicEntrys = $params.GetEnumerator().Where( { $_.Value.IsDynamic })
            if ($dynamicEntrys) {
                $boundKeys = $PSBoundParameters.Keys.Where( { $dynamicEntrys.Key -contains $_ })
                foreach ($entry in $boundKeys) {
                    $dynamicParameters.$entry = $PSBoundParameters.$entry
                }
            }

            # Register Default Extensions - Reset so any previous run is cleared out
            RegisterDefaultExtensions -Reset

            # Load up the modules
            if ($moduleFiles = GetSection -Section Modules -InputObject $rawConfig) {
                $moduleFiles | Where-Object { $_ } | ForEach-Object {
                    Write-Host "Importing Module => $_" -ForegroundColor Yellow
                    Import-Module -Name $_ -Force
                }
            }

            # Set the default parameters before we fully resolve the config
            # Ensures verbosity etc is set for config functions as well as tasks
            $PSDefaultParameterValues = BuildDefaultParameterMap -ParameterDefaults @{
                Verbose           = $settings.Verbose
                Debug             = $settings.Debug
                WhatIf            = $settings.WhatIf
                ErrorAction       = $settings.ErrorAction
                WarningAction     = $settings.WarningAction
                InformationAction = $settings.InformationAction
            }

             # Map parameters with any overridden values - Act as statics for rest of processing
            $parameterMap = MapParameters -InputObject $rawConfig -Overrides $dynamicParameters

            # Map variables - Lazy loaded.  Must call Evluate to be processed
            $variableMap = MapVariables -InputObject $rawConfig -Parameters $parameterMap

            # Map tasks - Ordered and identified
            $tasksConfig = MapTasks -InputObject $rawConfig

            # Add 'Skip' property to tasks in the Skip list
            foreach ($skipId in $Skip) {
                if ($tasksConfig.Keys -notcontains $skipId) {
                    throw "Could not find Task '$skipId' in Skip list"
                }
                else {
                    $tasksConfig[$skipId].Skip = $true
                }
            }

            # Resolve task list
            if ($Tasks.Count -eq 0) {
                $Tasks = $tasksConfig.Keys
            }

            $taskStartIndex = 0
            $taskStopIndex = $Tasks.Length

            if ($taskStopIndex -eq 0) {
                Write-Warning "Configuration contains no tasks"
                return
            }

            # split based on from/to
            if (![string]::IsNullOrWhiteSpace($From)) {
                $found = $Tasks | Where-Object { $_ -eq $From }
                if ($found) {
                    $taskStartIndex = $Tasks.IndexOf($found)
                }
                else {
                    throw "Could not find Task: $From"
                }
            }

            if (![string]::IsNullOrWhiteSpace($To)) {
                $found = $Tasks | Where-Object { $_ -eq $To }
                if ($found) {
                    # Plus one as inclusive of final task
                    $taskStopIndex = $Tasks.IndexOf($found) + 1
                }
                else {
                    throw "Could not find Task: $To"
                }
            }

            if ($taskStopIndex -lt $taskStartIndex) {
                throw "Task '$To' occurs before task '$From'"
            }

            # Build task collection - Ensure all tasks are valid before processing
            $toInvoke = New-Object System.Collections.ArrayList

            for ($taskIndex = $taskStartIndex; $taskIndex -lt $taskStopIndex; $taskIndex++) {
                $taskKey = $Tasks[$taskIndex]
                if ($tasksConfig.Keys -notcontains $taskKey) {
                    throw "Could not find task '$taskKey'."
                }
                $invokeTask = @{
                    Id   = $taskKey
                    Task = $tasksConfig[$taskKey]
                }

                [void]$toInvoke.Add($invokeTask)
            }

            $parentChunk = 100 / $toInvoke.Count
            $parentActivity = "Installing Sitecore"

            for ($i = 0; $i -lt $toInvoke.Count; $i++) {
                $entry = $toInvoke[$i]
                $taskDisplayString = "$($entry.Id) : $($entry.Task.Type)"
                $parentStatus = "Task $($i+1) of $($toInvoke.Count) - $taskDisplayString"
                [object[]] $params = @(@{})

                if ($entry.Task.HasMember('Params')) {
                    $params = $entry.Task.Params
                }

                if ($entry.Task.HasMember('Skip')) {
                    $skipTask = EvaluateObject -InputObject $entry.Task.Skip -Parameters $parameterMap -Variables $variableMap
                }
                else {
                    $skipTask = $false
                }

                if ($skipTask) {
                    Write-TaskHeader -TaskName "$($entry.Id) [Skipped]" -TaskType $entry.Task.Type
                    continue;
                }

                $paramSetCount = $params.Count

                for ($p = 0; $p -lt $paramSetCount; $p++) {
                    $parameterCompletePercent = (100 / $paramSetCount) * $p
                    $parentCompletePercent = ($i * $parentChunk) + ( ($parentChunk / 100) * $parameterCompletePercent)

                    Write-Progress -Activity $parentActivity -Status $parentStatus -PercentComplete $parentCompletePercent -Id 1
                    $parameterActivity = "Parameter set $($p+1) of $paramSetCount"

                    if ($paramSetCount -gt 1) {
                        Write-Progress -ParentId 1 -Activity $parameterActivity -Status $taskDisplayString -PercentComplete $parameterCompletePercent
                    }

                    $script:currentTask = $entry.Id
                    if ($paramSetCount -ne 1) {
                        $script:currentTask += " [$($p+1)]"
                    }

                    $script:currentTaskType = $entry.Task.Type
                    Write-TaskHeader -TaskName $currentTask -TaskType $currentTaskType

                    $paramSet = EvaluateObject -InputObject $Params[$p] -Parameters $parameterMap -Variables $variableMap
                    & $entry.Task.Command @paramSet | Out-Default

                    if ($p -eq $paramSetCount - 1) {
                        Write-Progress -Activity $parameterActivity -Completed
                    }
                }
            }
            Write-Progress -Activity $parentActivity -Completed
        }
        catch {
            # Write the error information then rethrow
            # We need the error information in the log
            # The rethrow is for any calling script
            Write-Error $_ -ErrorAction Continue
            throw
        }
        finally {
            $stopWatch.Stop()
            $formattedTime = $stopWatch.Elapsed.ToString('hh\:mm\:ss')
            Write-Host "[TIME] $formattedTime" -ForegroundColor Yellow

            if (!$settings.WhatIf) { Stop-Transcript }

            $WhatIfPreference = $settings.WhatIf

            if ($WorkingDirectory) {
                Set-Location -Path $initDirectory
            }
        }
    }
}
# SIG # Begin signature block
# MIIXwQYJKoZIhvcNAQcCoIIXsjCCF64CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUreyo/93PHVlqH8FJCa5q0vgi
# i9ugghL8MIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
# AQUFADCBizELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTEUMBIG
# A1UEBxMLRHVyYmFudmlsbGUxDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUVGhh
# d3RlIENlcnRpZmljYXRpb24xHzAdBgNVBAMTFlRoYXd0ZSBUaW1lc3RhbXBpbmcg
# Q0EwHhcNMTIxMjIxMDAwMDAwWhcNMjAxMjMwMjM1OTU5WjBeMQswCQYDVQQGEwJV
# UzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFu
# dGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBALGss0lUS5ccEgrYJXmRIlcqb9y4JsRDc2vCvy5Q
# WvsUwnaOQwElQ7Sh4kX06Ld7w3TMIte0lAAC903tv7S3RCRrzV9FO9FEzkMScxeC
# i2m0K8uZHqxyGyZNcR+xMd37UWECU6aq9UksBXhFpS+JzueZ5/6M4lc/PcaS3Er4
# ezPkeQr78HWIQZz/xQNRmarXbJ+TaYdlKYOFwmAUxMjJOxTawIHwHw103pIiq8r3
# +3R8J+b3Sht/p8OeLa6K6qbmqicWfWH3mHERvOJQoUvlXfrlDqcsn6plINPYlujI
# fKVOSET/GeJEB5IL12iEgF1qeGRFzWBGflTBE3zFefHJwXECAwEAAaOB+jCB9zAd
# BgNVHQ4EFgQUX5r1blzMzHSa1N197z/b7EyALt0wMgYIKwYBBQUHAQEEJjAkMCIG
# CCsGAQUFBzABhhZodHRwOi8vb2NzcC50aGF3dGUuY29tMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC50aGF3dGUuY29tL1Ro
# YXd0ZVRpbWVzdGFtcGluZ0NBLmNybDATBgNVHSUEDDAKBggrBgEFBQcDCDAOBgNV
# HQ8BAf8EBAMCAQYwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0y
# MDQ4LTEwDQYJKoZIhvcNAQEFBQADgYEAAwmbj3nvf1kwqu9otfrjCR27T4IGXTdf
# plKfFo3qHJIJRG71betYfDDo+WmNI3MLEm9Hqa45EfgqsZuwGsOO61mWAK3ODE2y
# 0DGmCFwqevzieh1XTKhlGOl5QGIllm7HxzdqgyEIjkHq3dlXPx13SYcqFgZepjhq
# IhKjURmDfrYwggSjMIIDi6ADAgECAhAOz/Q4yP6/NW4E2GqYGxpQMA0GCSqGSIb3
# DQEBBQUAMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyMB4XDTEyMTAxODAwMDAwMFoXDTIwMTIyOTIzNTk1OVowYjELMAkGA1UE
# BhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMTQwMgYDVQQDEytT
# eW1hbnRlYyBUaW1lIFN0YW1waW5nIFNlcnZpY2VzIFNpZ25lciAtIEc0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAomMLOUS4uyOnREm7Dv+h8GEKU5Ow
# mNutLA9KxW7/hjxTVQ8VzgQ/K/2plpbZvmF5C1vJTIZ25eBDSyKV7sIrQ8Gf2Gi0
# jkBP7oU4uRHFI/JkWPAVMm9OV6GuiKQC1yoezUvh3WPVF4kyW7BemVqonShQDhfu
# ltthO0VRHc8SVguSR/yrrvZmPUescHLnkudfzRC5xINklBm9JYDh6NIipdC6Anqh
# d5NbZcPuF3S8QYYq3AhMjJKMkS2ed0QfaNaodHfbDlsyi1aLM73ZY8hJnTrFxeoz
# C9Lxoxv0i77Zs1eLO94Ep3oisiSuLsdwxb5OgyYI+wu9qU+ZCOEQKHKqzQIDAQAB
# o4IBVzCCAVMwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAO
# BgNVHQ8BAf8EBAMCB4AwcwYIKwYBBQUHAQEEZzBlMCoGCCsGAQUFBzABhh5odHRw
# Oi8vdHMtb2NzcC53cy5zeW1hbnRlYy5jb20wNwYIKwYBBQUHMAKGK2h0dHA6Ly90
# cy1haWEud3Muc3ltYW50ZWMuY29tL3Rzcy1jYS1nMi5jZXIwPAYDVR0fBDUwMzAx
# oC+gLYYraHR0cDovL3RzLWNybC53cy5zeW1hbnRlYy5jb20vdHNzLWNhLWcyLmNy
# bDAoBgNVHREEITAfpB0wGzEZMBcGA1UEAxMQVGltZVN0YW1wLTIwNDgtMjAdBgNV
# HQ4EFgQURsZpow5KFB7VTNpSYxc/Xja8DeYwHwYDVR0jBBgwFoAUX5r1blzMzHSa
# 1N197z/b7EyALt0wDQYJKoZIhvcNAQEFBQADggEBAHg7tJEqAEzwj2IwN3ijhCcH
# bxiy3iXcoNSUA6qGTiWfmkADHN3O43nLIWgG2rYytG2/9CwmYzPkSWRtDebDZw73
# BaQ1bHyJFsbpst+y6d0gxnEPzZV03LZc3r03H0N45ni1zSgEIKOq8UvEiCmRDoDR
# EfzdXHZuT14ORUZBbg2w6jiasTraCXEQ/Bx5tIB7rGn0/Zy2DBYr8X9bCT2bW+IW
# yhOBbQAuOA2oKY8s4bL0WqkBrxWcLC9JG9siu8P+eJRRw4axgohd8D20UaF5Mysu
# e7ncIAkTcetqGVvP6KUwVyyJST+5z3/Jvz4iaGNTmr1pdKzFHTx/kuDDvBzYBHUw
# ggUrMIIEE6ADAgECAhAHplztCw0v0TJNgwJhke9VMA0GCSqGSIb3DQEBCwUAMHIx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJ
# RCBDb2RlIFNpZ25pbmcgQ0EwHhcNMTcwODIzMDAwMDAwWhcNMjAwOTMwMTIwMDAw
# WjBoMQswCQYDVQQGEwJVUzELMAkGA1UECBMCY2ExEjAQBgNVBAcTCVNhdXNhbGl0
# bzEbMBkGA1UEChMSU2l0ZWNvcmUgVVNBLCBJbmMuMRswGQYDVQQDExJTaXRlY29y
# ZSBVU0EsIEluYy4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7PZ/g
# huhrQ/p/0Cg7BRrYjw7ZMx8HNBamEm0El+sedPWYeAAFrjDSpECxYjvK8/NOS9dk
# tC35XL2TREMOJk746mZqia+g+NQDPEaDjNPG/iT0gWsOeCa9dUcIUtnBQ0hBKsuR
# bau3n7w1uIgr3zf29vc9NhCoz1m2uBNIuLBlkKguXwgPt4rzj66+18JV3xyLQJoS
# 3ZAA8k6FnZltNB+4HB0LKpPmF8PmAm5fhwGz6JFTKe+HCBRtuwOEERSd1EN7TGKi
# xczSX8FJMz84dcOfALxjTj6RUF5TNSQLD2pACgYWl8MM0lEtD/1eif7TKMHqaA+s
# m/yJrlKEtOr836BvAgMBAAGjggHFMIIBwTAfBgNVHSMEGDAWgBRaxLl7Kgqjpepx
# A8Bg+S32ZXUOWDAdBgNVHQ4EFgQULh60SWOBOnU9TSFq0c2sWmMdu7EwDgYDVR0P
# AQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMHcGA1UdHwRwMG4wNaAzoDGG
# L2h0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9zaGEyLWFzc3VyZWQtY3MtZzEuY3Js
# MDWgM6Axhi9odHRwOi8vY3JsNC5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLWNz
# LWcxLmNybDBMBgNVHSAERTBDMDcGCWCGSAGG/WwDATAqMCgGCCsGAQUFBwIBFhxo
# dHRwczovL3d3dy5kaWdpY2VydC5jb20vQ1BTMAgGBmeBDAEEATCBhAYIKwYBBQUH
# AQEEeDB2MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wTgYI
# KwYBBQUHMAKGQmh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFNI
# QTJBc3N1cmVkSURDb2RlU2lnbmluZ0NBLmNydDAMBgNVHRMBAf8EAjAAMA0GCSqG
# SIb3DQEBCwUAA4IBAQBozpJhBdsaz19E9faa/wtrnssUreKxZVkYQ+NViWeyImc5
# qEZcDPy3Qgf731kVPnYuwi5S0U+qyg5p1CNn/WsvnJsdw8aO0lseadu8PECuHj1Z
# 5w4mi5rGNq+QVYSBB2vBh5Ps5rXuifBFF8YnUyBc2KuWBOCq6MTRN1H2sU5LtOUc
# Qkacv8hyom8DHERbd3mIBkV8fmtAmvwFYOCsXdBHOSwQUvfs53GySrnIYiWT0y56
# mVYPwDj7h/PdWO5hIuZm6n5ohInLig1weiVDJ254r+2pfyyRT+02JVVxyHFMCLwC
# ASs4vgbiZzMDltmoTDHz9gULxu/CfBGM0waMDu3cMIIFMDCCBBigAwIBAgIQBAkY
# G1/Vu2Z1U0O1b5VQCDANBgkqhkiG9w0BAQsFADBlMQswCQYDVQQGEwJVUzEVMBMG
# A1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQw
# IgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgQ0EwHhcNMTMxMDIyMTIw
# MDAwWhcNMjgxMDIyMTIwMDAwWjByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
# aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhE
# aWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgQ29kZSBTaWduaW5nIENBMIIBIjANBgkq
# hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA+NOzHH8OEa9ndwfTCzFJGc/Q+0WZsTrb
# RPV/5aid2zLXcep2nQUut4/6kkPApfmJ1DcZ17aq8JyGpdglrA55KDp+6dFn08b7
# KSfH03sjlOSRI5aQd4L5oYQjZhJUM1B0sSgmuyRpwsJS8hRniolF1C2ho+mILCCV
# rhxKhwjfDPXiTWAYvqrEsq5wMWYzcT6scKKrzn/pfMuSoeU7MRzP6vIK5Fe7SrXp
# dOYr/mzLfnQ5Ng2Q7+S1TqSp6moKq4TzrGdOtcT3jNEgJSPrCGQ+UpbB8g8S9MWO
# D8Gi6CxR93O8vYWxYoNzQYIH5DiLanMg0A9kczyen6Yzqf0Z3yWT0QIDAQABo4IB
# zTCCAckwEgYDVR0TAQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0l
# BAwwCgYIKwYBBQUHAwMweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRw
# Oi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRz
# LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQwgYEGA1Ud
# HwR6MHgwOqA4oDaGNGh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEFz
# c3VyZWRJRFJvb3RDQS5jcmwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNv
# bS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcmwwTwYDVR0gBEgwRjA4BgpghkgB
# hv1sAAIEMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9D
# UFMwCgYIYIZIAYb9bAMwHQYDVR0OBBYEFFrEuXsqCqOl6nEDwGD5LfZldQ5YMB8G
# A1UdIwQYMBaAFEXroq/0ksuCMS1Ri6enIZ3zbcgPMA0GCSqGSIb3DQEBCwUAA4IB
# AQA+7A1aJLPzItEVyCx8JSl2qB1dHC06GsTvMGHXfgtg/cM9D8Svi/3vKt8gVTew
# 4fbRknUPUbRupY5a4l4kgU4QpO4/cY5jDhNLrddfRHnzNhQGivecRk5c/5CxGwcO
# kRX7uq+1UcKNJK4kxscnKqEpKBo6cSgCPC6Ro8AlEeKcFEehemhor5unXCBc2XGx
# DI+7qPjFEmifz0DLQESlE/DmZAwlCEIysjaKJAL+L3J+HNdJRZboWR3p+nRka7Lr
# ZkPas7CM1ekN3fYBIM6ZMWM9CBoYs4GbT8aTEAb8B4H6i9r5gkn3Ym6hU/oSlBiF
# LpKR6mhsRDKyZqHnGKSaZFHvMYIELzCCBCsCAQEwgYYwcjELMAkGA1UEBhMCVVMx
# FTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNv
# bTExMC8GA1UEAxMoRGlnaUNlcnQgU0hBMiBBc3N1cmVkIElEIENvZGUgU2lnbmlu
# ZyBDQQIQB6Zc7QsNL9EyTYMCYZHvVTAJBgUrDgMCGgUAoHAwEAYKKwYBBAGCNwIB
# DDECMAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEO
# MAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFI/0afiKinIrfp8Vea1S2g73
# v0e8MA0GCSqGSIb3DQEBAQUABIIBAKT5DtsPhcEUNWBWNyrdg9dJ8gqys1AelgdO
# MlmBUjzfmeNi9txR97bw6N5bjn9XJfAw6okG/JWuII8jxqwrNJCMF5CkJVQ3wfAg
# 6F495Jm1uVtCSEVMztkEkyT0XxWV/hXHZRgW1tUmJ7XVipX06EYpb4K3dM/10Uch
# cTedfkF/FToTGngkh8KwoBBocIb7MxNRRZXpTxJIG643VRHQUWdGEMqHTvvOxqsk
# uRhveAvcxrSP+ETm5Gl27f7SvARis+WPgHaLWhLUPLQz8xppaX+57eyMUCtQCoMJ
# rBllo/LQNOOWLud31kFhvMyzAYdmCEVN+uBV9LG8uFzbMxgaBzShggILMIICBwYJ
# KoZIhvcNAQkGMYIB+DCCAfQCAQEwcjBeMQswCQYDVQQGEwJVUzEdMBsGA1UEChMU
# U3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFudGVjIFRpbWUgU3Rh
# bXBpbmcgU2VydmljZXMgQ0EgLSBHMgIQDs/0OMj+vzVuBNhqmBsaUDAJBgUrDgMC
# GgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MTgwMjEyMDgzNDA0WjAjBgkqhkiG9w0BCQQxFgQUoSHkAMhJdXVh6jZeVt7vMHqH
# B9wwDQYJKoZIhvcNAQEBBQAEggEAPzCyr6SZUZ45BzphZ2l6/W0XBBojDlPJuTqv
# AwdM4N1Qr2V7ThujRVjRtyGZMNrFKBOS/tgE305t6W8srIe7M+3S9w3w5D7ryjYr
# ZorafiI1n6fvDsUWyldvetMqARyuF9QVUkqLwclPBRUvJCaLuBV749Nu14XDrZmD
# qQxiFeiSysWnWL0iYgTcdFGZccJ7Oki+2zDbsYideGgUQRzKCHForjmvGTpzZfLp
# Yh5x1Q4BBm/fgrmO04VmvmROu0pzDfZaksEmZRgoczyFIEyyJKgiymqFwAYT3aex
# PcK/1xCFkT/kFrE3HMKTkQdg2v2/7t6HzZxuTnzYwq5ZiPgqjQ==
# SIG # End signature block
