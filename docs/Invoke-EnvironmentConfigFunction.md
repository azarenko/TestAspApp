---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-EnvironmentConfigFunction

## SYNOPSIS
Supports referencing of environment variables in configurations

## SYNTAX

```
Invoke-EnvironmentConfigFunction [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
Using this function, you can reference environment variables inside a configuration file.
The value is resolved when the configuration is compiled.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-EnvironmentConfigFunction SystemDrive
PS C:\> C:\
```

This example resolves the environment system drive.

## PARAMETERS

### -Name
The name of the environment variable to resolve.

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

