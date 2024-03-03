Describe $($PSCommandPath -Replace '.Tests.ps1') {

    BeforeAll {
        #Get Current Directory
        $Here = Split-Path -Parent $PSCommandPath

        #Assume ModuleName from Repository Root folder
        $ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

        #Resolve Path to Module Directory
        $ModulePath = Resolve-Path "$Here\..\$ModuleName"

        #Define Path to Module Manifest
        $ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

        if ( -not (Get-Module -Name $ModuleName -All)) {

            Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

        }

    }

    InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

        BeforeEach {

            $ISPSSSession = [ordered]@{
                tenant_url         = 'https://somedomain.dpa.cyberark.cloud'
                User               = $null
                TenantId           = 'SomeTenant'
                SessionId          = 'SomeSession'
                WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
                StartTime          = $null
                ElapsedTime        = $null
                LastCommand        = $null
                LastCommandTime    = $null
                LastCommandResults = $null
            }
            New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force

            Mock Invoke-IDRestMethod -MockWith {
                [pscustomobject]@{'target_set' = 'value' }
            }

            Mock Get-DPAPolicy -MockWith {
                [pscustomobject]@{
                    'policyId'        = 'SomeID'
                    'policyName'      = 'SomePolicy'
                    'status'          = 'SomeStatus'
                    'description'     = 'Some Description'
                    'providersData'   = @{'provider' = 'data' }
                    'startDate'       = '1925-10-08'
                    'endDate'         = '2023-01-22'
                    'userAccessRules' = @(@{'Access' = 'Rule' })
                }
            }

            $ConnectAs1 = New-DPAPolicyConnectAsDefinition -OnPrem -assignGroups Administrators
            $ConnectAs1 = New-DPAPolicyConnectAsDefinition -AWS -ssh 'ec2-user' -assignGroups Administrators, 'Remote Desktop Users' -connectAsDefinition $ConnectAs1
            $ConnectAs2 = New-DPAPolicyConnectAsDefinition -Azure -ssh 'azureuser' -connectAsDefinition $ConnectAs1
            $ConnectAs2 = New-DPAPolicyConnectAsDefinition -GCP -ssh 'root' -connectAsDefinition $ConnectAs2

            $UserData = New-DPAPolicyUserDataDefinition -Role -Name 'DEV_TEAM_ROLE'
            $UserData = New-DPAPolicyUserDataDefinition -Role -Name 'SOME_TEAM_ROLE' -UserDataDefinition $UserData
            $UserData = New-DPAPolicyUserDataDefinition -Group -Name 'DEV_TEAM_GROUP' -UserDataDefinition $UserData
            $UserData = New-DPAPolicyUserDataDefinition -Group -Name 'SOME_TEAM_GROUP' -UserDataDefinition $UserData
            $UserData = New-DPAPolicyUserDataDefinition -User -Name SomeUser -UserDataDefinition $UserData
            $UserData = New-DPAPolicyUserDataDefinition -User -Name SomeOtherUser -UserDataDefinition $UserData

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
            $Providers = New-DPAPolicyProviderDefinition -AWS -regions 'us-east-1', 'us-east-2' -tags @{'Key' = 'env'; 'Value' = @('prod') } -ProviderDefinition $Providers
            $Providers = New-DPAPolicyProviderDefinition -Azure -regions 'eastus2', 'eastus' -tags @{'Key' = 'env'; 'Value' = @('prod') } -ProviderDefinition $Providers
            $Providers = New-DPAPolicyProviderDefinition -GCP -regions 'asia-east1', 'us-east1' -labels @{'Key' = 'env'; 'Value' = @('prod') } -ProviderDefinition $Providers


        }

        Context 'Input - General' {
            BeforeEach {
                Set-DPAPolicy -policyId SomeID -status Enabled

            }
            It 'sends request' {

                Assert-MockCalled Invoke-IDRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {

                    $URI -eq 'https://somedomain.dpa.cyberark.cloud/api/access-policies/SomeID'

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

            }

            It 'Gets existing settings' {
                Assert-MockCalled Get-DPAPolicy -Times 1 -Exactly -Scope It
            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.PolicyName -eq 'SomePolicy'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.status -eq 'Enabled'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.description -eq 'Some Description'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.StartDate -eq '1925-10-08'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.EndDate -eq '2023-01-22'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData -ne $null

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules -ne $null

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request body with expected providersData' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.Provider -eq 'data'

                } -Times 1 -Exactly -Scope It

            }

            It 'sends request body with expected userAccessRules' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[0].Access -eq 'Rule'

                } -Times 1 -Exactly -Scope It

            }

        }

        Context 'Input - Providers Update' {
            BeforeEach {
                Set-DPAPolicy -policyId 1234-abcd -providersData $Providers
            }

            It 'sends request body with expected providersData' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    ($Request.providersData.OnPrem.fqdnRules.computernamePattern).count -eq 5

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.OnPrem.fqdnRules.computernamePattern -contains 'SomeHost'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.OnPrem.fqdnRules.computernamePattern -contains '*-DEV-*'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.OnPrem.fqdnRules.computernamePattern -contains '-Prod'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.OnPrem.fqdnRules.computernamePattern -contains 'SQL'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.OnPrem.fqdnRules.computernamePattern -contains 'DC1'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.AWS.tags.key -eq 'env'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.Azure.tags.key -eq 'env'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.providersData.GCP.labels.key -eq 'env'

                } -Times 1 -Exactly -Scope It

            }
        }

        Context 'Input - User Access Rule Update' {
            BeforeEach {
                Set-DPAPolicy -policyId 1234-abcd -userAccessRules $AccessRules
            }

            It 'sends request with expected userAccessRules' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[0].ruleName -eq 'SomeAccessRule'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[1].ruleName -eq 'AnotherAccessRule'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[0].connectionInformation.connectAs.OnPrem.rdp.localEphemeralUser.assignGroups -eq 'Administrators'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[0].connectionInformation.connectAs.AWS.ssh -eq 'ec2-user'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[1].connectionInformation.connectAs.AWS.rdp.localEphemeralUser.assignGroups -contains 'Administrators'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.userAccessRules[1].connectionInformation.connectAs.AWS.rdp.localEphemeralUser.assignGroups -contains 'Remote Desktop Users'

                } -Times 1 -Exactly -Scope It
            }

        }
    }

}