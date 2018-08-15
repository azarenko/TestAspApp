---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Register-SitecoreInstallExtension

## SYNOPSIS
Registers extensions to use in Sitecore Install Framework configurations.

## SYNTAX

```
Register-SitecoreInstallExtension [-Command] <String> [-As] <String> [-Type] <String> [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
Registers extensions for the Sitecore Install Framework that can then be used in
configurations as tasks or config functions.

## EXAMPLES

### Example 1
```
PS C:\> Register-SitecoreInstallExtension -Command Write-Host -As Write -Type Task
```

Registers the `Write-Host` command as a `Task` called `Write`

### Example 2
```
PS C:\> Register-SitecoreInstallExtension -Command Copy-Item -As Copy -Type Task -Force
```

Registers the `Copy-Item` command as a `Task` called `Copy`. The use of `Force`
will ensure any registered task called `Copy` will be overwritten.

## PARAMETERS

### -As
The identity used to register the command.

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

### -Command
The command to be registered.

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

### -Force
If `true` will overwrite any existing registration with the same id.

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

### -Type
The type of extension to register.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Task, ConfigFunction

Required: True
Position: 2
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

[about_SitecoreInstallFramework](about_SitecoreInstallFramework.md)
[about_SitecoreInstallFramework_Configurations](about_SitecoreInstallFramework_Configurations.md)
[about_SitecoreInstallFramework_Extending](about_SitecoreInstallFramework_Extending.md)
