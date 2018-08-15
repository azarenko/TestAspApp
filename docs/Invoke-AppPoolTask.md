---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-AppPoolTask

## SYNOPSIS
Task to support the creation and modification of an IIS Application Pool.

## SYNTAX

```
Invoke-AppPoolTask [-Name] <String> [[-Properties] <IDictionary>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates or modifies an existing IIS Application Pool. 
If the AppPool does not exist it is created before applying the properties passed to the function.

Properties is a dictionary that will be directly bound to the application pool.
See examples for further information.

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Invoke-AppPoolTask -Name 'NewPool'
```

This creates a new application pool with the name 'NewPool'.

### EXAMPLE 2
```
PS C:\> $properties = @{
            Recycling = @{
                PeriodicRestart = @{
                    Requests = 500
                }
            }
        }
PS C:\> Invoke-AppPoolTask -Name 'NewPool' -Properties $properties
```

This creates a new application pool with the name 'NewPool' and sets the 
Recycling.PeriodicRestart.Requests value to 500.

## PARAMETERS

### -Name
The name of the App Pool to modify.
It is created if it does not exist.

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

### -Properties
The properties to bind to the App Pool.
See examples for further information.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
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

