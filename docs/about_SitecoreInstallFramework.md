# SitecoreInstallFramework
## about_SitecoreInstallFramework

# SHORT DESCRIPTION
Deploy and configure Sitecore instances.

# LONG DESCRIPTION
The Sitecore Install Framework enables users to deploy and configure a Sitecore
environment using a standard configuration design that can be extended through
custom PowerShell functions.

The framework defines a configuration format that supports:

- Parameters
- Variables
- Tasks
- Extensions (Custom tasks, custom config functions)


By utilizing the framework, you can use extensions to configure a machine with
one or more Sitecore components, services, custom applications, and so on.

## Configurations
A configuration is a JSON file that defines the environment to be deployed.
The configuration follows a specific schema using the following format:
```
{
    "Parameters" : {},
    "Variables" : {},
    "Tasks" : {},
    "Modules" : []
}
```

## Parameters
Each entry in the 'Parameters' section is a Key/Value pair that allows common
configuration elements to be re-used throughout the configuration file.

```
{
    "Source": { "Type": "string" },
    "DeploymentDirectory": { "Type": "string", "DefaultValue": "C:\inetpub\wwwroot" },
    "SQLUser: {  "Type": "string", "DefaultValue": "sa" },
    "Databases": {  "Type": "string[]", "DefaultValue": [ 'core', 'master', 'web' ] }
}
```

All Parameters must have a 'Type'. They may also have a 'DefaultValue' that can
be overridden from the command line when invoking an installation.

For example, overriding the "DeploymentDirectory" parameter for the configuration above:
```

Install-SitecoreConfiguration -Path .\config.json -DeploymentDirectory "C:\Websites"

```
If a DefaultValue is not provided, the parameter must be passed when invoking
Install-SitecoreConfiguration

Parameters can also reference other Parameters using the 'Reference' property.
For example, referencing a common parameter such as the SQL User:
```
{
    "Source": { "Type": "string" },
    "DeploymentDirectory": { "Type": "string", "DefaultValue": "C:\inetpub\wwwroot" },
    "SQLUser: {  "Type": "string", "DefaultValue": "sa" },
    "MasterSQLUser: {  "Type": "string", "Reference": "SQLUser" },
    "Databases": {  "Type": "string[]", "DefaultValue": [ 'core', 'master', 'web' ] }
}

```

The 'MasterSQLUser' parameter will obtain it's value from the 'DefaultValue' of the 'SQLUser' parameter, but it can still be overridden from the command line.

A parameter cannot have a `DefaultValue` and  a `Reference`.

An error will be thrown if the referenced parameter does not exist or creates a circular reference.

For example, the following parameter declarations are not permitted:

```
{
    "Source": { "Type": "string" },
    "SQLUser: {  "Type": "string", "Reference": "MissingParameter" }
}

{
    "Source": { "Type": "string" },
    "SQLUser: {  "Type": "string", "Reference": "SQLUser" }
}

{
    "SQLUser: {  "Type": "string", "Reference": "CoreSQLUser" },
    "CoreSQLUser: {  "Type": "string", "Reference": "MasterSQLUser" },
    "MasterSQLUser: {  "Type": "string", "Reference": "WebSQLUser" },
    "WebSQLUser: {  "Type": "string", "Reference": "SQLUser" }
}
```

## Variables
Each entry in the 'Variables' section is a Key/Value pair that allows common
configuration elements that can be calculated or constructed and then used
within the configuration file.

```
{
    "DeploymentDirectory": "[concat(environment('systemdrive'), '\inetpub\wwwroot')]"
}
```

Variables can use the 'Config Function' syntax in order to retrieve information
or manipulate the value that the variable will contain.

Variables are lazy loaded. This means they will be evaluated the first time they are
used (by another variable or task). The value will then persist for any other requests.

## Config Functions

Config Functions are a way of calculating values for Variables or Task
parameters. They can make use of Parameters and Variables declared within a
config file or other available information, e.g. Environment Variables.

A Config Function is declared within square brackets and consists of a function
name and parenthesis:
```
{
    "SomeVariable": "[function()]"
}
```

Config Functions can accept parameters (separated by commas):
```
{
    "SomeVariable": "[function(1,2,3)]"
}
```

Config Function parameters can be integers, string literals or other functions:
```
{
    "SomeVariable": "[function(1)]"
    "SomeOtherVariable": "[function("1")]"
    "AnotherVariable": "[function(otherFunction())]"
}
```

The value for a Config Function is determined when the Config File is processed
at the beginning of an installation.

To discover the Config Functions available, you can run:
```
PS C:\>Get-Command -Name Invoke-*ConfigFunction
```

## Tasks
Each entry in the task section is an object defining a task to be executed.
The task must be in the format
```
{
    "TaskName" : {
        "Type" : "TaskType",
        "Params" : {
            "ParamName" : "value"
        }
    }
}
```

- 'TaskName' identifies the task in the configuration
- 'Type' is the type of task to execute.
- 'Params' defines a collection of parameters to pass to the task


For example, this configuration defines a use of the 'EnsurePath' task
```
{
    "CheckPaths" : {
        "Type" : "EnsurePath",
        "Params" : {
            "Clean" : "c:\deploy",
            "Exists" : "c:\deploy\here"
        }
    }
}
```

Tasks also support multiple parameter sets.  By passing an array of parameters
instead of an object. For example, we can copy multiple file paths using the
below configuration:
```
"CopyFiles" : {
    "Type": "Copy",
    "Params": [
        { "Source": "c:\files", "Destination": "c:\newfiles" },
        { "Source": "c:\files2", "Destination": "c:\newfiles2" },
        { "Source": "c:\files3", "Destination": "c:\newfiles3" }
    ]
}
```

> NOTE: The task type is defined by its function name.
You must be call the task `Invoke-<type>Task` where `<type>` is the value used
in the configuration.

To discover the tasks available, you can run:
```
PS C:\>Get-Command -Name Invoke-*Task
```
## Modules
Modules is a list of PowerShell modules to load into the environment before
executing any tasks. You can use this to load modules that tasks depend on, or
to load additional modules themselves.

```
{
    "Modules" : [
        "WebAdministration",
        "c:\path\to\custom\module.psm1"
    ]
}
```

# SEE ALSO

- about_SitecoreInstallFramework_Extending
- about_SitecoreInstallFramework_Configurations