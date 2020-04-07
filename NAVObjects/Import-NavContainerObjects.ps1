Param (
        [Parameter(Mandatory=$true)] [string] $containerName, 
        [Parameter(Mandatory=$false)] [string] $projectFolder = "C:\NAV Projects",
        [Parameter(Mandatory=$false)] [switch] $SubfolderByType
)

$sw = [Diagnostics.Stopwatch]::StartNew()

$importFolder = "C:\ProgramData\NavContainerHelper\Extensions\$containerName\objects"
$sourceFolder = "C:\NAV Projects\$containerName"
$exportFilter = ""
$firstCommit = $true

Remove-Item -Path $importFolder -Force -Recurse -ErrorAction Ignore
    
Import-Module navcontainerhelper -DisableNameChecking

Join

Export-NavContainerObjects `
    -containerName adfin `
    -objectsFolder $importFolder `
    -exportTo "txt folder" `
    -includeSystemObjects `
    -PreserveFormatting `
    -filter $exportFilter

Write-Host "Move files from $importFolder to $sourceFolder."    

if ($SubfolderByType)
{
    $objectTypes = @("Table", "Page", "Report", "Codeunit", "Query", "XMLPort", "MenuSuite")
    foreach ($objectType in $objectTypes)
    {
        New-Item -Path "$sourceFolder\$objectType" `
            -ItemType Directory `
            -Force | Out-Null

        Move-Item -Path "$importFolder\$($objectType.Substring(0, 3).ToUpper())*.txt" `
            -Destination "$sourceFolder\$objectType" `
            -Force
    }
} else {
    Move-Item -Path "$importFolder\*.txt" `
        -Destination $sourceFolder `
        -Force
}

# Commit to the git
if ($firstCommit)
{
    Write-Host "Initializing git with first commit."
    $oldLocation = Get-Location
    Set-Location $sourceFolder
    & git init
    & git add --all
    & git commit -m "First Commit." | Out-Null
    Set-Location $oldLocation.Path
}

$sw.Stop()
Write-Host "Finished in $($sw.Elapsed.Minutes) minutes and $($sw.Elapsed.Seconds) seconds."
Write-Host -ForegroundColor Green "Export completed to folder: $sourceFolder" 