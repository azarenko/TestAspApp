---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ConcatConfigFunction

## SYNOPSIS
Concatenate values within a configuration

## SYNTAX

```
Invoke-ConcatConfigFunction [[-Values] <PSObject[]>] [<CommonParameters>]
```

## DESCRIPTION
This function supports concatenating multiple values as a single value in a configuration file.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ConcateConfigFunction 1,2,3,4
PS C:\> 1234
```

This example takes a collection of values and concatenates them together.

## PARAMETERS

### -Values
An array of values to be concatenated.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
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

