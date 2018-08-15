---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ManageSolrCoreTask

## SYNOPSIS
Manages changes to the cores of an existing Solr instance.

## SYNTAX

```
Invoke-ManageSolrCoreTask [-Action] <String> [-Address] <String> [[-Arguments] <IDictionary>]
 [[-RetryCount] <Int32>] [[-RetryDelay] <Int32>] [[-RequestTimeout] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Modifies cores for a Solr instance.
You can use this task to add and remove cores for a given Solr instance.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ManageSolrCoreTask -Action "Create" -Address "http://localhost:8983:/solr" -Arguments @{ Name = "core0" }
```

Creates a new core called 'core0' on the Solr instance at 'http://localhost:8983:/solr'.

### Example 2
```
PS C:\> Invoke-ManageSolrCoreTask -Action "Unload" -Address "http://localhost:8983:/solr" -Arguments @{ Core = "core0" }
```

Removes an existing core called 'core0' on the Solr instance at 'http://localhost:8983:/solr'.

## PARAMETERS

### -Action
The type of Solr command to execute.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: create, unload

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Address
The address of the Solr instance.

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

### -Arguments
The parameters to pass to the Solr command being executed.

```yaml
Type: IDictionary
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequestTimeout
{{Fill RequestTimeout Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryCount
{{Fill RetryCount Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RetryDelay
{{Fill RetryDelay Description}}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
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

[Solr Core API](https://cwiki.apache.org/confluence/display/solr/CoreAdmin+API)