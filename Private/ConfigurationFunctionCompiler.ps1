Function ValidateConfigFunctionFormat {
<#
.SYNOPSIS
    Config function format validator.

.DESCRIPTION
    Ensures that config functions follow the format [funcName(params)]
#>
    param(
        [Parameter(Mandatory=$true)]
        [AllowNull()]
        [AllowEmptyString()]
        [string]$FunctionText
    )

    return $FunctionText -match '^\[[^\(]+\(.*\).*\]$'
}

Function Tokenize {
<#
    .SYNOPSIS
        Trivial tokenizer for parameters

    .DESCRIPTION
        Converts a Config Function string into a list of tokens for parsing.
#>
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({ ValidateConfigFunctionFormat -FunctionText $_ })]
        [string]$Value
    )

    Function CreateToken {
        param(
            $Type,
            $Value
        )

        New-Object PSObject -Property @{
            Type = $Type
            Value = $Value
        }
    }

    try {
        $tokens = New-Object System.Collections.ArrayList # collect tokens into ordered list

        $funcStartToken = CreateToken 'ConfigFunctionStart' $Value[0]
        [void]$tokens.Add($funcStartToken)

        $parseTokens = $null
        $parseErrors = $null

        $textToParse = $Value.Substring(1, $Value.Length - 2)
        [void][System.Management.Automation.Language.Parser]::ParseInput($textToParse, [ref]$parseTokens, [ref]$parseErrors)

        foreach($e in $parseErrors)
        {
            switch($e.ErrorId)
            {
                'TerminatorExpectedAtEndOfString' {
                    $openingChar = $e.Extent.Text[0]
                    $endChar = $e.Extent.Text[$e.Extent.Text.Length-1]
                    throw "Invalid String Literal. Expecting $openingChar but found $endChar in $Value"
                }
            }
        }

        foreach($t in $parseTokens)
        {
            switch($t.Kind)
            {
                'LParen' {
                    $token = CreateToken 'ParametersStart' $t.Text
                    break;
                }
                'RParen' {
                    $token = CreateToken 'ParametersEnd' $t.Text
                    break;
                }
                'LBracket' {
                    $token = CreateToken 'AccessorStart' $t.Text
                    break;
                }
                'RBracket' {
                    $token = CreateToken 'AccessorEnd' $t.Text
                    break;
                }
                'Comma' {
                    $token = CreateToken 'Delimiter' $t.Text
                    break;
                }
                'StringLiteral' {
                    $token = CreateToken 'StringLiteral' $t.Text.Substring(1, $t.Text.Length-2)
                    break;
                }
                'StringExpandable' {
                    $token = CreateToken 'StringLiteral' $t.Text.Substring(1, $t.Text.Length-2)
                    break;
                }
                'Number' {
                    $token = CreateToken 'IntLiteral' $t.Text
                    break;
                }
                'Identifier' {
                    $token = CreateToken 'FunctionName' $t.Text
                    break;
                }
                'EndOfInput' {
                    $token = CreateToken 'ConfigFunctionEnd' $Value[$Value.Length-1]
                    break;
                }
                default {
					if($t.TokenFlags.HasFlag([System.Management.Automation.Language.TokenFlags]::Keyword)) {
		            	$token = CreateToken 'FunctionName' $t.Text
        		        break;
					}
	                throw "Unexpected token $($t.Kind)"
    	            break;
                }
            }

            [void]$tokens.Add($token)
        }

        return $tokens
    } catch {
        Write-Error $_
    }
}

