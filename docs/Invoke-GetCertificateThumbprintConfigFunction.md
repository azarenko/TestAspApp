---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-GetCertificateThumbprintConfigFunction

## SYNOPSIS
Returns the thumbprint for the requested certificate.

## SYNTAX

```
Invoke-GetCertificateThumbprintConfigFunction [-Id] <String> [[-CertStorePath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Searches the $CertStorePath for a certificate that matches the given name or thumbprint.
Returns the thumbprint if found.

Returns $null if no certificate can be located.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-GetCertificateConfigFunction -Id 'MyCert'
```

Searches the default certificate path `cert:\LocalMachine\My` for the certificate with
the name `MyCert` and returns the thumbprint.

### Example 2
```
PS C:\> Invoke-GetCertificateConfigFunction -Id '80AE58424A64BAAF7E82764BB9BE79EE27B46A96'
```

Searches the default certificate path `cert:\LocalMachine\My` for the certificate with
the thumbprint `80AE58424A64BAAF7E82764BB9BE79EE27B46A96` and returns the thumbprint.

### Example 3
```
PS C:\> Invoke-GetCertificateConfigFunction -Id 'MyRootCert' -CertStorePath 'cert:\LocaMachine\Root`
```

Searches the certificate path `cert:\LocalMachine\Root` for the certificate with
the name `MyRootCert` and returns the thumbprint.

## PARAMETERS

### -CertStorePath
The certificate path to search for certificates

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Id
The name or thumbprint of the certificate to locate.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

