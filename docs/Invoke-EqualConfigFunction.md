---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-EqualConfigFunction

## SYNOPSIS
Returns true or false based on the equality of two values.

## SYNTAX

```
Invoke-EqualConfigFunction [-LeftOperand] <PSObject> [-RightOperand] <PSObject> [<CommonParameters>]
```

## DESCRIPTION
Returns the result of calling `-eq` for two values.

Objects are evaluated through standard PowerShell boolean coercion. String
values are trimmed before being evaluated.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-EqualConfigFunction -Operand1 1 -Operand2 2
```

returns false.

### Example 1
```
PS C:\> Invoke-EqualConfigFunction -Operand1 '' -Operand2 '    '
```

returns true.

## PARAMETERS

### -LeftOperand
The left operand for evaluation.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RightOperand
The right operand for evaluation.

```yaml
Type: PSObject
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

