---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-WebRequestTask

## SYNOPSIS
Requests a web page, with optional retries

## SYNTAX

```
Invoke-WebRequestTask [-Uri] <String> [[-RetryCount] <Int32>] [[-RetryDelay] <Int32>]
 [[-RequestTimeout] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Makes a request to the given URI.  If the request fails, it will be retried a specified
number of times (defaults to five).  The delay between each request can be specified
by RetryDelay.  RequestTimeout can be specified to fail a request if the response is not
served within the timeout.

If a response returns a non-200 status code, the attempt is treated as an error.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-WebRequestTask -Uri http://localhost
```

Requests the localhost site

### Example 2
```
PS C:\> Invoke-WebRequestTask -Uri http://localhost -RetryCount 3
```

Requests the localhost site.  If the site does not return successfully within three
attempts an error is thrown.

## PARAMETERS

### -RequestTimeout
Time in milliseconds allow request to complete.
Defaults to an infinite timeout.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryCount
The number of times to attempt requests to URI.
Defaults to 5.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryDelay
Time in milliseconds to wait between each request.
Defaults to 2000 (two seconds).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
The URI to request

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

