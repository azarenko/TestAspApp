---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-IISConfigurationTask

## SYNOPSIS
Configures an IIS Configuration property

## SYNTAX

```
Invoke-IISConfigurationTask [-SiteName] <String> [-ConfigPath] <String> [-Key] <String> [-Value] <Object>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets a key/value configuration setting at a specific configuration path for a website.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-IISConfigurationTask -SiteName SC1 -ConfigPath 'system.webServer/serverRuntime' -Key 'uploadReadAheadSize' -Value 491520000
```

Sets the `uploadReadAheadSize` for the `SC1` site to a value of `491520000`

## PARAMETERS

### -ConfigPath
The IIS Configuration path to set.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
The property to set at the configuration path.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
The name of the site to be updated.

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

### -Value
The value to set.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
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

