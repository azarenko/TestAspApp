---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-WebBindingTask

## SYNOPSIS
Creates, updates, and removes web bindings.

## SYNTAX

```
Invoke-WebBindingTask [-SiteName] <String> [[-Add] <PSObject[]>] [[-Remove] <PSObject[]>]
 [[-Update] <PSObject[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Supports adding, removing, and updating web bindings for a site.

You can add, remove, and update bindings at the same time. Changes are applied in the following order:
- Removed
- Added
- Updated

ADDING
When adding bindings, each binding entry must be supplied as an object in the following format:
@{
    HostHeader = <string>
    IPAddress = <string>
    Port = <int>
    Protocol = <string>
    SSlFlags = <int>
    Thumbprint = <string>
}

REMOVING
When removing bindings, each entry must be in the following format:
@{
    HostHeader = <string>
    IPAddress = <string>
    Port = <int>
    Protocol = <string>    
}

Alternatively, you can provide information as: 
@{
    BindingInformation = '<ipaddress>:<port>:<hostheader>'
    Protocol = <string>    
}

Optionally, all bindings can be removed by passing '*' instead of binding information.

UPDATING
When updating bindings, each entry must be in the following format:
@{
    HostHeader = <string>
    IPAddress = <string>
    Port = <int>
    PropertyName = <string>
    Value = <string>
    Thumbprint = <string>
}

Alternatively, you can provide information as :
@{
    BindingInformation = '<ipaddress>:<port>:<hostheader>'
    PropertyName = <string>
    Value = <string>
}

NOTE: The 'propertyname' must be the name of the property to update, for example, HostHeader,IPAddress or Port

## EXAMPLES

### Example 1
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Add @{ Port = 80 }
```

Adds a new web binding to a site.  In this example, the binding matches the default '*:80:' binding.

### Example 2
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Add @{ Port = 443; Protocol = 'https'; Thumbprint = '97A875E0F559AB380C1FDBEF3CB391E5C7ED87BA' }
```

Adds a new https binding to a site. In this example, the binding matches the default '*:443:' binding with a certificate.

### Example 3
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Add @{ HostHeader = 'Example'; IPAddress = '127.0.0.1' }
```

Adds a binding for the localhost address restricted to the hostheader 'Example'.

### Example 4
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Remove * -Add @{ Protocol = 'https' }
```

Removes all existing bindings before adding a default https binding. The binding is set to '*:443:'.

### Example 5
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Remove @{ Protocol = 'http' }
```

Removes all existing bindings that use the 'http' protocol.

### Example 6
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Update @{ Port = 80; PropertyName = 'Port'; Value = 81 }
```

Updates existing bindings using port 80 with an empty hostheader and no assigned IP to use port 81.

### Example 7
```
PS C:\> Invoke-WebBindingTask -SiteName ExampleSite -Update @{ Port = 443; Thumbprint = '97A875E0F559AB380C1FDBEF3CB391E5C7ED87BA' }
```

Updates existing binding on port 443 to use the certificate with thumbprint '97A875E0F559AB380C1FDBEF3CB391E5C7ED87BA'.

## PARAMETERS

### -Add
A collection of bindings to add. 
See function description for the format.


```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Remove
A collection of bindings to remove.
See function description for the format.


```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteName
The name of the site where bindings are modified.

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

### -Update
Bindings that will be updated.
See function description for the format.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
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

