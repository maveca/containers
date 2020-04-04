<#
.SYNOPSIS
    Restore database
.DESCRIPTION
    For restoring database in container.
.EXAMPLE
    PS C:\> .\Database\Restore-Database.ps1 -containerName bc
    Restores database in container bc from backup file.
#>

Param (
        [Parameter(Mandatory=$true)]  [String]$containerName, 
        [Parameter(Mandatory=$true)]  [Switch]$installNAVContainerHelper 
)


if ($installNAVContainerHelper) { .\Install\Install-NavContainerHelper.ps1 }
Import-Module navcontainerhelper -DisableNameChecking

Backup-NavContainerDatabases -containerName $containerName
