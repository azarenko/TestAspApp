---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-HostHeaderTask

## SYNOPSIS
Adds an entry to the system hosts file.

## SYNTAX

```
Invoke-HostHeaderTask [-Hostname] <String> [[-IPAddress] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Checks the hosts file for the entry to add. If it does not exist, it will be added.

A backup of the current hosts file is taken before updating.

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Invoke-HostHeaderTask -Hostname customhost
```

This will add a new host entry of '127.0.0.1 customhost' to the hosts file.

### EXAMPLE 2
```
PS C:\> Invoke-HostHeaderTask -Hostname customhost -IPAddress 192.168.0.5
```

This will add a new host entry of '192.168.0.5 customhost' to the hosts file.

## PARAMETERS

### -Hostname
The hostname to add.

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

### -IPAddress
The IP Address of the host.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: 127.0.0.1
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

