---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# New-DPAPolicyConnectAsDefinition

## SYNOPSIS
Define an object to describing ConnectAs configuration for a User Access Rule of a DPA Policy.

## SYNTAX

### AWS
```
New-DPAPolicyConnectAsDefinition [-AWS] [-ssh <String>] [-assignGroups <String[]>]
 [-connectAsDefinition <PSObject>] [<CommonParameters>]
```

### Azure
```
New-DPAPolicyConnectAsDefinition [-Azure] [-ssh <String>] [-assignGroups <String[]>]
 [-connectAsDefinition <PSObject>] [<CommonParameters>]
```

### OnPrem
```
New-DPAPolicyConnectAsDefinition [-OnPrem] [-ssh <String>] [-assignGroups <String[]>]
 [-connectAsDefinition <PSObject>] [<CommonParameters>]
```

### GCP
```
New-DPAPolicyConnectAsDefinition [-GCP] [-ssh <String>] [-assignGroups <String[]>]
 [-connectAsDefinition <PSObject>] [<CommonParameters>]
```

## DESCRIPTION
Outputs an object to be provided as input for the \`connectAs\` parameter of the \`New-DPAPolicyUserAccessRuleDefinition\` function.

The Connect As definition forms part of the User Access Rule defined on a DPA policy.

## EXAMPLES

### Example 1
```
$ConnectAs = New-DPAPolicyConnectAsDefinition -OnPrem -assignGroups Administrators
```

Defines a ConnectAs object which states users connecting via a DPA policy configured with the ConnectAs definition using RDP, will use ephemeral accounts which are added to the the Administrators group for On-Premise Windows servers.

The \`$ConnectAs\` variable in the above example is used as input for the \`connectAs\` parameter of the \`New-DPAPolicyUserAccessRuleDefinition\` function.

### Example 2
```
$ConnectAs = New-DPAPolicyConnectAsDefinition -OnPrem -assignGroups Administrators
$ConnectAs = New-DPAPolicyConnectAsDefinition -AWS -ssh "ec2-user" -assignGroups Administrators, "Remote Desktop Users" -connectAsDefinition $ConnectAs
$ConnectAs = New-DPAPolicyConnectAsDefinition -Azure -ssh "azureuser" -connectAsDefinition $ConnectAs
$ConnectAs = New-DPAPolicyConnectAsDefinition -GCP -ssh "root" -connectAsDefinition $ConnectAs
```

Defines a ConnectAs object which states users connecting via a DPA policy configured with the ConnectAs definition: - Use ephemeral accounts added to the \`Administrators\` group for on-premise windows servers

- Use ephemeral accounts added to the \`Administrators\` & \`Remote Desktop Users\`group for AWS windows servers
- Connect as the \`ec2-user\` local target user for AWS linux servers
- Connect as the \`azureuser\` local target user for Azure linux servers
- Connect as the \`root\` local target user for GCP linux servers

The \`$ConnectAs\` variable in the above example is used as input for the \`connectAs\` parameter of the \`New-DPAPolicyUserAccessRuleDefinition\` function.

## PARAMETERS

### -AWS
Specify to create a connectAs definition for AWS connections

```yaml
Type: SwitchParameter
Parameter Sets: AWS
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Azure
Specify to create a connectAs definition for Azure connections

```yaml
Type: SwitchParameter
Parameter Sets: Azure
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GCP
Specify to create a connectAs definition for GCP connections

```yaml
Type: SwitchParameter
Parameter Sets: GCP
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnPrem
Specify to create a connectAs definition for On-Premise connections

```yaml
Type: SwitchParameter
Parameter Sets: OnPrem
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -assignGroups
Predefined assigned groups of the local ephemeral user on Windows Servers.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -connectAsDefinition
Add additional data to previous output from \`New-DPAPolicyConnectAsDefinition\`.

Used to build a collection of connectAs definitions when multiple rules will be assigned in a policy.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ssh
For SSH connections, the local target user or a personal user template

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.SwitchParameter
### System.String
### System.String[]
### System.Management.Automation.PSObject
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
