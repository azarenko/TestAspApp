---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-OrConfigFunction

## SYNOPSIS
Performs an OR operation on two or more values.

## SYNTAX

```
Invoke-OrConfigFunction [-Values] <PSObject[]> [<CommonParameters>]
```

## DESCRIPTION
Returns the result of performing and OR operation on two or more values.
The result is always a boolean value (true/false).

Objects are evaluated through standard PowerShell boolean coercion. String
values are trimmed before being evaluated.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-OrConfigFunction -Values 1,2,3
```

Returns true.

### Example 2
```
PS C:\> Invoke-OrConfigFunction -Values '1',' ','2'
```

Returns true.

### Example 3
```
PS C:\> Invoke-OrConfigFunction -Values 0,' ',0
```

Returns false.

## PARAMETERS

### -Values
The values to use in the OR operation.

```yaml
Type: PSObject[]
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

### System.Management.Automation.PSObject[]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

