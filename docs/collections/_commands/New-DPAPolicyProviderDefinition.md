---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# New-DPAPolicyProviderDefinition

## SYNOPSIS
Creates an object defining Provider data for inclusion in a DPA policy.

## SYNTAX

### AWS
```
New-DPAPolicyProviderDefinition [-AWS] [-regions <String[]>] [-tags <PSObject[]>] [-vpcIds <String[]>]
 [-accountIds <String[]>] [-ProviderDefinition <PSObject>] [<CommonParameters>]
```

### Azure
```
New-DPAPolicyProviderDefinition [-Azure] [-regions <String[]>] [-tags <PSObject[]>]
 [-resourceGroups <String[]>] [-vnetIds <String[]>] [-subscriptions <String[]>]
 [-ProviderDefinition <PSObject>] [<CommonParameters>]
```

### OnPrem
```
New-DPAPolicyProviderDefinition [-OnPrem] [-fqdnRulesConjunction <String>] -fqdnRules <PSObject[]>
 [-ProviderDefinition <PSObject>] [<CommonParameters>]
```

### GCP
```
New-DPAPolicyProviderDefinition [-GCP] [-regions <String[]>] [-vpcIds <String[]>] [-labels <PSObject[]>]
 [-projects <String[]>] [-ProviderDefinition <PSObject>] [<CommonParameters>]
```

## DESCRIPTION
Defines the data and criteria for providers supported in DPA.

Target machines matching the criteria will be accessible via a policy containing the definition.

The object output by this function is provided as input for the `providersData` parameter of the `New-DPAPolicy` function.

## EXAMPLES

### Example 1
```powershell
$Provider = New-DPAPolicyProviderDefinition -OnPrem -fqdnRulesConjunction OR -fqdnRules $FQDNrules
```
Creates a provider definition for on-premise connections.

The `$FQDNrules` value is output from the `New-DPAPolicyFQDNRuleDefinition` function.

The `$Provider` variable in the above example is used as input for the `providersData` parameter of the `New-DPAPolicy` function.

### Example 2
```powershell
$Provider = New-DPAPolicyProviderDefinition -AWS -regions "us-east-1","us-east-2" -tags @{"Key"="env";"Value"=@("prod")}
```
Creates a provider definition for AWS connections.

The `$Provider` variable in the above example is used as input for the `providersData` parameter of the `New-DPAPolicy` function.

### Example 3
```powershell
$Provider = New-DPAPolicyProviderDefinition -Azure -regions "eastus2","eastus" -tags @{"Key"="env";"Value"=@("prod")}
```
Creates a provider definition for Azure connections.

The `$Provider` variable in the above example is used as input for the `providersData` parameter of the `New-DPAPolicy` function.

### Example 4
```powershell
$Provider = New-DPAPolicyProviderDefinition -GCP -regions "asia-east1","us-east1" -labels @{"Key"="env";"Value"=@("prod")}
```
Creates a provider definition for GCP connections.

The `$Provider` variable in the above example is used as input for the `providersData` parameter of the `New-DPAPolicy` function.

### Example 5
```powershell
$Provider = New-DPAPolicyProviderDefinition -OnPrem -fqdnRulesConjunction OR -fqdnRules $FQDNrules
$Provider = New-DPAPolicyProviderDefinition -AWS -regions "us-east-1","us-east-2" -tags @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Provider
$Provider = New-DPAPolicyProviderDefinition -Azure -regions "eastus2","eastus" -tags @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Provider
$Provider = New-DPAPolicyProviderDefinition -GCP -regions "asia-east1","us-east1" -labels @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Provider
```
Creates a provider definition for on-premise, AWS, Azure & GCP connections.

The `$FQDNrules` value is output from the `New-DPAPolicyFQDNRuleDefinition` function.

The `$Provider` variable in the above example is used as input for the `providersData` parameter of the `New-DPAPolicy` function.

## PARAMETERS

### -AWS
Specify to define an AWS provider object.

```yaml
Type: SwitchParameter
Parameter Sets: AWS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Azure
Specify to define an Azure provider object.

```yaml
Type: SwitchParameter
Parameter Sets: Azure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GCP
Specify to define a GCP provider object.

```yaml
Type: SwitchParameter
Parameter Sets: GCP
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnPrem
Specify to define an On-Premise provider object.

```yaml
Type: SwitchParameter
Parameter Sets: OnPrem
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProviderDefinition
Add additional data to previous output from `New-DPAPolicyProviderDefinition`.

Used to create defninitions which cover multiple providers to be included in a single DPA policy.

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

### -accountIds
AWS Account IDs.

Leave empty for all AWS Accounts.

```yaml
Type: String[]
Parameter Sets: AWS
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fqdnRules
Accepts output from New-DPAPolicyFQDNRuleDefinition.

List of FQDN rules applied to the connection

```yaml
Type: PSObject[]
Parameter Sets: OnPrem
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -fqdnRulesConjunction
FQDN Rules relationship (AND/OR).

```yaml
Type: String
Parameter Sets: OnPrem
Aliases:
Accepted values: AND, OR

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -labels
A list of key/value pairs that have been defined as custom labels for GCP VMs.

Leave empty for all labels

```yaml
Type: PSObject[]
Parameter Sets: GCP
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -projects
GCP project IDs.

Leave empty for all projects.

```yaml
Type: String[]
Parameter Sets: GCP
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -regions
AWS, Azure or GCP region names.

Leave empty for all regions.

```yaml
Type: String[]
Parameter Sets: AWS, Azure, GCP
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -resourceGroups
A list of Azure resource group IDs.

Leave empty for all resource groups

```yaml
Type: String[]
Parameter Sets: Azure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -subscriptions
Azure subscription IDs.

Leave empty for all subscriptions.

```yaml
Type: String[]
Parameter Sets: Azure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tags
A list of key/value pairs that have been defined as custom tags for Azure VMs or AWS instances.

Leave empty for all tags

```yaml
Type: PSObject[]
Parameter Sets: AWS, Azure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -vnetIds
{{ Fill vnetIds Description }}

```yaml
Type: String[]
Parameter Sets: Azure
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -vpcIds
A list of Azure VNet IDs.

Leave empty for all VNets.

```yaml
Type: String[]
Parameter Sets: AWS, GCP
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

### System.String[]

### System.Management.Automation.PSObject[]

### System.String

### System.Management.Automation.PSObject

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
