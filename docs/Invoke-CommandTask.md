---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-CommandTask

## SYNOPSIS
Task to support the execution of an arbitrary command.

## SYNTAX

```
Invoke-CommandTask [-Path] <String> [[-Arguments] <PSObject[]>] [[-TaskName] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This task enables the execution of any command by calling an executable directly or one that is available from the current PATH.

Each entry in the Arguments array is passed as a separate value to the executable. 
Arguments must be passed in the format accepted by the executable (for example, '/p:Configuration=Release' would be a single value for msbuild while '--Configuration Release' should be passed as two values to a PowerShell function).

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Invoke-CommandTask -Path nuget -Arguments sources,-format,short
```

Assuming nuget is available on the current PATH, this invokes nuget.exe and displays a list of the sources available in a condensed format.

### EXAMPLE 2
```
PS C:\> Invoke-CommandTask -Path c:\utilities\nuget.exe -Arguments sources,-format,short
```

This invokes nuget from a specific location and displays a list of the sources available in a condensed format.

## PARAMETERS

### -Arguments
The arguments to pass to the executable. 
See description and examples for details.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to the executable.

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

### -TaskName
The optional name of the task to output in the log information.

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
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

