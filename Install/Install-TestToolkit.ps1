<#
.SYNOPSIS
    Installing Test Toolkit
.DESCRIPTION
    Installes Test Toolkit to the container.
.EXAMPLE
    PS C:\> .\Install\Install-TestToolkit.ps1 -containerName BC
    Installes Test Toolkit to the container.
.NOTES
    Installes Test Toolkit to the container.
#>

Param (
        [Parameter(Mandatory=$true)] [String]$containerName 
)

Import-Module navcontainerhelper
Import-TestToolkitToNavContainer -containerName $containerName