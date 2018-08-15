---
external help file: SitecoreInstallFramework-help.xml
online version: 
schema: 2.0.0
---

# Invoke-JoinPathConfigFunction

## SYNOPSIS
Joins a list of values as a single path

## SYNTAX

```
Invoke-JoinPathConfigFunction [[-Values] <PSObject[]>] [<CommonParameters>]
```

## DESCRIPTION
Joins a list of values as a correctly formatted path.

If passed an array, the array is flattened.
When given an object, the ToString() method will be on the object.

Null and empty strings are ignored.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-JoinPathConfigFunction c: example path
```

Returns the path 'c:\example\path'

### Example 2
```
PS C:\> Invoke-JoinPathConfigFunction @('.\',$null,'abc')
```

Returns the path '.\abc'

### Example 3
```
PS C:\> $obj = [pscustomobject]@{ Value = 'test' }
PS C:\> $obj | Add-Member -Name ToString -MemberType ScriptMethod -Value { $this.Value } -Force
PS C:\> Invoke-JoinPathConfigFunction '.\',$obj,'abc'
```

Returns the path '.\test\abc'

## PARAMETERS

### -Values
The values to join when making a path.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSObject[]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

