<#
.SYNOPSIS
    Split Objects
.DESCRIPTION
    The Command will take the source file and split objects into files for each one.
.EXAMPLE
    PS C:\> .\Split-CALObjects.ps1 -sourceFileName all.txt -destinationPath C:\Temp -modelToolsPath "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\100\RoleTailored Client"
    This will split file all.txt into folder C:\Temp.
    Set the modelToolPath to folder where RoleTailorClient is installed.
#>

Param (
        [Parameter(Mandatory=$true)]  [String]$sourceFileName, 
        [Parameter(Mandatory=$true)]  [String]$destinationPath,
        [Parameter(Mandatory=$true)]  [String]$modelToolsPath
)

Write-Output "Splitting files"
Import-Module -Name "$ModelToolsPath\Microsoft.Dynamics.Nav.Model.Tools.psd1" -Force -DisableNameChecking
Split-NAVApplicationObjectFile -Source $sourceFileName -Destination $destinationPath