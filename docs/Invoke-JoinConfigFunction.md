---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-JoinConfigFunction

## SYNOPSIS
Joins a list of values as a single string

## SYNTAX

```
Invoke-JoinConfigFunction [-Values] <PSObject[]> [[-Delimiter] <String>] [<CommonParameters>]
```

## DESCRIPTION
Joins a list of values as a single string.
You can specify the delimiter to use. The default is a comma.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-JoinConfigFunction -Values @(1,2,3)
```

Creates the following string: "1,2,3"

### Example 2
```
PS C:\> Invoke-JoinConfigFunction -Values @(1,2,3) -Delimiter ":"
```

Creates the following string: "1:2:3"

## PARAMETERS

### -Delimiter
The delimiter to use to separate the values.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Values
The values to join as a single string.

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

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