Function Parse {
<#
    .SYNOPSIS
        Returns an Abstract Syntaxt Tree (AST) for the given tokens
#>
    param(
        [Parameter(Mandatory=$true)]
        [psobject[]]$Tokens
    )

    Function Walk {
        param(
            [Parameter(Mandatory=$true)]
            [int]$From = 0
        )

        $token = $Tokens[$From]

       switch ($token.Type) {
            'FunctionName' {
                $func = New-Object PSObject -Property @{
                    Type = $token.Type
                    Name = $token.Value
                    Parameters =  (New-Object System.Collections.ArrayList)
                    Accessor = $null
                }

                # Get first token following the function name
                $From++
                $token = $Tokens[$From]

                if($token.Type -ne "ParametersStart") {
                    throw "Syntax Error: Expected '(' to follow Function Name"
                }

                # Skip opening parenthesis for function
                $From++
                $token = $Tokens[$From]

                while($token.Type -ne 'ParametersEnd') {
                    $next,$From = Walk -From $From
                    if($null -ne $next) {
                        [void]$func.Parameters.Add($next)
                    }
                    $token = $Tokens[$From]
                }

                # Check for accessor after parameters
                $From++ # Increment past end of parameters
                if($From -ne $tokens.Length){
                    if($Tokens[$From].Type -eq 'AccessorStart'){
                        $next,$From = Walk -From $From
                        $func.Accessor = $next
                    }
                }

                return $func,$From
            }
            'AccessorStart' {
                $val = New-Object PSObject -Property @{
                    Type = 'Accessor'
                    Name = 'Accessor'
                    Parameters =  (New-Object System.Collections.ArrayList)
                }

                # Get first token following the start of accessor
                $From++
                $token = $Tokens[$From]

                while($token.Type -ne 'AccessorEnd') {
                    $next,$From = Walk -From $From
                    if($null -ne $next) {
                        [void]$val.Parameters.Add($next)
                    }
                    $token = $Tokens[$From]
                }

                return $val,$From

            }
            'StringLiteral' {
                $From++

                $val = New-Object PSObject -Property @{
                    Type = 'Literal'
                    Value = $token.Value
                }

                return $val,$From
            }
            'IntLiteral' {
                $From++
                $val = New-Object PSObject -Property @{
                    Type = 'Literal'
                    Value = [int]$token.Value
                }

                return $val,$From
            }
            'ParametersEnd' {
                $From++
                return $null,$From
            }
            'AccessorEnd' {
                $From++
                return $null,$From
            }
            'ConfigFunctionEnd' {
                $From++
                return $null,$From
            }
            default {
                $From++
                return Walk -From $From
            }
        }
    }

    $syntaxTree = New-Object PSObject -Property @{
        Type = 'Program'
        Body = (New-Object System.Collections.ArrayList)
    }

    $from = 0

    while($from -lt $Tokens.Length) {
        $next,$from = Walk -From $from
        if($null -ne $next) {
            [void]$syntaxTree.Body.Add($next)
        }
    }

    # Return the ast
    $syntaxTree
}

