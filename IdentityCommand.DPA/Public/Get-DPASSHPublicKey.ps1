# .ExternalHelp IdentityCommand.DPA-help.xml
function Get-DPASSHPublicKey {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$workspaceId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]

        [ValidateSet('AWS', 'AZURE', 'ON-PREMISE', 'GCP')]
        [String]$workspaceType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [switch]$deploymentScript
    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/public-keys"
        $QueryString = $($PSBoundParameters | Get-Parameter -ParametersToRemove deploymentScript | ConvertTo-QueryString)

        If ($deploymentScript.IsPresent) {
            $URI = "$URI/scripts"
        }

        $URI = "$URI?$QueryString"

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            $result

        }

    }#process

    END {

    }#end

}