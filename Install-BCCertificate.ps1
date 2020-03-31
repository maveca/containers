<#
.SYNOPSIS
    Installing Certificate
.DESCRIPTION
    Installes certificate to the host for connecting to protected docker service.
.EXAMPLE
    PS C:\> .\Install-Certificate.ps1 -containerName BC
    Installes certificate to the host.
.NOTES
    Installes certificate to the host.
#>

Param (
        [Parameter(Mandatory=$true)] [String]$containerName 
)

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
