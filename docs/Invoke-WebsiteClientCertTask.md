---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-WebsiteClientCertTask

## SYNOPSIS
Configures client certificate settings for a website.

## SYNTAX

```
Invoke-WebsiteClientCertTask [-SiteName] <String> [-Setting] <String> [-Ssl] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Configures the client certificate requirements for a website.
With this command you can ignore, accept or require client certificates during requests to confirm client identities.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-WebsiteClientCertTask -SiteName XConnect -Setting Ignore
```

Configures the website `XConnect` to ignore client certificates.

### Example 2
```
PS C:\> Invoke-WebsiteClientCertTask -SiteName XConnect -Setting Accept -Ssl
```

Configures the website `XConnect` to accept client certificates and require SSl.

### Example 3
```
PS C:\> Invoke-WebsiteClientCertTask -SiteName XConnect -Setting Require
```

Configures the website `XConnect` to require client certificates.
When `Require` is chosen for the setting, SSL is also required.

## PARAMETERS

### -Setting
The setting to apply to the website.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Ignore, Accept, Require

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
The site where settings will be applied.

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

### -Ssl
Enforce SSL.
Will be enforce if `Require` is chosen for `Setting`.

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
https://technet.microsoft.com/en-us/library/cc753983(v=ws.10).aspx

## RELATED LINKS

