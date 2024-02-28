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

```
Get-DPASSHPublicKey [-workspaceId] <String> [-workspaceType] <String> [-deploymentScript] [<CommonParameters>]
```

## DESCRIPTION
Return SSH CA public key details

## EXAMPLES

### Example 1
```powershell
Get-DPASSHPublicKey -workspaceId SomeID -workspaceType AWS
```

Get public key details for specified workspace

### Example 2
```powershell
Get-DPASSHPublicKey -workspaceId SomeID -workspaceType AZURE -deploymentScript
```

Get SSH public key details for specified workspace and SSH key deployment script

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
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspaceType
The workspace type of workspaceId

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: AWS, AZURE, ON-PREMISE, GCP

Required: True
Position: 1
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
