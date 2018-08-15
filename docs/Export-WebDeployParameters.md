---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Export-WebDeployParameters

## SYNOPSIS
Creates a parameters file for a Web Deploy Package

## SYNTAX

```
Export-WebDeployParameters [-Package] <String> [[-OutPath] <String>] [[-Format] <String>] [-Required]
 [[-MsDeployPath] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Given a Web Deploy package, this function extracts the package to a temporary location before searching for a parameters.xml file.
If found, it creates a matching xml file that can be directly passed to Web Deploy or it creates a matching json file to use in configurations.

By default, all parameters and their default values are added to the file.  This can be restricted to the required fields by passing the `-Required` flag.

## EXAMPLES

### Example 1
```
PS C:\> Export-WebDeployParameters -Package c:\webdeploy.zip -OutPath .
```

This will output a webdeploy-parameters<timestamp>.json file to the working directory.
The file will contain all fields with their default values. You can then add this to a configuration.

### Example 2
```
PS C:\> Export-WebDeployParameters -Package c:\webdeploy.zip -OutPath . -Format xml -Required
```

This will output a webdeploy-parameters<timestamp>.xml file to the working directory.
The file will contain only the required parameters. This can be passed directly to web deploy using the `-SetParamFile` argument

## PARAMETERS

### -Format
The format to output the exported parameters.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: json, xml

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MsDeployPath
The path to msdeploy.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutPath
The location to place the completed file.

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

### -Package
The package to be searched.

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

### -Required
If set, only the required parameters are added to the output.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
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

[Invoke-WebDeployTask](Invoke-WebDeployTask.md)

