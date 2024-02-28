# .ExternalHelp IdentityCommand.DPA-help.xml
function Remove-DPATargetSet {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String[]]$name
    )

    BEGIN {
        $Request = @{
            'Method' = 'DELETE'
        }
    }#begin

    PROCESS {

        $URI = "$($ISPSSSession.tenant_url)/api/discovery/targetsets"

        if ($name.count -eq 1) {
            $URI = "$URI/$name"
        } elseif ($name.count -gt 1) {
            $URI = "$URI/bulk"
            $boundParameters = $PSBoundParameters | Get-Parameter
            $body = $boundParameters['name'] | ConvertTo-Json
            $Request.Add('Body', $body)
        }

        $Request.Add('Uri', $URI)

        #Send Request
        $result = Invoke-IDRestMethod @Request

        if ($null -ne $result) {
            $result.results
        }

    }#process

    END {

    }#end

}