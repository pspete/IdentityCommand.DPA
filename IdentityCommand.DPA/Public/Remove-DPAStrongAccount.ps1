# .ExternalHelp IdentityCommand.DPA-help.xml
function Remove-DPAStrongAccount {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'False Positive')]
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String]$secret_id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'Database'
        )]
        [switch]$database
    )

    BEGIN { }#begin

    PROCESS {

        switch ($PSCmdlet.ParameterSetName) {

            'Database' {
                $URI = "$($ISPSSSession.tenant_url)/api/adb/secretsmgmt/secrets/$secret_id"
                break
            }

            default {
                $URI = "$($ISPSSSession.tenant_url)/api/secrets/$secret_id"
            }
        }

        if ($PSCmdlet.ShouldProcess($secret_id, 'Delete DPA Strong Account')) {
            #Send Request
            $result = Invoke-IDRestMethod -Uri $URI -Method DELETE

            if ($null -ne $result) {

                $result

            }
        }
    }#process

    END {

    }#end

}