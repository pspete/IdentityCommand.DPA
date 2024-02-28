---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Get-DPAStrongAccount

## SYNOPSIS
Get string account details from DPA

## SYNTAX

### VirtualMachines (Default)
```
Get-DPAStrongAccount [-secret_type <String[]>] [<CommonParameters>]
```

### Databases
```
Get-DPAStrongAccount [-databases] [<CommonParameters>]
```

## DESCRIPTION
Get details of configured string accounts for either virtual machines or databases

## EXAMPLES

### Example 1
```powershell
Get-DPAStrongAccount
```

Get all virtual machine strong accounts

### Example 2
```powershell
Get-DPAStrongAccount -secret_type PCloudAccount
```

Get all virtual machine strong accounts which are vaulted in Privilege Cloud

### Example 3
```powershell
Get-DPAStrongAccount -databases
```

Get all database strong accounts

## PARAMETERS

### -databases
Specify to return string accounts for databases

```yaml
Type: SwitchParameter
Parameter Sets: Databases
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secret_type
Specify to filter the type of virtual machine strong account to get details for.

```yaml
Type: String[]
Parameter Sets: VirtualMachines
Aliases:
Accepted values: ProvisionerUser, PCloudAccount, IdentityUser, IdentityMgmtUser, TargetCertificate, General

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]

### System.Management.Automation.SwitchParameter

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
