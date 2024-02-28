---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# New-DPAPolicy

## SYNOPSIS
Create a new DPA policy

## SYNTAX

```
New-DPAPolicy [-policyName] <String> [[-status] <String>] [[-description] <String>]
 [[-providersData] <PSObject>] [[-startDate] <DateTime>] [[-endDate] <DateTime>]
 [[-userAccessRules] <PSObject[]>] [<CommonParameters>]
```

## DESCRIPTION
Creates new DPA policy using the details specified for any parameters

## EXAMPLES

### Example 1
```powershell
New-DPAPolicy -policyName Some-Policy-Name
```

Creates a draft policy with no settings

### Example 2
```powershell
New-DPAPolicy -policyName Some-Policy-Name -status Enabled -description "Policy Description" `
-providersData $providersData -startDate (Get-Date) -endDate (Get-Date).AddDays(7) `
-userAccessRules $userAccessRules
```

Creates an enabled policy, valid for 7 days with settings according to the parameter values.

`$providersData` object is created using the `New-DPAPolicyProviderDefinition` command

`$userAccessRules` object is created using the `New-DPAPolicyUserAccessRuleDefinition` command

### Example 3
```powershell
New-DPAPolicy -policyName Some-Policy-Name -status Enabled -description "Policy Description" `
-providersData $providersData  -userAccessRules $userAccessRules
```

Creates an enabled policy with settings according to the parameter values.

`$providersData` object is created using the `New-DPAPolicyProviderDefinition` command

`$userAccessRules` object is created using the `New-DPAPolicyUserAccessRuleDefinition` command

### Example 4
```powershell
New-DPAPolicy -policyName Some-Policy-Name -status Draft -providersData $providersData
```

Creates a draft policy with settings according to the parameter values.

`$providersData` object is created using the `New-DPAPolicyProviderDefinition` command

### Example 5
```powershell
New-DPAPolicy -policyName Some-Policy-Name -status Draft -userAccessRules $userAccessRules
```

Creates a draft policy with settings according to the parameter values.

`$userAccessRules` object is created using the `New-DPAPolicyUserAccessRuleDefinition` command

### Example 6
```powershell
$ConnectAs = New-DPAPolicyConnectAsDefinition -OnPrem -assignGroups Administrators
$ConnectAs = New-DPAPolicyConnectAsDefinition -AWS -ssh "ec2-user" -assignGroups Administrators, "Remote Desktop Users" -connectAsDefinition $ConnectAs
$ConnectAs = New-DPAPolicyConnectAsDefinition -Azure -ssh "azureuser" -connectAsDefinition $ConnectAs
$ConnectAs = New-DPAPolicyConnectAsDefinition -GCP -ssh "root" -connectAsDefinition $ConnectAs

$UserData = New-DPAPolicyUserDataDefinition -Role -name "DEV_TEAM_ROLE"
$UserData = New-DPAPolicyUserDataDefinition -Role -name "SOME_TEAM_ROLE" -UserDataDefinition $UserData
$UserData = New-DPAPolicyUserDataDefinition -Group -name "DEV_TEAM_GROUP" -UserDataDefinition $UserData
$UserData = New-DPAPolicyUserDataDefinition -Group -name "SOME_TEAM_GROUP" -UserDataDefinition $UserData
$UserData = New-DPAPolicyUserDataDefinition -User -name SomeUser -UserDataDefinition $UserData
$UserData = New-DPAPolicyUserDataDefinition -User -name SomeOtherUser -UserDataDefinition $UserData

$AccessRules = @()
$AccessRules += New-DPAPolicyUserAccessRuleDefinition -ruleName SomeAccessRule -userData $UserData1 -connectAs $ConnectAs1 -timeZone Europe/London
$AccessRules += New-DPAPolicyUserAccessRuleDefinition -ruleName AnotherAccessRule -userData $UserData2 -connectAs $ConnectAs2 -timeZone America/Costa_Rica

$FQDNrules = @()
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator EXACTLY -computernamePattern SomeHost -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator WILDCARD -computernamePattern *-DEV-* -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator SUFFIX -computernamePattern '-Prod' -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator CONTAINS -computernamePattern SQL -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator PREFIX -computernamePattern DC1 -domain SomeDomain.com

$Providers = New-DPAPolicyProviderDefinition -OnPrem -fqdnRulesConjunction OR -fqdnRules $FQDNrules
$Providers = New-DPAPolicyProviderDefinition -AWS -regions "us-east-1","us-east-2" -tags @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Providers
$Providers = New-DPAPolicyProviderDefinition -Azure -regions "eastus2","eastus" -tags @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Providers
$Providers = New-DPAPolicyProviderDefinition -GCP -regions "asia-east1","us-east1" -labels @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Providers

New-DPAPolicy -policyName SomePolicy -status Enabled -description "Some Description" -providersData $Providers -userAccessRules $AccessRules
```

Creates a complete policy with settings according to the parameter values.

## PARAMETERS

### -description
A description for the policy

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -endDate
The end date for the policy

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -policyName
A name for the policy

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

### -providersData
Accepts object output from New-DPAPolicyProviderDefinition.

Describes the configuration relating to the providers for the policy

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -startDate
The date the policy is valid from

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
The status of the policy

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Enabled, Disabled, Draft, Expired

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userAccessRules
Accepts object output from New-DPAPolicyUserAccessRuleDefinition.

Describes the user access rules configured on the policy

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Management.Automation.PSObject

### System.DateTime

### System.Management.Automation.PSObject[]

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
