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
                [pscustomobject]@{
                    'token' = [pscustomobject]@{'text' = 'value' }
                }
            }

        }

        Context 'Input - RDP - Vaulted Creds' {
            BeforeEach {
                $response = Connect-DPATarget -targetUser SomeUser -targetAddress SomeCPU -targetDomain SomeDomain -logicalName SomeNet -elevatedPrivileges $true
            }
            It 'sends request' {

                Assert-MockCalled Invoke-IDRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {

                    $URI -eq 'https://somedomain.dpa.cyberark.cloud/api/adb/sso/acquire'

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.service -eq 'DPA-RDP'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenResponseFormat -eq 'extended'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenType -eq 'rdp_file'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenParameters.targetUser -eq 'SomeUser'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenParameters.targetAddress -eq 'SomeCPU'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenParameters.targetDomain -eq 'SomeDomain'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenParameters.logicalName -eq 'SomeNet'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenParameters.elevatedPrivileges -eq $true

                } -Times 1 -Exactly -Scope It

            }

        }

        Context 'Input - RDP - ZSP' {
            BeforeEach {
                $response = Connect-DPATarget -targetAddress SomeCPU
            }
            It 'sends request' {

                Assert-MockCalled Invoke-IDRestMethod -Times 1 -Exactly -Scope It

            }

            It 'sends request to expected endpoint' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {

                    $URI -eq 'https://somedomain.dpa.cyberark.cloud/api/adb/sso/acquire'

                } -Times 1 -Exactly -Scope It

            }

            It 'uses expected method' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

            }

            It 'sends request with expected body' {

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.service -eq 'DPA-RDP'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenResponseFormat -eq 'extended'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenType -eq 'rdp_file'

                } -Times 1 -Exactly -Scope It

                Assert-MockCalled Invoke-IDRestMethod -ParameterFilter {
                    $Request = $Body | ConvertFrom-Json
                    $Request.tokenParameters.targetAddress -eq 'SomeCPU'

                } -Times 1 -Exactly -Scope It

            }

        }

    }

}