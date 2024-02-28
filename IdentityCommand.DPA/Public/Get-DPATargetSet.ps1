# .ExternalHelp IdentityCommand.DPA-help.xml
function Get-DPATargetSet {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$b64StartKey,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$strongAccountId
    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/discovery/targetsets"

        $QueryString = $($PSBoundParameters | Get-Parameter | ConvertTo-QueryString)

        If ($null -ne $QueryString) {
            $URI = "$URI`?$QueryString"
        }

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            if ($null -ne $result.b64_last_evaluated_key) {
                ##TODO Result Pagination
            }

            $result.target_sets

        }

    }#process

    END {

    }#end

}