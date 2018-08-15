---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-ManageSolrSchemaTask

## SYNOPSIS
Manages changes to the schema of an existing Solr core.

## SYNTAX

### Args (Default)
```
Invoke-ManageSolrSchemaTask -Address <String> -Core <String> -Arguments <PSObject> [-RetryCount <Int32>]
 [-RetryDelay <Int32>] [-RequestTimeout <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### ArgsFile
```
Invoke-ManageSolrSchemaTask -Address <String> -Core <String> -ArgumentsFile <String> [-RetryCount <Int32>]
 [-RetryDelay <Int32>] [-RequestTimeout <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Modifies the schema of an existing Solr core by using the Solr schema API.
For more information on the arguments that can be used, see the Solr documentation: https://cwiki.apache.org/confluence/display/solr/Schema+API

## EXAMPLES

### Example 1
```
PS C:\> Invoke-ManageSolrSchemaTask -Address "http://localhost:8983:/solr" -Core sitecore_master_index -Arguments @{ 
    'replace-dynamic-field' = @(
        @{
            name: '*_s',
            type: 'lowercase',
            stored: $false,
            indexed: $true
        }
    )
}
```

Replaces the dynamic field `*_s` with new properties

### Example 2
```
PS C:\> Invoke-ManageSolrSchemaTask -Address "http://localhost:8983:/solr" -Core sitecore_master_index -ArgumentsFile c:\schema.json
```

Invokes the command using with arguments sources from the file `c:\schema.json`

## PARAMETERS

### -Address
The address of the Solr instance.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Arguments
The parameters to pass to Solr.

```yaml
Type: PSObject
Parameter Sets: Args
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ArgumentsFile
The path to the file containing schema arguments.

```yaml
Type: String
Parameter Sets: ArgsFile
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Core
The name of the core that will be modified.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: Named
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
Position: Named
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
Position: Named
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
Position: Named
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

[Solr Schema API](https://cwiki.apache.org/confluence/display/solr/Schema+API)