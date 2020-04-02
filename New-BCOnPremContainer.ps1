<#
.SYNOPSIS
    Business Central OnPrem Container
.DESCRIPTION
    Installes docker container with latest OnPrem image.
.EXAMPLE
    PS C:\> .\New-BCOnPremContainer.ps1 -licenseFile .\license.flf
    Creates docker with added licencse file.
.NOTES
    Tests script if running in elevated mode.
    Updates NavContainerHelper module.
    Loads docker image.
    Installes Contianer.
    Installes Certificate to Host.
    Installes Test Toolkit.
    Starts web clinet.
#>

Param (
        [Parameter(Mandatory=$false)] [String]$containerName = "onprem", 
        [Parameter(Mandatory=$false)] [String]$imageName = "mcr.microsoft.com/businesscentral/onprem:base", 
        [Parameter(Mandatory=$true)]  [String]$licenseFile,
        [Parameter(Mandatory=$false)] [PSCredential]$credential = $null,
        [Parameter(Mandatory=$false)] [Switch]$installTestToolkit,
        [Parameter(Mandatory=$false)] [Switch]$installALLanguage
)

.\Install\Install-BCContainer.ps1 -containerName $containerName `
                        -imageName $imageName `
                        -licenseFile $licenseFile `
                        -credential $credential `
                        -installNAVContainerHelper `
                        -installTestToolkit:$installTestToolkit `
                        -installALLanguage:$installALLanguage `
                        -installCertificate `
                        -runWebClient