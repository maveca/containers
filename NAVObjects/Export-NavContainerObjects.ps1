Param (
        [Parameter(Mandatory=$true)] [string] $containerName, 
        [Parameter(Mandatory=$false)] [string] $projectFolder = "C:\NAV Projects",
        [Parameter(Mandatory=$false)] [switch] $SubfolderByType
)

$sw = [Diagnostics.Stopwatch]::StartNew()

$exportFolder = "C:\ProgramData\NavContainerHelper\Extensions\$containerName\objects"
$destinationFolder = "C:\NAV Projects\$containerName"
$exportFilter = ""
$firstCommit = $true

Remove-Item -Path $exportFolder -Force -Recurse -ErrorAction Ignore

New-Item -Path $exportFolder `
    -ItemType Directory `
    -Force | Out-Null

New-Item -Path $destinationFolder `
    -ItemType Directory `
    -Force | Out-Null
    
$directoryInfo = Get-ChildItem $destinationFolder | Measure-Object
if ($directoryInfo.count -gt 0) # there are no files exported
{
    $exportFilter = 'modified=Yes'
    $firstCommit = $false
}

if ($firstCommit)
{
    Write-Host -ForegroundColor Yellow "Exporting all objects for the first time..."
    Write-Host "It might take some minutes." 
} else {
    Write-Host "Exporting modified objects..." 
}

Import-Module navcontainerhelper -DisableNameChecking

Export-NavContainerObjects `
    -containerName adfin `
    -objectsFolder $exportFolder `
    -exportTo "txt folder" `
    -includeSystemObjects `
    -PreserveFormatting `
    -filter $exportFilter

Write-Host "Move files from $exportFolder to $destinationFolder."    

if ($SubfolderByType)
{
    $objectTypes = @("Table", "Page", "Report", "Codeunit", "Query", "XMLPort", "MenuSuite")
    foreach ($objectType in $objectTypes)
    {
        New-Item -Path "$destinationFolder\$objectType" `
            -ItemType Directory `
            -Force | Out-Null

        Move-Item -Path "$exportFolder\$($objectType.Substring(0, 3).ToUpper())*.txt" `
            -Destination "$destinationFolder\$objectType" `
            -Force
    }
} else {
    Move-Item -Path "$exportFolder\*.txt" `
        -Destination $destinationFolder `
        -Force
}

# Commit to the git
if ($firstCommit)
{
    Write-Host "Initializing git with first commit."
    $oldLocation = Get-Location
    Set-Location $destinationFolder
    & git init
    & git add --all
    & git commit -m "First Commit." | Out-Null
    Set-Location $oldLocation.Path
}

$sw.Stop()
Write-Host "Finished in $($sw.Elapsed.Minutes) minutes and $($sw.Elapsed.Seconds) seconds."
Write-Host -ForegroundColor Green "Export completed to folder: $destinationFolder" 