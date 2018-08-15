---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Write-TaskHeader

## SYNOPSIS
Outputs a formatted message to the information stream.

## SYNTAX

```
Write-TaskHeader [-TaskName] <String> [-TaskType] <String> [<CommonParameters>]
```

## DESCRIPTION
Writes a message to the information stream acting as a break between different tasks.
The message is calculated to match the buffer width of the host.

## EXAMPLES

### Example 1
```
PS C:\> Write-TaskHeader -TaskName 'SomeTask' -TaskType 'CustomType'
```

This outputs a message in the format '[----- SomeTask : CustomType -----]'.
The message will fill the width of the host buffer with extra dashes.

## PARAMETERS

### -TaskName
The task name to be displayed.

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

### -TaskType
The type of the task to be displayed.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Write-TaskInfo](Write-TaskInfo.md)
