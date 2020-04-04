# Business Central Containers

This powershell scripts will help you build containers for following products:

- Microsoft Dynamics Business Central - Sandbox
- Microsoft Dynamics Business Central - OnPrem
- Microsoft Dynamics NAV - OnPrem

## How to start

1. Clone this project to your local disk.
   - Create new folder on your local disk, for example C:\PowerShell\BC.
   - Open command prompt and place your current directory to newly created folder.
     - `C:\> cd "C:\PowerShell\BC"` 
   - Now download the copy from github.
     - `C:\PowerShell\BC> git clone https://github.com/maveca/containers.git`

2. Open a tool for running scripts. Those are the options:
   - [Windows PowerShell ISE](https://www.microsoft.com/en-us/download/details.aspx?id=45885)
   - [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701)
   - [VS Code](https://code.visualstudio.com/Download) with powershell extension.

3. Download licence file to this directory.

4. Use scripts from the root directory.
   - `PS C:\> .\New-BCSandboxContainer.ps1 -licenseFile .\license.flf`

5. Now and then use this script to get latest version of this scrips.
   - `PS C:\> .\Get-LatestVersion.ps1`

## Remarks

This scripts uses NAVContainerHelper module.
They are prepared to avoid common problems when using this scripts such as updating new version of NAVContainerHelper.
If you exclude all parameters except `-licenseFile` you should receive the latest version of product.
