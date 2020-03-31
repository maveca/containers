<#
.SYNOPSIS
    Business Central Insider Container
.DESCRIPTION
    Installes docker container with latest insider image.
.EXAMPLE
    PS C:\> .\New-BCInsiderContainer.ps1 -licenseFile .\license.flf
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
        [Parameter(Mandatory=$false)] [String]$containerName = "insider", 
        [Parameter(Mandatory=$false)] [String]$imageName = "bcinsider.azurecr.io/bcsandbox-master:base-ltsc2019", 
        [Parameter(Mandatory=$true)]  [String]$licenseFile,
        [Parameter(Mandatory=$false)] [PSCredential]$credential = $null,
        [Parameter(Mandatory=$false)] [Switch]$installTestToolkit = $false,
        [Parameter(Mandatory=$false)] [Switch]$installALLanguage = $false
)

# Load image
docker login "bcinsider.azurecr.io" -u "2151f4c8-8fc2-4c87-a360-4f6c73ed8636" -p "6=8EOnWN7yqV7?H/u?301O6nP05grB:N"
docker pull $imageName
docker logout

.\Install-BCContainer.ps1 -containerName $containerName `
                        -imageName $imageName `
                        -licenseFile $licenseFile `
                        -credential $credential `
                        -installNAVContainerHelper `
                        -installTestToolkit:$installTestToolkit `
                        -installALLanguage:$installALLanguage `
                        -installCertificate `
                        -runWebClient