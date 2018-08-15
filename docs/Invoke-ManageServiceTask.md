---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ManageServiceTask

## SYNOPSIS
Manages changes to an existing service.

## SYNTAX

```
Invoke-ManageServiceTask [-Name] <String> [[-Status] <String>] [[-StartupType] <String>]
 [[-Description] <String>] [[-DisplayName] <String>] [[-PostDelay] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Modifies settings for a service.
You can use this task to change the current running status of a service, its startup mode, and more.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ManageServiceTask -Name Example -Status Running -StartupType Automatic
```

Updates the existing service 'Example', setting its status to running and changing its startup type to automatic.

## PARAMETERS

### -Description
The user-friendly description of the service.

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

### -DisplayName
The user-friendly name of the service.

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

### -Name
The name of the service to manage.

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

### -PostDelay
Numer of milliseconds to delay after apllying changes.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartupType
The startup type for the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Automatic, Boot, Disabled, Manual, System

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Status
The running status of the service.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Running, Stopped, Paused

Required: False
Position: 1
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

[Invoke-CreateServiceTask](Invoke-CreateServiceTask.md)
[Invoke-RemoveServiceTask](Invoke-RemoveServiceTask.md)