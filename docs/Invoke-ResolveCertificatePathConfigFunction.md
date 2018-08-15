---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ResolveCertificatePathConfigFunction

## SYNOPSIS
Supports resolving file system paths from Certificate store paths in configurations.

## SYNTAX

```
Invoke-ResolveCertificatePathConfigFunction [-CertificatePath] <String> [<CommonParameters>]
```

## DESCRIPTION
Using this function, you can reference Certificate Store file system paths inside a configuration file.
The value will be resolved when the configuration is compiled.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ResolveCertificatePathConfigFunction -CertificatePath Cert:\LocalMachine\My\0000000000000000000000000000000000000000
```

This example resolves the file system directory of the specified Certificate store path.

## PARAMETERS

### -CertificatePath
The certificate store path to resolve.

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

