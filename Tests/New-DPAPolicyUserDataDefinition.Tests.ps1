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

            It 'outputs expected object - Role' {
                $Object = New-DPAPolicyUserDataDefinition -Role -Name 'DEV_TEAM_ROLE'
                $Object.Roles | Should -Not -BeNullOrEmpty
                $Object.Users | Should -BeNullOrEmpty
                $Object.Groups | Should -BeNullOrEmpty
                $Object.Roles.Name | Should -Be 'DEV_TEAM_ROLE'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.UserData'
            }

            It 'outputs expected object - User' {
                $Object = New-DPAPolicyUserDataDefinition -User -Name SomeUser
                $Object.Roles | Should -BeNullOrEmpty
                $Object.Users | Should -Not -BeNullOrEmpty
                $Object.Groups | Should -BeNullOrEmpty
                $Object.Users.Name | Should -Be 'SomeUser'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.UserData'
            }

            It 'outputs expected object - Group' {
                $Object = New-DPAPolicyUserDataDefinition -Group -Name 'DEV_TEAM_GROUP'
                $Object.Roles | Should -BeNullOrEmpty
                $Object.Users | Should -BeNullOrEmpty
                $Object.Groups | Should -Not -BeNullOrEmpty
                $Object.Groups.Name | Should -Be 'DEV_TEAM_GROUP'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.UserData'
            }

            It 'outputs expected object - Multiple user/groups/roles' {
                $Object = New-DPAPolicyUserDataDefinition -Role -Name 'DEV_TEAM_ROLE'
                $Object = New-DPAPolicyUserDataDefinition -Role -Name 'SOME_TEAM_ROLE' -UserDataDefinition $Object
                $Object = New-DPAPolicyUserDataDefinition -Group -Name 'DEV_TEAM_GROUP' -UserDataDefinition $Object
                $Object = New-DPAPolicyUserDataDefinition -Group -Name 'SOME_TEAM_GROUP' -UserDataDefinition $Object
                $Object = New-DPAPolicyUserDataDefinition -User -Name SomeUser -UserDataDefinition $Object
                $Object = New-DPAPolicyUserDataDefinition -User -Name SomeOtherUser -UserDataDefinition $Object

                $Object.Roles | Should -Not -BeNullOrEmpty
                $Object.Users | Should -Not -BeNullOrEmpty
                $Object.Groups | Should -Not -BeNullOrEmpty
                $Object.Roles.Name | Should -Contain 'DEV_TEAM_ROLE'
                $Object.Roles.Name | Should -Contain 'SOME_TEAM_ROLE'
                $Object.Groups.Name | Should -Contain 'DEV_TEAM_GROUP'
                $Object.Groups.Name | Should -Contain 'SOME_TEAM_GROUP'
                $Object.Users.Name | Should -Contain 'SomeUser'
                $Object.Users.Name | Should -Contain 'SomeOtherUser'
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule.UserData'
            }

        }

    }

}