![Logo][Logo]

[Logo]:/docs/media/images/IdentityCommand.DPA.png

# IdentityCommand.DPA

**IdentityCommand.DPA** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the API for a **CyberArk Dynamic Privileged Access** from within the PowerShell environment.

| Main Branch              | Latest Build            | CodeFactor                | Coverage                    |  PowerShell Gallery       |  License                   |
|--------------------------|-------------------------|---------------------------|-----------------------------|---------------------------|----------------------------|
|[![appveyor][]][av-site]  |[![tests][]][tests-site] | [![codefactor][]][cf-site]| [![codecov][]][codecov-link]| [![psgallery][]][ps-site] |[![license][]][license-link]|


[appveyor]:https://ci.appveyor.com/api/projects/status/q2av77njofnsul92/branch/main?svg=true
[av-site]:https://ci.appveyor.com/project/pspete/IdentityCommand-DPA/branch/main
[psgallery]:https://img.shields.io/powershellgallery/v/IdentityCommand.DPA.svg
[ps-site]:https://www.powershellgallery.com/packages/IdentityCommand.DPA
[tests]:https://img.shields.io/appveyor/tests/pspete/IdentityCommand-DPA.svg
[tests-site]:https://ci.appveyor.com/project/pspete/IdentityCommand-DPA
[downloads]:https://img.shields.io/powershellgallery/dt/IdentityCommand.DPA.svg?color=blue
[cf-site]:https://www.codefactor.io/repository/github/pspete/IdentityCommand.DPA
[codefactor]:https://www.codefactor.io/repository/github/pspete/IdentityCommand.DPA/badge
[codecov]:https://codecov.io/gh/pspete/IdentityCommand.DPA/branch/main/graph/badge.svg
[codecov-link]:https://codecov.io/gh/pspete/IdentityCommand.DPA
[license]:https://img.shields.io/github/license/pspete/IdentityCommand.DPA.svg
[license-link]:https://github.com/pspete/IdentityCommand.DPA/blob/main/LICENSE

## Using the Module

The module requires authentication to the CyberArk Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.DPA`.

An overview of some of the features of the module are found in the below sections.

### DPA Authentication

After authentication to an Identity tenant using the `IdentityCommand` module, the `Connect-DPATenant` command is used to initialise a bearer token to be used for module operations against the DPA service:

```powershell
Connect-DPATenant -tenant_url https://sometenant.dpa.cyberark.cloud
```

### DPA Connections

The `Connect-DPATarget` command can be use to initiate DPA connections to targets.

#### SSH

SSH connections to targets using the DPA zero standing privilege method can be achieved with the following example:
```powershell
Connect-DPATarget -SSH -targetAddress someserver.somedomain.com
```

SSH connections to targets using vaulted credentials follow a similar pattern:
```powershell
Connect-DPATarget -SSH -targetAddress sometarget.somedomain.com -targetUser someuser -targetDomain somedomain
```

For SSH connections to succeed, an SSH client must be available from the terminal in which the command is being executed.

#### RDP

`Connect-DPATarget` can also request RDP files which can be used to connected through he DPA gateway, the following example facilitates a zero standing privilege RDP connection:
```powershell
Connect-DPATarget -RDP -targetAddress someserver.somedomain.com
```

Vaulted credentials can also be used for RDP connections, as shown in the below example:
```powershell
Connect-DPATarget -RDP -targetAddress sometarget.somedomain.com -targetUser someuser -targetDomain somedomain
```

### DPA Policies
DPA recurring access policies can be created after defining PowerShell objects to help create the policy configuration.

A number of helper functions are included in the module which can be used to provide the required data to the `New-DPAPolicy` command.

A complete example to create a new policy follows:

```powershell
#Create ConnectAs definitions for the policy userAccessRules
$ConnectAs1 = New-DPAPolicyConnectAsDefinition -OnPrem -assignGroups Administrators
$ConnectAs1 = New-DPAPolicyConnectAsDefinition -AWS -ssh "ec2-user" -assignGroups Administrators, "Remote Desktop Users" -connectAsDefinition $ConnectAs
$ConnectAs2 = New-DPAPolicyConnectAsDefinition -Azure -ssh "azureuser" -connectAsDefinition $ConnectAs
$ConnectAs2 = New-DPAPolicyConnectAsDefinition -GCP -ssh "root" -connectAsDefinition $ConnectAs

