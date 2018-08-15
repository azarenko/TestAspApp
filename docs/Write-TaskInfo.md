---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Write-TaskInfo

## SYNOPSIS
Writes a message to the host and information stream.

## SYNTAX

```
Write-TaskInfo [-Message] <Object> [-Tag] <String> [[-TaskName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Writes a message to the information stream. The message is also displayed to the current host.

This is a support function that is intended to be used within a SitecoreInstallFramework task.
The message logged is prefixed with the current executing task name if it can be found.

The task name can be overridden using the -TaskName parameter.

## EXAMPLES

### Example 1
```
PS C:\> Write-TaskInfo -Message 'log this' -Tag 'Context'
```

If this example is called within a function called 'Invoke-MyFunctionTask', the output is:
'[MyFunction]:[Context] log this'

If the example is called from some other function, the output would is:
'[Context] log this'

### Example 2
```
PS C:\> Write-TaskInfo -Message 'log this' -Tag 'Context' -TaskName 'CustomTask'
```

This call outputs: '[CustomTask]:[Context] log this'

## PARAMETERS

### -Message
The message to display in the output.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Tag
The contextual tag for the message.

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

### -TaskName
The optional task name to use.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

[Write-TaskHeader](Write-TaskHeader.md)
