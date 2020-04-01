<#
.SYNOPSIS
    Business Central Sandbox Container
.DESCRIPTION
    Installes docker container with latest Sandbox image.
.EXAMPLE
    PS C:\> .\New-BCSandboxContainer.ps1 -licenseFile .\license.flf
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
        [Parameter(Mandatory=$false)] [String]$containerName = "fin", 
        [Parameter(Mandatory=$false)] [String]$imageName = "microsoft/dynamics-nav:2016-cu4", 
        [Parameter(Mandatory=$true)]  [String]$licenseFile
)

.\Install-NAVContainer.ps1 -containerName $containerName `
                        -imageName $imageName `
                        -licenseFile $licenseFile `
                        -installNAVContainerHelper