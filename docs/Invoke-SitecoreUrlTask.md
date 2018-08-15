---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-SitecoreUrlTask

## SYNOPSIS
Makes a request to s specific Sitecore Url.

## SYNTAX

```
Invoke-SitecoreUrlTask [-SitecoreInstanceRoot] <String> [-SitecoreActionPath] <String> [-Username] <String>
 [-Password] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Logs in to a Sitecore instance using the supplied credentials and then requests the specified URL on that instance.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-SitecoreUrlTask -SitecoreInstanceRoot "http://localhost" -SitecoreActionPath "sitecore/admin/showconfig.aspx" -Username "admin" -Password "pass"
```

Logs in to the Sitecore instance at http://localhost and then requests the /sitecore/amdin/showconfig.aspx page.

## PARAMETERS

### -Password
The password for the given Sitecore user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SitecoreActionPath
The URL to request.

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

### -SitecoreInstanceRoot
The root URL of the Sitecore instance.

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

### -Username
The username of the Sitecore account to use.

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

