<#
.SYNOPSIS
    Business Central Container
.DESCRIPTION
    Installes Docker Container with Business Central application.
.EXAMPLE
    PS C:\> .\Install\Install-BCContainer.ps1 -containerName bc -imageName "mcr.microsoft.com/businesscentral/sandbox:base" -licenseFile .\license.flf
    Creates docker with added licencse file.
.NOTES
    This script is provided to help execute installation of docker image.
    Docker image is not downloaded. It must be loaded before.
#>

Param (
        [Parameter(Mandatory=$true)]  [String]$containerName, 
        [Parameter(Mandatory=$true)]  [String]$imageName, 
        [Parameter(Mandatory=$true)]  [String]$licenseFile,
        [ValidateSet('Windows','NavUserPassword','UserPassword','AAD')]
        [Parameter(Mandatory=$false)]  [String]$auth='Windows',       
        [Parameter(Mandatory=$false)] [PSCredential]$credential = $null,
        [Parameter(Mandatory=$false)] [Switch]$installNAVContainerHelper = $false,
        [Parameter(Mandatory=$false)] [Switch]$installTestToolkit = $false,
        [Parameter(Mandatory=$false)] [Switch]$installCertificate = $false,
        [Parameter(Mandatory=$false)] [Switch]$installALLanguage = $false,
        [Parameter(Mandatory=$false)] [Switch]$runWebClient = $false
)

# Reporting the process
Write-Host "Command:   Install Docker Container"
Write-Host "Product:   Microsoft Dynamics Business Central"
Write-Host "Container: $containerName"
Write-Host "Image:     $imageName"
Write-Host

# Create credentials
if ($credential -eq $null -and $auth -eq "UserPassword")
{
    $credential = New-Object pscredential 'admin', (ConvertTo-SecureString -String 'admin' -AsPlainText -Force)
}

if ($installNAVContainerHelper) { .\Install\Install-NavContainerHelper.ps1 }

# Install container
Import-Module navcontainerhelper -DisableNameChecking
New-NavContainer -accept_eula `
                    -containerName $containerName `
                    -imageName $imageName `
                    -auth $auth `
                    -credential $credential `
                    -useSSL `
                    -licenseFile $licenseFile `
                    -doNotExportObjectsToText `
                    -accept_outdated `
                    -updateHosts `
                    -includeAL `
                    -useBestContainerOS `
                    -doNotCheckHealth `
                    -assignPremiumPlan

if ($installCertificate) { .\install\Install-BCCertificate.ps1 -containerName $containerName }                    
if ($installALLanguage)  { .\Install\Install-VSCodeALLanguageExtension.ps1 -containerName $containerName }
if ($installTestToolkit) { .\Install\Install-TestToolkit.ps1 -containerName $containerName }
if ($runWebClient)       { Start-Process "https://$containerName/BC" }