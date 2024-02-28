---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Remove-DPAPolicy

## SYNOPSIS
Deletes a policy from DPA

## SYNTAX

```
Remove-DPAPolicy [-policyid] <String> [<CommonParameters>]
```

## DESCRIPTION
Deletes a configured recurring access policy configured in DPA

## EXAMPLES

### Example 1
```powershell
Remove-DPAPolicy -policyid 1234-abcd
```

Deletes specified access policy

## PARAMETERS

### -policyid
The ID of the policy to delete

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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
