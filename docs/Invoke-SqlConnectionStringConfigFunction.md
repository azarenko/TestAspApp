---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-SqlConnectionStringConfigFunction

## SYNOPSIS
Creates a Sql connection string

## SYNTAX

```
Invoke-SqlConnectionStringConfigFunction [[-Server] <String>] [[-Database] <String>] [[-UserName] <String>]
 [[-Password] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a correctly formatted connection string to use when connecting to a Sql instance.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-SqlConnectionStringConfigFunction '.\SQL2016' 'sitecore_core'
```

Returns the connection string: 'Data Source=.\Sql2016;Initial Catalog=sitecore_core'

### Example 2
```
PS C:\> Invoke-SqlConnectionStringConfigFunction '.\SQL2016' 'sitecore_core' 'sa' '12345
```

Returns the connection string: 'Data Source=.\Sql2016;Initial Catalog=sitecore_core;User ID=sa;Password=12345'

## PARAMETERS

### -Database
The database to set as the 'Initial Catalog'

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Password
The password for the user.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
The server to set as the 'Data Source'

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
The user to set as the 'User ID'

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
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

