<#
.SYNOPSIS
    Backup database
.DESCRIPTION
    For backing up database in container.
.EXAMPLE
    PS C:\> .\Database\Backup-Database.ps1 -containerName bc
    Creates backup of database in bc container.
#>

Param (
        [Parameter(Mandatory=$true)]  [String]$containerName, 
        [Parameter(Mandatory=$true)]  [Switch]$installNAVContainerHelper 
)


if ($installNAVContainerHelper) { .\Install\Install-NavContainerHelper.ps1 }
Import-Module navcontainerhelper -DisableNameChecking

Restore-DatabasesInNavContainer -containerName $containerName