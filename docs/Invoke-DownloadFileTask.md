---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-DownloadFileTask

## SYNOPSIS
Task to support the downloading of files from the Internet.

## SYNTAX

```
Invoke-DownloadFileTask [-SourceUri] <String> [-DestinationPath] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The Invoke-DownloadFileTask cmdlet sends HTTP, HTTPS, FTP, and FILE requests to a given URL and saves the downloaded file to a specified destination.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-DownloadFileTask -SourceUrl http://www.somedomain.com/SomeFile.txt -DestinationPath C:\Temp\SomeFile.txt
```

This downloads the file 'SomeFile.txt' from 'www.somedomain.com' and saves it to 'C:\Temp\SomeFile.txt'

## PARAMETERS

### -DestinationPath
Specifies the location for which this cmdlet saves the downloaded file. Enter a path and file name. If you omit the path, the default is the current location.

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

### -SourceUri
Specifies the URL to obtain the file for download.

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

