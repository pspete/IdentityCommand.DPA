---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Connect-DPATarget

## SYNOPSIS
Get RDP file for DPA connection

## SYNTAX

### DPA-RDP (Default)
```
Connect-DPATarget -targetAddress <String> [-targetDomain <String>] [<CommonParameters>]
```

### Vaulted-RDP
```
Connect-DPATarget -targetAddress <String> -targetUser <String> [-targetDomain <String>] [-logicalName <String>]
 [-elevatedPrivileges <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Outputs RDP file content for DPA connection.
To be updated to automatically initiate the connection

## EXAMPLES

### Example 1
```
Connect-DPATarget -targetAddress someserver.somedomain.com
```

Generates RDP file for zero standing privilege connection to target

### Example 2
```
Connect-DPATarget -targetAddress sometarget.somedomain.com -targetUser someuser -targetDomain somedomain
```

Generates RDP file for vaulted credential access to target

### Example 3
```
Connect-DPATarget -targetAddress someserver.somedomain.com -targetDomain somedomain
```

Generates RDP file for zero standing privilege connection to cloud instance target

## PARAMETERS

### -targetAddress
The address of the target

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

### -targetUser
The vaulted credential to use

```yaml
Type: String
Parameter Sets: Vaulted-RDP
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -targetDomain
The domain of the user

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -logicalName
The logical network name

```yaml
Type: String
Parameter Sets: Vaulted-RDP
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -elevatedPrivileges
Just-in-time elevation with a vaulted credential

```yaml
Type: Boolean
Parameter Sets: Vaulted-RDP
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
