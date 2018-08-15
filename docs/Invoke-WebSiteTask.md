---
external help file: SitecoreInstallFramework-help.xml
schema: 2.0.0
---

# Invoke-WebSiteTask

## SYNOPSIS
Task to support the creation and modification of an IIS website.

## SYNTAX

```
Invoke-WebSiteTask [-Name] <String> [-ApplicationPool] <String> [-PhysicalPath] <String> [[-Hostname] <String>]
 [[-Port] <Int32>] [[-IPAddress] <String>] [[-Properties] <IDictionary>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Creates or modifies an existing IIS website. 
If the website does not exist, it is created before applying the properties passed to the function.

Properties is a dictionary that is directly bound to the website.

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Invoke-WebsiteTask -Name 'NewSite' -ApplicationPool 'NewPool' -PhysicalPath c:\inetpub\newsite
```

This creates a new website named 'NewSite' using the 'NewPool' application pool.
The site's physical path is set to c:\inetpub\newsite.

### EXAMPLE 2
```
PS C:\> Invoke-WebsiteTask -Name 'NewSite' -ApplicationPool 'NewPool' -PhysicalPath c:\inetpub\newsite -Hostname 'Test'
```

This creates a new website named 'NewSite' using the 'NewPool' application pool.
The site's physical path is set to c:\inetpub\newsite.
The site will have a binding with the hostname 'Test'.

### EXAMPLE 3
```
PS C:\> Invoke-WebsiteTask -Name 'NewSite' -ApplicationPool 'NewPool' -PhysicalPath c:\inetpub\newsite -Port 8080
```

This creates a new website named 'NewSite' using the 'NewPool' application pool.
The site's physical path is set to c:\inetpub\newsite.
The site will have a binding with the port set to 8080.

### EXAMPLE 4
```
PS C:\> Invoke-WebsiteTask -Name 'NewSite' -ApplicationPool 'NewPool' -PhysicalPath c:\inetpub\newsite -IPAddress '127.0.0.1'
```

This creates a new website named 'NewSite' using the 'NewPool' application pool.
The site's physical path is set to c:\inetpub\newsite.
The site will have a binding with the IP address set to '127.0.0.1'.

### EXAMPLE 5
```
PS C:\> $properties = @{
            Limits = @{
                ConnectionTimeout = '00:01:00'
            }
        }
PS C:\> Invoke-WebsiteTask -Name 'NewSite' -ApplicationPool 'NewPool' -PhysicalPath c:\inetpub\newsite -Properties $properties
```

This creates the new website and also sets its Limits.ConnectionTimeout property to 1 minute.

## PARAMETERS

### -ApplicationPool
The name of the application pool to set for the site.

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

### -Hostname
The hostname to add to the binding information for the site.

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

### -IPAddress
The IP address to add to the binding information for the site.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: "*"
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the website to be configured.

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

### -PhysicalPath
The path to the website's physical location

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

### -Port
The port number to add to the binding information for the site.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: 80
Accept pipeline input: False
Accept wildcard characters: False
```

### -Properties
Optional properties to bind to the website. 
See the description and examples for details.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: 

Required: False
Position: 6
Default value: @{}
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

