---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Remove-DPAStrongAccount

## SYNOPSIS
Delete a string account from DPA

## SYNTAX

```
Remove-DPAStrongAccount -secret_id <String> [-database] [<CommonParameters>]
```

## DESCRIPTION
Deletes a configured strong account for either virtual machines or databases

## EXAMPLES

### Example 1
```powershell
Remove-DPAStrongAccount -secret_id 1234-abcd
```

Deletes specified strong account configured for virtual machine

### Example 1
```powershell
Remove-DPAStrongAccount -secret_id 1234-abcd -database
```

Deletes specified strong account configured for database

## PARAMETERS

### -database
Specifies that the strong account relates to a database.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secret_id
The ID of the strong account

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
