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

            It 'outputs expected object - All Days' {
                $UserData = New-DPAPolicyUserDataDefinition -Group -Name 'DEV_TEAM_GROUP'
                $ConnectAs = New-DPAPolicyConnectAsDefinition -AWS -ssh root
                $Object = New-DPAPolicyUserAccessRuleDefinition -ruleName SomeRuleName -userData $UserData -connectAs $ConnectAs -grantAccess 1 -idleTime 5 -timeZone Europe/London
                $Object.RuleName | Should -Be 'SomeRuleName'
                $Object.userData | Should -Be $UserData
                $Object.connectionInformation.connectAs | Should -Be $ConnectAs
                $Object.connectionInformation.grantAccess | Should -Be 1
                $Object.connectionInformation.idleTime | Should -Be 5
                $Object.connectionInformation.timeZone | Should -Be 'Europe/London'
                $Object.connectionInformation.daysOfWeek | Should -HaveCount 7
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule'
            }

            It 'outputs expected object - Some Days' {
                $UserData = New-DPAPolicyUserDataDefinition -Group -Name 'DEV_TEAM_GROUP'
                $ConnectAs = New-DPAPolicyConnectAsDefinition -AWS -ssh root
                $Object = New-DPAPolicyUserAccessRuleDefinition -ruleName SomeRuleName -userData $UserData -connectAs $ConnectAs -grantAccess 1 -idleTime 5 -timeZone Europe/London -daysOfWeek Mon, Tue
                $Object.RuleName | Should -Be 'SomeRuleName'
                $Object.userData | Should -Be $UserData
                $Object.connectionInformation.connectAs | Should -Be $ConnectAs
                $Object.connectionInformation.grantAccess | Should -Be 1
                $Object.connectionInformation.idleTime | Should -Be 5
                $Object.connectionInformation.timeZone | Should -Be 'Europe/London'
                $Object.connectionInformation.daysOfWeek | Should -HaveCount 2
                ($Object | Get-Member).TypeName | Select-Object -Unique | Should -Be 'IdCmd.DPA.Definition.Policy.UserAccessRule'
            }

        }

    }

}