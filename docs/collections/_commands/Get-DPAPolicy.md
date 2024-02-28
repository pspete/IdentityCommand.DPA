---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Get-DPAPolicy

## SYNOPSIS
Get details of policies from DPA

## SYNTAX

```
Get-DPAPolicy [[-policyid] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns details of all policies or a specific policy from DPA

## EXAMPLES

### Example 1
```powershell
Get-DPAPolicy
```

Get details of all policies from DPA

### Example 1
```powershell
Get-DPAPolicy -policyid 1234-abcd
```

Get details of specific policy from DPA

## PARAMETERS

### -policyid
The ID of a policy to get details of

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
