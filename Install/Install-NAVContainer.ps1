<#
.SYNOPSIS
    Dynamics NAV Container
.DESCRIPTION
    Installes Docker Container with Dynamics NAV application.
.EXAMPLE
    PS C:\> .\Install-NAVContainer.ps1 -containerName bc -imageName "mcr.microsoft.com/businesscentral/sandbox:base" -licenseFile .\license.flf
    Creates docker with added licencse file.
.NOTES
    This script is provided to help execute installation of docker image.
    Docker image is not downloaded. It must be loaded before.
#>

Param (
        [Parameter(Mandatory=$true)]  [String]$containerName, 
        [Parameter(Mandatory=$true)]  [String]$imageName, 
        [Parameter(Mandatory=$true)]  [String]$licenseFile,
        [Parameter(Mandatory=$false)] [Switch]$installNAVContainerHelper = $false
)

# Reporting the process
Write-Host "Command:   Install Docker Container"
Write-Host "Product:   Microsoft Dynamics NAV"
Write-Host "Container: $containerName"
Write-Host "Image:     $imageName"
Write-Host

if ($installNAVContainerHelper) { .\Install\Install-NavContainerHelper.ps1 }

# Install container
Import-Module navcontainerhelper -DisableNameChecking
New-NavContainer -accept_eula `
                    -containerName $containerName `
                    -imageName $imageName `
                    -auth Windows `
                    -licenseFile $licenseFile `
                    -doNotExportObjectsToText `
                    -accept_outdated `
                    -updateHosts `
                    -includeCSIDE `
                    -useBestContainerOS `
                    -doNotCheckHealth
