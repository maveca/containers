<#
.SYNOPSIS
    List of images
.DESCRIPTION
    Downloads list of tags for all supported versions.
.EXAMPLE
    PS C:\> .\Get-ImageList.ps1 -name businesscentral/onprem -build 14
    It will list all 14 versions for business central onprem.

    PS C:\> .\Get-ImageList.ps1 -name dynamicsnav -build 2016-cu10
    It will list 2016 cu10 versions for dynamics nav.
    
    PS C:\> .\Get-ImageList.ps1 -name businesscentral/sandbox -all
    It will list all versions for business central sandbox.
#>

Param (
        [ValidateSet('businesscentral/sandbox','businesscentral/onprem','dynamicsnav')]
        [Parameter(Mandatory=$false)] [String]$name = 'businesscentral/sandbox',
        [Parameter(Mandatory=$false)] [String]$build = "latest", 
        [Parameter(Mandatory=$false)] [String]$country = "w1",
        [Parameter(Mandatory=$false)] [String]$platform = "ltsc2019",
        [Parameter(Mandatory=$false)] [switch]$all
)

switch($name) {
    'businesscentral/sandbox'    {$url = "https://mcr.microsoft.com/v2/businesscentral/sandbox/tags/list"} 
    'businesscentral/onprem'     {$url = "https://mcr.microsoft.com/v2/businesscentral/onprem/tags/list"} 
    'dynamicsnav'  {$url = "https://mcr.microsoft.com/v2/dynamicsnav/tags/list"} 
}

Write-Host "Loading from $url (please wait)..."
$response = Invoke-WebRequest $url
$JsonObject = ConvertFrom-Json -InputObject $response.Content

## [build][-country][-platform]]
Write-Host "Selecting images with name: $build*-$country-$platform"
Write-Host
if ($all)
{
    $JsonObject.tags
} else {
    $JsonObject.tags | Where-Object { $_ -Like "$build*-$country-$platform"}  
}
Write-Host