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

        Context 'General Operation' {

            It 'outputs expected object - SSH' {
                $Object = New-DPAPolicyConnectAsDefinition -AWS -ssh root
                $Object.AWS | Should -Not -BeNullOrEmpty
                $Object.AWS.SSH | Should -Be 'root'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs'
            }

            It 'outputs expected object - RDP' {
                $Object = New-DPAPolicyConnectAsDefinition -AWS -assignGroups ADMIN
                $Object.AWS | Should -Not -BeNullOrEmpty
                $Object.AWS.rdp.localEphemeralUser.assignGroups | Should -Be 'ADMIN'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs'
            }

            It 'outputs expected object - SSH + RDP' {
                $Object = New-DPAPolicyConnectAsDefinition -AWS -assignGroups ADMIN -ssh root
                $Object.AWS | Should -Not -BeNullOrEmpty
                $Object.AWS.SSH | Should -Be 'root'
                $Object.AWS.rdp.localEphemeralUser.assignGroups | Should -Be 'ADMIN'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs'
            }

            It 'outputs expected object - Multiple Providers' {
                $Object1 = New-DPAPolicyConnectAsDefinition -AWS -assignGroups ADMIN -ssh root
                $Object = New-DPAPolicyConnectAsDefinition -GCP -ssh root -connectAsDefinition $Object1
                $Object.AWS | Should -Not -BeNullOrEmpty
                $Object.AWS.SSH | Should -Be 'root'
                $Object.AWS.rdp.localEphemeralUser.assignGroups | Should -Be 'ADMIN'
                $Object.GCP | Should -Not -BeNullOrEmpty
                $Object.GCP.SSH | Should -Be 'root'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs'
            }

            It 'outputs expected object - All Providers' {
                $Object1 = New-DPAPolicyConnectAsDefinition -AWS -assignGroups ADMIN -ssh root
                $Object2 = New-DPAPolicyConnectAsDefinition -GCP -ssh root -connectAsDefinition $Object1
                $Object3 = New-DPAPolicyConnectAsDefinition -Azure -ssh root -connectAsDefinition $Object2
                $Object = New-DPAPolicyConnectAsDefinition -OnPrem -assignGroups ADMIN -connectAsDefinition $Object3
                $Object.AWS | Should -Not -BeNullOrEmpty
                $Object.AWS.SSH | Should -Be 'root'
                $Object.AWS.rdp.localEphemeralUser.assignGroups | Should -Be 'ADMIN'
                $Object.GCP | Should -Not -BeNullOrEmpty
                $Object.GCP.SSH | Should -Be 'root'
                $Object.Azure | Should -Not -BeNullOrEmpty
                $Object.Azure.SSH | Should -Be 'root'
                $Object.OnPrem | Should -Not -BeNullOrEmpty
                $Object.OnPrem.rdp.localEphemeralUser.assignGroups | Should -Be 'ADMIN'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs'

            }

        }

    }

}