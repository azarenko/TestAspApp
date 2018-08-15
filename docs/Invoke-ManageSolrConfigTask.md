---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ManageSolrConfigTask

## SYNOPSIS
Manages changes to the configuration of a core on an existing Solr instance.

## SYNTAX

```
Invoke-ManageSolrConfigTask [-Address] <String> [-CoreName] <String> [[-Config] <PSObject>]
 [[-RetryCount] <Int32>] [[-RetryDelay] <Int32>] [[-RequestTimeout] <Int32>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Modifies the core configuration for a Solr instance.
You can use this task to update the configuration for a core on a given Solr instance.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ManageSolrConfigTask -Address "http://localhost:8983:/solr" -CoreName "core0" -Config @{
	'add-requesthandler' = @{
		name = "/new_query"
		class = "solr.SearchHandler"
		defaults = @{
			echoParams = "explicit"
			wt = "json"
			indent = true
		}
	}
}
```

Adds a new request handler called 'new_query' to 'core0' on the Solr instance at 'http://localhost:8983:/solr'.

## PARAMETERS

### -Address
The address of the Solr instance.

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

### -Config
The configuration JSON to use.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CoreName
The name of the Solr core to modify the configuration for.

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

