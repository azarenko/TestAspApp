﻿# Extending the SitecoreInstallFramework
## about_SitecoreInstallFramework_Extending

# SHORT DESCRIPTION
How to extend the Sitecore Installation Framework.

# LONG DESCRIPTION
The SitecoreInstallFramework provides a number of extension points that allow
you to customize it to suit specific requirements for a Sitecore installation.

The extension points are:

- Custom Tasks
- Custom Config Functions


## Custom Tasks
A task is a PowerShell function that has been registered with the installation:
```
Register-SitecoreInstallExtension -Command <command> -As <name> -Type Task
```

Any parameters that the task declares can be passed directly from a
configuration.

### Custom Task Example
For example, a custom task that displays a colored message could be created and
saved in a script 'c:\customscript.psm1':
```
function Invoke-ColorMessageTask {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [string]$Color = 'Green'
    )

    Write-Host -Object $Message -ForegroundColor $Color
}
Register-SitecoreInstallExtension -Command Invoke-ColorMessageTask -As ColorMessage -Type Task
```
> NOTE: By using parameter validation the execution will fail if '$Message' is not provided.
The default color 'Green' is used if it is not declared in the configuration.

To use this in a configuration:
```
{
    "Tasks" : {
        "ShowMessage" : {
            "Type" : "ColorMessage",
            "Params" : {
                "Message" : "This is my message"
            }
        }
    },
    "Modules" : [
        "c:\customscript.psm1"
    ]
}
```
By adding the script, the task will can be discovered when the configuration is
loaded.

## Custom Config Functions
A config function is a PowerShell function that has been registered with the
installation:

```
Register-SitecoreInstallExtension -Command <command> -As <name> -Type ConfigFunction
```
Any parameters that the task declares can be passed directly from a
configuration.  Parameters are passed by order, not be name.

A config function should return a value.

### Custom Config Function Example
For example, a custom task that adds two integers could be created and saved in
a script 'c:\customconfigfunction.psm1':
```
function Invoke-AddConfigFunction {
    param(
        [Parameter(Mandatory=$true)]
        [int]$FirstNumber,
        [Parameter(Mandatory=$true)]
        [int]$SecondNumber
    )

    return $FirstNumber + $SecondNumber
}
Register-SitecoreInstallExtension -Command Invoke-AddConfigFunction -As Add -Type ConfigFunction
```
> NOTE: By using parameter validation the execution fails if '$FirstNumber' and 'SecondNumber' are not provided.

To use this in a configuration:
```
{
    "Variables" : {
        "Sum" : "[add(1,2)]"
    },
    "Modules" : [
        "c:\customconfigfunction.psm1"
    ]
}
```
By adding the script, the task can be discovered when the configuration is
loaded.

> NOTE: We recommend that custom config functions are kept simple and small because any complex scripts will impact the performance of the processing of a configuration file.

# SEE ALSO

- about_SitecoreInstallFramework
- about_SitecoreInstallFramework_Configurations