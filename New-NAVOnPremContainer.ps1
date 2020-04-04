<#
.SYNOPSIS
    Business Central Sandbox Container
.DESCRIPTION
    Installes docker container with latest Sandbox image.
.EXAMPLE
    PS C:\> .\New-BCSandboxContainer.ps1 -licenseFile .\license.flf
    Creates docker container with latest image for Sandbox and added licencse file.

    PS C:\> .\New-BCSandboxContainer.ps1 -licenseFile .\license.flf
    Download specific image and creates a docker container.

.NOTES
    Updates NavContainerHelper module.
    Loads docker image.
    Installes Contianer.
    Installes Certificate to Host.
    Installes Test Toolkit.
    Starts web clinet.
#>

Param (
        [Parameter(Mandatory=$false)] [String]$containerName = "nav", 
        [Parameter(Mandatory=$false)] [String]$tagName = "latest", 
        [Parameter(Mandatory=$true)]  [String]$licenseFile
)

.\Install\Install-NAVContainer.ps1 -containerName $containerName `
                        -imageName 'microsoft/dynamics-nav:$tagName' `
                        -licenseFile $licenseFile `
                        -installNAVContainerHelper