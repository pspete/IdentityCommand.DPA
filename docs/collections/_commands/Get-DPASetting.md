---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Get-DPASetting

## SYNOPSIS
Get DPA settings

## SYNTAX

```
Get-DPASetting [[-FeatureName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Return details of DPA setting values

## EXAMPLES

### Example 1
```
Get-DPASetting
```

Return all DPA settings

### Example 2
```
Get-DPASetting -FeatureName rdpKeyboardLayout
```

Return setting values relating to RDP keyboard layout

## PARAMETERS

### -FeatureName
The name of the DPA feature to return setting values for

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: mfaCaching, sshMfaCaching, rdpMfaCaching, adbMfaCaching, k8sMfaCaching, sshCommandAudit, standingAccess, rdpFileTransfer, certificateValidation, rdpKeyboardLayout, rdpRecording

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
