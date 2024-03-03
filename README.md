![Logo][Logo]

[Logo]:/docs/media/images/IdentityCommand.DPA.png

# IdentityCommand.DPA

IdentityCommand.DPA [Work in Progress] is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the API for a CyberArk Dynamic Privileged Access from within the PowerShell environment.

- **Prior to a Version 1.0.0 release**:
  - Expect changes
  - Things may break
  - Issues / PRs are encouraged & appreciated

----------

## Project Objective

- To develop & publish consistently coded PowerShell functions for available CyberArk DPA APIs.

## Using the Module

The module requires authentication to the CyberArk Identity platform using the `IdentityCommand` module.

### DPA Authentication

After authentication to an Identity tenant using the `IdentityCommand` module, the `Connect-DPATenant` command is used to initialise a bearer token to be used for module operations against the DPA service:

```powershell
Connect-DPATenant -tenant_url https://sometenant.dpa.cyberark.cloud
```

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

The commands currently available in the _IdentityCommand.DPA_ module are listed here:

| Function                               | Description                                                                      |
|----------------------------------------|----------------------------------------------------------------------------------|
| `Connect-DPATenant`                    | Obtains a Bearer token from an authenticated `IdentityCommand` session for DPA   |
| `Add-DPATargetSet`                     | Adds a DPA Target Set                                                            |
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