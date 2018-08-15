---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-IoXmlTask

## SYNOPSIS
Enables, Disables and Deletes configuration files as stated in an IOXML file

## SYNTAX

```
Invoke-IoXmlTask [-RootDirectoryPath] <String> [-IoXmlPath] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enables, Disables and Deletes configuration files as stated in an IOXML file

## EXAMPLES

### Example 1
```
Invoke-IoXmlTask -RootDirectoryPath "C:\inetpub\wwwroot\sc902" -IoXmlPath "C:\sample.ioxml"
```

Update configuration files in "sc902" as stated in sample.ioxml

## PARAMETERS

### -IoXmlPath
IO XML Document

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

