---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-IfConfigFunction

## SYNOPSIS
Returns a value based on the result of a condition.

## SYNTAX

```
Invoke-IfConfigFunction [-Condition] <PSObject> [-WhenTrue] <PSObject> [-WhenFalse] <PSObject>
 [<CommonParameters>]
```

## DESCRIPTION
Evaluates the given `Condition`, returning `WhenTrue` if the condition is true,
otherwise `WhenFalse` is returned.

Objects passed to `Condition` are evaluated through standard PowerShell boolean
coercion. String values are trimmed before being evaluated.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-IfConfigFunction -Condition $value -WhenTrue 'abc' -WhenFalse 'def'
```

Evaluates `$value` as a boolean. If `$value` is a non-empty string the value
'abc' is returned.  Otherwise the value 'def' will be returned.

## PARAMETERS

### -Condition
The value to check as a boolean.

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

### -WhenFalse
The value returned if `Condition` is found to be `$true`.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhenTrue
The value returned if `Condition` is found to be `$false`.

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

