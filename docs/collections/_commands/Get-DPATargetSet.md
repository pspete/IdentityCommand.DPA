---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Get-DPATargetSet

## SYNOPSIS
Get details of target sets from DPA

## SYNTAX

```
Get-DPATargetSet [[-b64StartKey] <String>] [[-name] <String>] [[-strongAccountId] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Get details of all target sets, target sets associated with a specific strong account, or a specific target set.

## EXAMPLES

### Example 1
```
Get-DPATargetSet
```

Get all target sets from DPA

### Example 2
```
Get-DPATargetSet -name somename
```

Get a specific target set from DPA

### Example 1
```
Get-DPATargetSet -strongAccountId 1234-abcd
```

Get all target sets for a specific strong account from DPA

## PARAMETERS

### -b64StartKey
Used for result paging - specify to return target sets starting from a specific record

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The name of a target set to get details of

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -strongAccountId
The ID of a string account to return target details for

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
