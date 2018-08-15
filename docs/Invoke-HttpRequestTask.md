---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-HttpRequestTask

## SYNOPSIS
Task to support making requests over the Internet.

## SYNTAX

```
Invoke-HttpRequestTask [-Uri] <String> [[-Action] <String>] [[-ContentType] <String>]
 [[-Parameters] <Hashtable>] [[-ExpectedStatusCode] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Invoke-HttpRequestTask cmdlet sents HTTP requests to a given URI. It supports both 'GET' and 'POST' request methods for sending and retrieving data and you can configure it to check for a specific Status code on the response.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-HttpRequestTask -Uri "http://www.somedomain.com"
```

This makes a 'GET' request to the URI 'www.somedomain.com'.

### Example 2
```
PS C:\> Invoke-HttpRequestTask -Uri "http://www.somedomain.com" -Action "POST" -Parameters @{ param1="data" }
```

This makes a 'POST' request to the URI 'www.somedomain.com' using the data in the Parameters as the payload of the request.

### Example 3
```
PS C:\> Invoke-HttpRequestTask -Uri "http://www.somedomain.com" -ExpectedStatusCode 404
```

This makes a 'GET' request to the URI 'www.somedomain.com' and throw an exception if the response status code is not 404.

## PARAMETERS

### -Action
The type of request to make.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: get, post

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ContentType
Sets the 'ContentType' header for the request.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExpectedStatusCode
The status code expected from the response.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parameters
The data to pass in the request.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
Specifies the URI where the HTTP request is being made.

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

