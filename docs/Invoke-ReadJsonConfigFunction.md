---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ReadJsonConfigFunction

## SYNOPSIS
Reads the contents of a json file.

## SYNTAX

```
Invoke-ReadJsonConfigFunction [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns an object created by reading a json file.
If the json file contains comments, the comments are stripped first.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ReadJsonConfigFunction -Path .\configuration.json
```

Reads the content of the configuration.json file and returns an object that
represents the data in the file.

## PARAMETERS

### -Path
The path to the configuration file.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

