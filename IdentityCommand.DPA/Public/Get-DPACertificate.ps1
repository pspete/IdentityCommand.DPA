# .ExternalHelp IdentityCommand.DPA-help.xml
function Get-DPACertificate {
    [CmdletBinding()]
    param(

    )

    BEGIN { }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/certificates"

        #Send Request
        $result = Invoke-IDRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {

            $result.items

        }

    }#process

    END {

    }#end

}