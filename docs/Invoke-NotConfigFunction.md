---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-NotConfigFunction

## SYNOPSIS
Returns the logical opposite of the given value.

## SYNTAX

```
Invoke-NotConfigFunction [-Value] <PSObject> [<CommonParameters>]
```

## DESCRIPTION
Using standard PowerShell coercion the given value is types as a boolean before
returning the logical opposite value.

Objects are evaluated through standard PowerShell boolean coercion. String
values are trimmed before being evaluated.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-NotConfigFunction -Value 1
```

Returns false.

### Example 2
```
PS C:\> Invoke-NotConfigFunction -Value ''
```

Returns true.

## PARAMETERS

### -Value
The value to be evaluated.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

