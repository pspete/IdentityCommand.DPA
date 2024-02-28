# .ExternalHelp IdentityCommand.DPA-help.xml
function Get-DPAPolicy {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$policyid
    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/access-policies/$policyid"

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            if ($PSBoundParameters.ContainsKey('policyid')) { $result }
            else { $result.items }

        }

    }#process

    END {

    }#end

}