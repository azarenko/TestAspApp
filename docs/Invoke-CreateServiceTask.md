---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-CreateServiceTask

## SYNOPSIS
Creates a Windows service

## SYNTAX

```
Invoke-CreateServiceTask [-Name] <String> [-Path] <String> [[-Arguments] <Object[]>] [[-StartupType] <String>]
 [[-Description] <String>] [[-DisplayName] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a Windows service for the given path.
The service is registered with any optional arguments.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-CreateServiceTask -Name Example -Path c:\my\service.exe -Arguments '-list',5 -Startup Automatic
```

This registers a service called 'Example' with the executable path 'c:\my\service.exe -list 5'.
The service can be started automatically.

## PARAMETERS

### -Arguments
An array of values that are bound as arguments to the service.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
The user-friendly description of the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisplayName
The user-friendly name of the service.

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

### -Name
The registered name of the service.

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

### -Path
The path to the executable of the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupType
The way in which the service can be started.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Automatic, Boot, Disabled, Manual, System

Required: False
Position: 3
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

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Invoke-ManageServiceTask](Invoke-ManageServiceTask.md)
[Invoke-RemoveServiceTask](Invoke-RemoveServiceTask.md)

