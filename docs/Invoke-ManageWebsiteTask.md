---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ManageWebsiteTask

## SYNOPSIS
Task to support the starting and stopping of an IIS web site.

## SYNTAX

```
Invoke-ManageWebsiteTask [-Name] <String> [-Action] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts or stops the specified IIS web site.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ManageWebsiteTask -Name "Default Web Site" -Action "Start"
```

Starts the site named 'Default Web Site'.

### Example 2
```
PS C:\> Invoke-ManageWebsiteTask -Name "Default Web Site" -Action "Stop"
```

Stops the site named 'Default Web Site'.

### Example 3
```
PS C:\> Invoke-ManageWebsiteTask -Name "Default Web Site" -Action "Restart"
```

Restarts the site named 'Default Web Site'.

## PARAMETERS

### -Action
The type of action to perform on the web site.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: start, stop, restart

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
The name of the web site to manage.

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

