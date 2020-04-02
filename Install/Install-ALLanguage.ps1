<#
.SYNOPSIS
    Install AL Language
.DESCRIPTION
    Installes AL Language extension to Visual Studio Code of version that matches the container.
.EXAMPLE
    PS C:\> .\Install\Install-ALLanguage.ps1 -containerName BC
    Installs correct version of AL Language 
#>

Param (
        [Parameter(Mandatory=$true)] [String]$containerName
)

# Find vsix vsix file, download and install on host.
$requestUri = "http://$($containerName):8080";
try {
    $response = Invoke-WebRequest $requestUri
    $elements = $response.ParsedHtml.body.getElementsByTagName('A')
    foreach ($element in $elements) {
        $ext = [System.IO.Path]::GetExtension($element.pathname)
        if ($ext -eq ".vsix") {
            $vsixUrl = "http://$($containerName):8080/$($element.pathname)"
            Write-Host "Downloading $($vsixUrl) file..." 
            $vsixFile = "$PSScriptRoot\$($element.pathname)"
            # Download file from docker
            (New-Object Net.WebClient).DownloadFile($vsixUrl, $vsixFile)
            # Uninstall previous version
            & code --uninstall-extension "Microsoft.al"
            # Install new one
            & code --install-extension $vsixFile
            # Remove file
            Remove-Item $vsixFile -Force
        }
    }
} catch {
    Write-Error "Cannot connect to $($requestUri) or cannot find vsix file to download."
}