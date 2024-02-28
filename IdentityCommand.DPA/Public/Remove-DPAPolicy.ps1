# .ExternalHelp IdentityCommand.DPA-help.xml
function Remove-DPAPolicy {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$policyid
    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/access-policies/$policyid"

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method DELETE

        if ($null -ne $result) {

            $result

        }

    }#process

    END {

    }#end

}