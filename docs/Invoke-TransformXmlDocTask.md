---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-TransformXmlDocTask

## SYNOPSIS
Transforms xml files by providing XML Document Transform files

## SYNTAX

```
Invoke-TransformXmlDocTask [-RootDirectoryPath] <String> [-XdtDirectory] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Transforms xml files by providing XML Document Transform files

## EXAMPLES

### Example 1
```
Invoke-TransformXmlDocTask -RootDirectoryPath "C:\inetpub\wwwroot\sc902" -XdtDirectory "C:\Transforms\MyTransform"
```

This transforms xml files inside root directory by looking at the relative paths of the xml tranformation documents in xdt directory

## PARAMETERS

### -RootDirectoryPath
Root Directory Path

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

### -XdtDirectory
XML Transformation Documents Directory

```yaml
Type: String
Parameter Sets: (All)
Aliases: XmlDelta, XmlTransfrom

Required: True
Position: 1
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

