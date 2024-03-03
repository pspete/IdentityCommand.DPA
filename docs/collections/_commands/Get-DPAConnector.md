---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# Get-DPAConnector

## SYNOPSIS
Get DPA connector details

## SYNTAX

```
Get-DPAConnector [[-connector_id] <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns details of all DPA connectors, or a specific DPA connector which providing a connector ID.

## EXAMPLES

### Example 1
```
Get-DPAConnector
```

Get details of all configured DPA connectors

### Example 1
```
Get-DPAConnector -connector_id SomeConnectorID
```

Get details of the DPA connector with the ID SomeConnectorID

## PARAMETERS

### -connector_id
The ID of a connector to query

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
