---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ResolvePathConfigFunction

## SYNOPSIS
Supports resolving file system paths in configurations.

## SYNTAX

```
Invoke-ResolvePathConfigFunction [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
Using this function, you can reference file system paths inside a configuration file.
The value will be resolved when the configuration is compiled.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ResolvePathConfigFunction -Path ..
```

This example resolves the parent directory of the current directory and returns the full directory path.

## PARAMETERS

### -Path
The file system path to resolve.

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

