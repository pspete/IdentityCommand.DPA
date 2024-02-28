Function New-DPAPolicyConnectAsDefinition {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AWS'
        )]
        [switch]$AWS,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Azure'
        )]
        [switch]$Azure,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'OnPrem'
        )]
        [switch]$OnPrem,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'GCP'
        )]
        [switch]$GCP,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ssh,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string[]]$assignGroups,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            HelpMessage = 'Add additional data to previous output from New-DPAPolicyConnectAsDefinition.'
        )]
        [PSTypeName('IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs')]
        [psobject]$connectAsDefinition
    )

    Begin {}

    Process {
        $boundParameters = $PSBoundParameters | Get-Parameter -ParametersToRemove AWS, Azure, OnPrem, GCP, connectAsDefinition

        $boundParameters.keys | ForEach-Object {
            $ConnectAsValues = [pscustomobject]@{ }
        } {
            switch ($PSItem) {
                'assignGroups' {
                    $ConnectAsValues | Add-Member -MemberType NoteProperty -Name 'rdp' -Value $(
                        [pscustomobject]@{ 'localEphemeralUser' = [pscustomobject]@{
                                $PSItem = $boundParameters[$PSItem]
                            }
                        }
                    )
                }
                'ssh' {
                    $ConnectAsValues | Add-Member -MemberType NoteProperty -Name 'ssh' -Value $boundParameters[$PSItem]
                }
            }
        } {

            If ($null -ne $connectAsDefinition) {
                $connectAsDefinition | Add-Member -MemberType NoteProperty -Name $PSCmdlet.ParameterSetName -Value $ConnectAsValues -PassThru
            } else {
                [pscustomobject]@{$PSCmdlet.ParameterSetName = $ConnectAsValues } | Add-CustomType -Type IdCmd.DPA.Definition.Policy.UserAccessRule.ConnectAs
            }
        }
    }

    End {}

}