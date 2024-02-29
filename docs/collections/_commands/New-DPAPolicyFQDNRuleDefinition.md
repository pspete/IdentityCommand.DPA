---
external help file: IdentityCommand.DPA-help.xml
Module Name: IdentityCommand.DPA
online version:
schema: 2.0.0
---

# New-DPAPolicyFQDNRuleDefinition

## SYNOPSIS
Defines FQDN rules for On-Prem provider rules asserted in a DPA policy.

## SYNTAX

```
New-DPAPolicyFQDNRuleDefinition [-operator] <String> [-computernamePattern] <String> [-domain] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Defines criteria based on FQDN rules specified in a DPA policy.

Target machines matching the criteria will be accessible via a policy containing the rule(s).

The object output by this function is used as input for the `fqdnRules` parameter of the `New-DPAPolicyProviderDefinition` function.

## EXAMPLES

### Example 1
```powershell
$FQDNrules = New-DPAPolicyFQDNRuleDefinition -operator EXACTLY -computernamePattern SomeHost -domain SomeDomain.com
```

Creates the definition of an FQDN rule to exactly match a virtual machine named SomeHost.SomeDomain.com

The `$FQDNrules` variable in the above example is used as input for the `fqdnRules` parameter of the `New-DPAPolicyProviderDefinition` function.

### Example 2
```powershell
$FQDNrules = @()
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator EXACTLY -computernamePattern SomeHost -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator WILDCARD -computernamePattern '*-DEV-*' -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator SUFFIX -computernamePattern '-Prod' -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator CONTAINS -computernamePattern SQL -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator PREFIX -computernamePattern DC1 -domain SomeDomain.com
```

Creates a definition of FQDN rules to match virtual machines according to the parameter values specified.

The `$FQDNrules` variable in the above example is used as input for the `fqdnRules` parameter of the `New-DPAPolicyProviderDefinition` function.

## PARAMETERS

### -computernamePattern
The pattern to match in relations to the operator

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -domain
The domain in which to execute the operator on the pattern

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -operator
Operator to perform on the FQDN

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: EXACTLY, WILDCARD, PREFIX, SUFFIX, CONTAINS

Required: True
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