#Create User Data definitions for the policy user AccessRules
$UserData1 = New-DPAPolicyUserDataDefinition -Role -name "DEV_TEAM_ROLE"
$UserData1 = New-DPAPolicyUserDataDefinition -Role -name "SOME_TEAM_ROLE" -UserDataDefinition $UserData1
$UserData1 = New-DPAPolicyUserDataDefinition -Group -name "DEV_TEAM_GROUP" -UserDataDefinition $UserData1
$UserData2 = New-DPAPolicyUserDataDefinition -Group -name "SOME_TEAM_GROUP" -UserDataDefinition $UserData1
$UserData2 = New-DPAPolicyUserDataDefinition -User -name SomeUser -UserDataDefinition $UserData2
$UserData2 = New-DPAPolicyUserDataDefinition -User -name SomeOtherUser -UserDataDefinition $UserData2

#Create AccessRules definitions for the policy using the ConnectAs & User Data definitions
$AccessRules = @()
$AccessRules += New-DPAPolicyUserAccessRuleDefinition -ruleName SomeAccessRule -userData $UserData1 -connectAs $ConnectAs1 -timeZone Europe/London
$AccessRules += New-DPAPolicyUserAccessRuleDefinition -ruleName AnotherAccessRule -userData $UserData2 -connectAs $ConnectAs2 -timeZone America/Costa_Rica

#Define FQDN Rules for connections to On-Prem resources
$FQDNrules = @()
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator EXACTLY -computernamePattern SomeHost -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator WILDCARD -computernamePattern *-DEV-* -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator SUFFIX -computernamePattern '-Prod' -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator CONTAINS -computernamePattern SQL -domain SomeDomain.com
$FQDNrules += New-DPAPolicyFQDNRuleDefinition -operator PREFIX -computernamePattern DC1 -domain SomeDomain.com

#Create Provider definitions for connections to on-prem and cloud resources
$Providers = New-DPAPolicyProviderDefinition -OnPrem -fqdnRulesConjunction OR -fqdnRules $FQDNrules
$Providers = New-DPAPolicyProviderDefinition -AWS -regions "us-east-1","us-east-2" -tags @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Providers
$Providers = New-DPAPolicyProviderDefinition -Azure -regions "eastus2","eastus" -tags @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Providers
$Providers = New-DPAPolicyProviderDefinition -GCP -regions "asia-east1","us-east1" -labels @{"Key"="env";"Value"=@("prod")} -ProviderDefinition $Providers

#Create the new DPA Policy using the Provider and Access Rule definitions previously created
New-DPAPolicy -policyName SomePolicy -status Enabled -description "Some Description" -providersData $Providers -userAccessRules $AccessRules
```

Running the code above creates a complete policy with settings according to the parameter values.


### Module Scope Variables & Command  Invocation Data

The `Get-DPAModuleData` command can be used to return data from the module scope:

```powershell
PS C:\> Get-DPAModuleData

