---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-UnpackTask

## SYNOPSIS
Extracts an archive file to disk.

## SYNTAX

```
Invoke-UnpackTask [-Source] <String> [-Destination] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Extracts a compressed archive to the given location.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
PS C:\> Invoke-UnpackTask -Source content.zip -Destination c:\unpacked
```

Extracts the contents of 'content.zip' to the destination 'c:\unpacked'.

## PARAMETERS

### -Destination
The destination to extract contents into.

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

### -Source
The archive to be unpacked.

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
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

## OUTPUTS

## NOTES

## RELATED LINKS

