---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Get-SitecoreInstallExtension

## SYNOPSIS
Returns information on the extensions registered with the Sitecore Install Framework.

## SYNTAX

```
Get-SitecoreInstallExtension [[-Path] <String>] [[-Type] <String>] [<CommonParameters>]
```

## DESCRIPTION
Fetches all tasks and config functions that are registered with the Sitecore
Install Framework.

By default, only those that are part of the framework itself are returned.
Passing the path to a configuration file will also return the extensions
registered when that configuration is executed.

## EXAMPLES

### Example 1
```
PS C:\> Get-SitecoreInstallExtension
```

Will return all tasks and config functions registered by default.

### Example 2
```
PS C:\> Get-SitecoreInstallExtension -Type Task
```

Will return all tasks registered by default.

### Example 1
```
PS C:\> Get-SitecoreInstallExtension -Path c:\configs\example.json
```

Will return all task and config functions registered by default or through the
given configuration.

## PARAMETERS

### -Path
The path to a Sitecore Install Framework configuration.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type
The type of extensions to return.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Task, ConfigFunction

Required: False
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

