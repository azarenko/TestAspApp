---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-FilePermissionsTask

## SYNOPSIS
Sets file permissions for a path

## SYNTAX

```
Invoke-FilePermissionsTask [-Path] <String> [[-Rights] <PSObject[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets one or more file permissions for a given path.

File permissions are passed as an object with the following structure:
@{
    User = <string>
    FileSystemRights = <string[]>
    AccessControlType = <string> (optional)
    InheritanceFlags = <string[]> (optional)
    PropagationFlags = <string> (optional)
}

- FileSystemRights: Must be a value from the enumeration System.Security.AccessControl.FileSystemRights.
- AccessControlType: Must be a value from System.Security.AccessControl.AccessControlType. The default is 'Allow'.
- InheritanceFlags: Must be a value from System.Security.AccessControl.InheritanceFlags. The default is 'ContainerInherit','ObjectInherit'.
- PropagationFlags: Must be a value from System.Security.AccessControl.PropagationFlags. The default is 'None'.

You can pass multiple rights objects at the same time.

## EXAMPLES

### Example 1
```
PS C:\> $right = @{User = $env:username; FileSystemRights = 'Read','Write'}
PS C:\> Invoke-FilePermissionsTask -Path c:\examplepath -Rights $right
```

Gives the current user Read and Write permissions to the path c:\examplepath.

### Example 2
```
PS C:\> $right = @{User = $env:username; FileSystemRights = 'Read','Write'; InheritanceFlags = 'ContainerInherit','ObjectInherit'}
PS C:\> Invoke-FilePermissionsTask -Path c:\examplepath -Rights $right
```

Gives the current user Read and Write permissions to the path c:\examplepath and all its children.

## PARAMETERS

### -Path
The path to modify permissions.

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

### -Rights
The collection of rights to apply.

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

