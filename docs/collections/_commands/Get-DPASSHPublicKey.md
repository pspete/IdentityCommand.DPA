---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Get-DPASSHPublicKey

## SYNOPSIS
Return details of SSH Public keys

## SYNTAX

### AWS
```
Get-DPASSHPublicKey [-AWS] [-workspaceId] <String> [-deploymentScript] [<CommonParameters>]
```

### AZURE
```
Get-DPASSHPublicKey [-Azure] [-workspaceId] <String> [-deploymentScript] [<CommonParameters>]
```

### ON-PREMISE
```
Get-DPASSHPublicKey [-OnPrem] [-deploymentScript] [<CommonParameters>]
```

### GCP
```
Get-DPASSHPublicKey [-GCP] [-workspaceId] <String> [-deploymentScript] [<CommonParameters>]
```

## DESCRIPTION
Return SSH CA public key details

## EXAMPLES

### Example 1
```powershell
Get-DPASSHPublicKey -AWS -workspaceId SomeID
```

Get public key details for specified AWS workspace

### Example 2
```powershell
Get-DPASSHPublicKey -AZURE -workspaceId SomeID -deploymentScript
```

Get SSH public key details with SSH key deployment script for specified Azure workspace

## PARAMETERS

### -deploymentScript
Specify to generate an SSH CA public key plus a deployment script for the specified workspace

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspaceId
The workspace ID of the environment

```yaml
Type: String
Parameter Sets: AWS, AZURE, GCP
Aliases: subscription_id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AWS
Specify to target AWS DPA resource identified by `workspaceId`

```yaml
Type: SwitchParameter
Parameter Sets: AWS
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Azure
Specify to target Azure DPA resource identified by `workspaceId`

```yaml
Type: SwitchParameter
Parameter Sets: AZURE
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GCP
Specify to target GCP DPA resource identified by `workspaceId`

```yaml
Type: SwitchParameter
Parameter Sets: GCP
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnPrem
Specify to target On-Premise DPA resource

```yaml
Type: SwitchParameter
Parameter Sets: ON-PREMISE
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