Function Compile {
<#
    .SYNOPSIS
        Builds Powershell Scriptblock based on an Abstract Syntaxt Tree (AST)
#>
    param(
        [Parameter(Mandatory=$true)]
        [psobject]$Ast
    )

    Function Visit {
        param(
            $node,
            $Visitor
        )

        switch ($node.Type) {
            'Program' {
                foreach($entry in $node.Body) {
                    Visit $entry -Visitor $Visitor
                }
            }
            'FunctionName' {
                $result = ''
                $accessor = ''
                # evaluate accessor first
                if($node.Accessor) {
                    $accessor = Visit $node.Accessor -Visitor $Visitor
                }

                switch($node.Name) {
                    'parameter' {
                        $result = "`$parameters.'$($node.Parameters[0].Value)'"
                        break
                    }
                    'variable' {
                        $result = "`$variables.'$($node.Parameters[0].Value)'.Evaluate(`$parameters, `$variables)"
                        break
                    }
                    default {
                        $parameters = ''
                        foreach($param in $node.Parameters) {
                            $paramValue = Visit $param -Visitor $Visitor
                            $parameters += " $paramValue"
                        }
                        $next = $Visitor.ParamCount++
                        $id = "p$next"
                        $function = ResolveExtension -Id $node.Name -Type ConfigFunction
                        $functionCall = "$function$parameters".Trim()
                        $Visitor.Script += "`n`$$id = ($functionCall)"
                        $result = "`$$id"
                    }
                }

                return $result + $accessor
            }
            'Accessor' {
                $parameters = ''
                foreach($param in $node.Parameters) {
                    $paramValue = Visit $param -Visitor $Visitor
                    $parameters += " $paramValue"
                }
                $next = $Visitor.ParamCount++
                $id = "p$next"
                $functionCall = "$parameters".Trim()
                $Visitor.Script += "`n`$$id = ($functionCall)"
                $result = "`$$id"
                return "[$result]"
            }
            'Literal' {
                $next = $Visitor.ParamCount++
                $id = "p$next"
                $p = [PSVariable]::new($id, $node.Value)
                $Visitor.Parameters.Add($p)
                return "`$$id"
            }
        }
    }

    $visitor = [PSObject]@{
        Parameters = [System.Collections.Generic.List[PSVariable]]::new()
        ParamCount = 0
        Script = ''
    }

    $finalLine = Visit $ast -Visitor $visitor
    # amend with final return value
    $Visitor.script += "`n$finalLine"
    $visitor
}
# SIG # Begin signature block
# MIIXwQYJKoZIhvcNAQcCoIIXsjCCF64CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUuxr7bF10fTtCbXanV2tcjvlp
# 4AigghL8MIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
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
# MAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYEFFXMl1MIq/7c/TBBofzL45Sq
# hAhgMA0GCSqGSIb3DQEBAQUABIIBAAOLg/htHkoopamMcXTN3tDXjvpyNBrQhcWF
# v/8QFwv/zYcEV07t71sLjw2E+ic2yhyMv5HrhGLVr5VX+t5RpBoeQ3139HwlUhSq
# Uqm1fqOttJsJXwoaf1nZb4StGdsDht0Snbb5KCv+cy9cD0t0wp5e8bMabo4YZfGl
# dNV8Opc7WEb1tJ3DCjchTF2yJV8GooNamnMlzu4PL9Swsf7KXo67EZ9Hn+8qKoPI
# ie1b4xDHT7XUPGPV81/iPBcikXh432WkUtp7OFqIfrqJFgiANP/gAHDIN1sp1b6+
# /mApTpkJsB8+n6roupQaEbi4LlU2GOXhsZBd2ZQf+3VpXlREHuyhggILMIICBwYJ
# KoZIhvcNAQkGMYIB+DCCAfQCAQEwcjBeMQswCQYDVQQGEwJVUzEdMBsGA1UEChMU
# U3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFudGVjIFRpbWUgU3Rh
# bXBpbmcgU2VydmljZXMgQ0EgLSBHMgIQDs/0OMj+vzVuBNhqmBsaUDAJBgUrDgMC
# GgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
# MTgwMjEyMDgzMzU1WjAjBgkqhkiG9w0BCQQxFgQU+6v6nXIGTCZlcYoT/DoW7g6E
# tDkwDQYJKoZIhvcNAQEBBQAEggEAIfoyK/3++oucT79gxA8V83K92VOJhsqYJx8U
# 13A7Q7q313D/ESfPBIw/JGaoov3xaWh01BhdZoyFqkuDCPligi8QhhZWQI4yusht
# J9XRUjG6SnPuSg+xJ8CzZ7rK/tYdPJnMF2/g6mE6R8+pBlJaa4NP/xu4V2TWkTr8
# JNpPPwhMnpza4VyIeJ1NXIMeXZ1CJizPkGPDmpo2CdumdCUrN4DuppN0rlCTLPYU
# RphW1Xz5BPeOLzHsFz284i89uMC6LtNMhMuBOp4wav/9XtJRAXhVsCVNAUwlENtt
# WpFJRpoYB52wTSKFYVn1Y/odIiOyZBMzHLNFQibFw99tQRLGdQ==
# SIG # End signature block
