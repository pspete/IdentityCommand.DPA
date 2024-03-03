# .ExternalHelp IdentityCommand.DPA-help.xml
function Connect-DPATarget {
    [CmdletBinding(DefaultParameterSetName = 'DPA-RDP')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'DPA-RDP'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Vaulted-RDP'
        )]
        [String]$targetAddress,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Vaulted-RDP'
        )]
        [String]$targetUser,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'DPA-RDP'
        )]
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Vaulted-RDP'
        )]
        [String]$targetDomain,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Vaulted-RDP'
        )]
        [String]$logicalName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Vaulted-RDP'
        )]
        [bool]$elevatedPrivileges

    )

    BEGIN {
        $Properties = @{}
    }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/adb/sso/acquire"

        #Get request parameters
        $boundParameters = $PSBoundParameters | Get-Parameter

        switch ($PSCmdlet.ParameterSetName) {
            { $PSItem -match 'RDP$' } {
                $Properties.Add('service', 'DPA-RDP')
                $Properties.Add('tokenResponseFormat', 'extended')
                $Properties.Add('tokenType', 'rdp_file')
                $Properties.Add('tokenParameters', $boundParameters)
            }
        }
        #Create body
        $body = $Properties | ConvertTo-Json

        $result = Invoke-IDRestMethod -Uri $URI -Method POST -Body $body

        if ($null -ne $result) {

            $result.token.text

        }

    }#process

    END { }#end

}