<#
.SYNOPSIS
    Elevated Permissions
.DESCRIPTION
    This script will test if running script is executed with elevated permission mode.
.EXAMPLE
    PS C:\> .\Install\Test-RunAsAdmin.ps1
    This will fail if it's not true.
#>

# Test if script is running in elevated mode
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
if (!($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)))
{
    Write-Error "Start your PS Shell with Run As Administrator."
}