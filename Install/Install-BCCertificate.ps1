<#
.SYNOPSIS
    Installing Certificate
.DESCRIPTION
    Installes certificate to the host for connecting to protected docker service.
.EXAMPLE
    PS C:\> .\Install\Install-Certificate.ps1 -containerName BC
    Installes certificate to the host.
.NOTES
    Installes certificate to the host.
#>

Param (
        [Parameter(Mandatory=$true)] [String]$containerName 
)

# Elevate privileges for the script.
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{ 
    Write-Output "Starting process with elevated privileges..."
    
    $params = ""
    for ($i=0; $i -lt $PSBoundParameters.Count; $i++)
    {
        $params = "$params -$($PSBoundParameters.Keys[$i]) $($PSBoundParameters.Values[$i])"
    }
    
    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = "powershell"
    $processInfo.Arguments = "& '" + $myinvocation.mycommand.definition + "'" + $params
    $processInfo.Verb = "RunAs"
    $processInfo.RedirectStandardError = $false
    $processInfo.RedirectStandardOutput = $false
    $processInfo.UseShellExecute = $true
    
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $processInfo
    $process.Start() | Out-Null
    $process.WaitForExit()
    
    Write-Output "Process with admin privileges finished."
    Get-Content "$PSScriptRoot\PowerShellTranscript.log"
    Remove-Item "$PSScriptRoot\PowerShellTranscript.log"
    
    Exit $process.ExitCode
} Else {
    Write-Output "Process starting with admin privileges."
    Start-Transcript -Path "$PSScriptRoot\PowerShellTranscript.log"
}

try {
    $certUrl = "http://$($containerName):8080/certificate.cer"
    $certFile = "$PSScriptRoot\$containerName.cer"
    Invoke-WebRequest -Uri $certUrl -OutFile $certFile
    Import-Certificate -FilePath $certFile -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
    Remove-Item $certFile -Force
    Write-Host "Certificate has been succesfully installed to your computer."
}
catch {
    Write-Error "Certificate has been failed to install from $($certURL)"
}