---
external help file: SitecoreInstallFramework-help.xml
schema: 2.0.0
---

# Invoke-WebDeployTask

## SYNOPSIS
Executes a Web Deploy command.

## SYNTAX

```
Invoke-WebDeployTask [-Verb] <String> [[-Path] <String>] [[-Arguments] <IDictionary>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Supports the execution of Web Deploy commands.
Arguments can be passed as a dictionary to simplify their construction.

All Web Deploy verbs are accepted, along with any provider.

Optionally, the path to a specific installation of msdeploy can be provided. 
The default installation path for 'Microsoft Web Deploy V3' is used ($env:ProgramFiles\iis\Microsoft Web Deploy V3\msdeploy.exe)

## EXAMPLES

### EXAMPLE 1
```
PS C:\> $deployArgs = @{
	Source = 'setAcl'
		Dest = @{
			setAcl = 'SiteName'
			setAclAccess = 'FullControl'
		}
	}
PS C:\> Invoke-WebDeployTask -Verb Sync -Arguments $deployArgs
```

This invokes msdeploy from the default path in the following way:
c:\\\<path\>\msdeploy.exe -verb:Sync -source:setAcl -dest:setAcl='SiteName',setAclAccess-'FullControl'

## PARAMETERS

### -Arguments
Optional arguments to pass to ms deploy. 
See examples and description for details.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: @{}
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path to msdeploy.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: ([IO.Path]::Combine($env:ProgramFiles, 'iis', 'Microsoft Web Deploy V3', 'msdeploy.exe'))
Accept pipeline input: False
Accept wildcard characters: False
```

### -Verb
The Verb to pass to msdeploy

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: delete, dump, getDependencies, getSystemInfo, sync

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

[Web Deploy Command Line Syntax](https://technet.microsoft.com/en-us/library/dd569106(v=ws.10).aspx)
[Export-WebDeployParameters](Export-WebDeployParameters.md)

