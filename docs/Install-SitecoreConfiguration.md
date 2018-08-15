---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Install-SitecoreConfiguration

## SYNOPSIS
Invokes a Sitecore installation

## SYNTAX

```
Install-SitecoreConfiguration [-Path] <String> [[-Tasks] <String[]>] [[-From] <String>] [[-To] <String>]
 [[-Skip] <String[]>] [[-WorkingDirectory] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Begins a Sitecore installation using the given configuration loaded from a path.

The working directory is set as follows:

- If provided, the working directory is set to the given path.
- The current directory is used.

One or more tasks can also be passed to enable executing only a selection of
tasks from the full configuration. If no tasks are passed (or an empty list
is provided) all tasks are executed. Execution of tasks can be further isolated
by providing the 'From' and 'To' parameters. This executes an inclusive subset
of tasks.

Parameters contained in the configuration file can also be overridden at the
command line.

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Install-SitecoreConfiguration -Path .\MyConfig.json
```

Starts an installation based on a JSON configuration file.

### EXAMPLE 2
```
PS C:\> Install-SitecoreConfiguration -Path .\MyConfig.json -Tasks Alpha,Beta,Epsilon
```

Starts an installation based on a JSON configuration file and executes only the
named tasks.

### EXAMPLE 3
```
PS C:\> Install-SitecoreConfiguration -Path .\MyConfig.json -Skip Alpha,Beta
```

Starts an installation based on a JSON configuration file and executes all tasks except the
named tasks.

### EXAMPLE 4
```
PS C:\> Install-SitecoreConfiguration -Path .\MyConfig.json -From Beta
```

Starts an installation based on a JSON configuration file and executes from the
specified task.

### EXAMPLE 5
```
PS C:\> Install-SitecoreConfiguration -Path .\MyConfig.json -From Alpha -To Beta
```

Starts an installation based on a JSON configuration file and executes from the
task named `Alpha` to the task named `Beta`.

### EXAMPLE 6
```
PS C:\> Install-SitecoreConfiguration -Path .\MyConfig.json -SiteName 'MySite'
```

Starts an installation based on a JSON configuration file, overriding the value
for the `SiteName` parameter an contained in that file.

## PARAMETERS

### -From
The task name to start from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to a configuration file to use for the installation.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Skip
The explicit tasks to ignore.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tasks
The explicit tasks (and order) to run.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -To
The last task to run.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkingDirectory
The working directory to use during installation. 
For further information, see see function description.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

