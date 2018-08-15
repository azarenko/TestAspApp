---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-SetXmlTask

## SYNOPSIS
Sets values in an XML document.

## SYNTAX

### Add
```
Invoke-SetXmlTask -FilePath <String> -XPath <String> -Element <String> [-Value <String>]
 [-Attributes <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Update
```
Invoke-SetXmlTask -FilePath <String> -XPath <String> [-Value <String>] [-Attributes <Hashtable>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets the value at the given XPath or creates an element and then sets the value.
Optionally, a hashtable of attributes may be provided to set attributes on the
element.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-SetXmlTask -FilePath c:\example.xml -XPath //root/config -Value test
```

Sets the value of //root/config in the file to be 'test'.

### Example 1
```
PS C:\> Invoke-SetXmlTask -FilePath c:\example.xml -XPath //root/config -Attributes @{ extra = 'test' }
```

Adds or updates the //root/config element with an attribute called 'extra' and
a value of 'test'.

### Example 1
```
PS C:\> Invoke-SetXmlTask -FilePath c:\example.xml -XPath //root/config -Element test -value test2 -Attributes @{ extra = 'test3' }
```

Adds a new element at //root/config/text with a value of 'test2' and an 'extra'
attribute with a value of 'test3'.

## PARAMETERS

### -Attributes
A hashtable of attributes to be set or created.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Element
The name of a new element to add.

```yaml
Type: String
Parameter Sets: Add
Aliases: 

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
The path to an XML document.

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

### -Value
The value to set at the given XPath.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -XPath
The XPath to locate in the XML document.

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