Name                           Value
----                           -----
tenant_url                     https://abc1234.dpa.cyberark.cloud
User                           some.user@somedomain.com
TenantId
SessionId
WebSession                     Microsoft.PowerShell.Commands.WebRequestSession
StartTime                      12/02/2024 22:58:13
ElapsedTime                    00:25:30
LastCommand                    System.Management.Automation.InvocationInfo
LastCommandTime                12/02/2024 23:23:07
LastCommandResults             {"success":true,"Result":{"SomeResult"}}
```

Executing this command exports variables like the URL, Username & WebSession object for the authenticated session from IdentityCommand.DPA into your local scope, either for use in other requests outside of the module scope, or for informational purposes.

Return data also includes details such as session start time, elapsed time, last command time, as well as data for the last invoked command and the results of the previous command.

## List Of Commands

The examples provided above are not exhaustive, further commands enabling configuration and administration of the DPA platform are available in the module.

The full list of commands currently available in the _`IdentityCommand.DPA`_ module are detailed here:

| Function                               | Description                                                                      |
|----------------------------------------|----------------------------------------------------------------------------------|
| `Connect-DPATenant`                    | Obtains a Bearer token from an authenticated `IdentityCommand` session for DPA   |
| `Connect-DPATarget`                    | Get RDP file for connection to DPA target                                        |
| `Add-DPATargetSet`                     | Adds a DPA Target Set                                                            |
| `Get-DPACertificate`                   | Get details of DPA certificates                                                  |
| `Get-DPAConnector`                     | Get details of DPA connectors                                                    |
| `Get-DPAConnectorSetupScript`          | Gets setup scripts for DPA connectors                                            |
| `Get-DPAPolicy`                        | Gets configured DPA policies                                                     |
| `Get-DPAModuleData`                    | Outputs data relating to the `IdentityCommand.DPA` module session                |
| `Get-DPASetting`                       | Get DPA settings                                                                 |
| `Get-DPASession`                       | Get DPA session diagnostic event data                                            |
| `Get-DPASSHPublicKey`                  | Get DPA SSH Public Keys                                                          |
| `Get-DPAStrongAccount`                 | Get details of configured string accounts                                        |
| `Get-DPATargetSet`                     | Get details of configured target sets                                            |
| `Get-DPAResource`                      | Get details of configured resources                                              |
| `New-DPAPolicy`                        | Configures a new DPA recurring access policy                                     |
| `New-DPAPolicyConnectAsDefinition`     | Defines ConnectAs profile for DPA policy                                         |
| `New-DPAPolicyFQDNRuleDefinition`      | Defines FQDN Rules for DPA Policy                                                |
| `New-DPAPolicyProviderDefinition`      | Defines Providers for DPA Policy                                                 |
| `New-DPAPolicyUserAccessRuleDefinition`| Defines user access rules for DPA Policy                                         |
| `New-DPAPolicyUserDataDefinition`      | Defines user data for DPA Policy                                                 |
| `New-DPAStrongAccount`                 | Creates a new string account in DPA                                              |
| `Remove-DPAPolicy`                     | Deletes a DPA policy                                                             |
| `Remove-DPAStrongAccount`              | Deletes a DPA string account                                                     |
| `Remove-DPATargetSet`                  | Deletes a DPA target set                                                         |
| `Set-DPAPolicy`                        | Updates a DPA policy                                                             |
| `Set-DPASetting`                       | Update DPA settings                                                              |

## Installation

### Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- A CyberArk Identity tenant with the Dynamic Privileged Access service enabled
- An Account to Access CyberArk Identity

### Install Options

Users can install IdentityCommand.DPA from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name IdentityCommand.DPA -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `IdentityCommand.DPA`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/IdentityCommand.DPA/):
  - Run the PowerShell command `Save-Module -Name IdentityCommand.DPA -Path C:\temp`
  - Copy the `C:\temp\IdentityCommand.DPA` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.DPA Release

- [Download the latest GitHub release](https://github.com/pspete/IdentityCommand.DPA/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `IdentityCommand.DPA-v#.#.#` folder to `IdentityCommand.DPA`
  - Copy the `IdentityCommand.DPA` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.DPA Branch

- [Download the `main` branch](https://github.com/pspete/IdentityCommand.DPA/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `IdentityCommand.DPA` (`\<Archive Root>\IdentityCommand.DPA-master\IdentityCommand.DPA`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable IdentityCommand.DPA

```

Import the module:

```powershell

Import-Module IdentityCommand.DPA

```

List Module Commands:

```powershell

Get-Command -Module IdentityCommand.DPA

```

Get detailed information on specific commands:

```powershell

Get-Help New-IDSession -Full

```

## Sponsorship

Please support continued development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

_IdentityCommand.DPA_ is neither developed nor supported by CyberArk; any official support channels offered by the vendor are not appropriate for seeking help with the _IdentityCommand.DPA_ module.

Help and support should be sought by [opening an issue][new-issue].

[new-issue]: https://github.com/pspete/IdentityCommand.DPA/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspete@pspete.dev">contact us</a> to discuss options.

![Logo][Logo]