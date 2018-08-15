---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-EnsurePathTask

## SYNOPSIS
Creates paths or cleans existing paths.

## SYNTAX

```
Invoke-EnsurePathTask [[-Clean] <String[]>] [[-Exists] <String[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
You can us this task to ensure specific file paths are cleaned (that is, all content deleted) or newly created.

If a path to be cleaned does not exist, it will be created instead.

## EXAMPLES

### EXAMPLE 1
```
PS C:\> Invoke-EnsurePathTask -Clean c:\deploy
```

This clears all content from the c:\deploy folder. 
If the folder does not already exist, it will be created.

### EXAMPLE 2
```
PS C:\> Invoke-CommandTask -Exists c:\destination
```

This checks if the path c:\destination exists. 
If it does not exist, it will be created.
If it does exist, no changes will occur.

### EXAMPLE 3
```
PS C:\> Invoke-CommandTask -Clean c:\logs,c:\deploy -Exists c:\destination,c:\backup
```

This cleans and creates multiple paths at the same time.

## PARAMETERS

### -Clean
The paths to be cleaned.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: @()
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exists
The paths to create if they do not exist.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: @()
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

