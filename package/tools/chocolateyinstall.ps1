# win32-openssh install

$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.5.0.0p1-Beta/OpenSSH-Win32-v9.5.0.0.msi'
$urlPackage64 = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.5.0.0p1-Beta/OpenSSH-Win64-v9.5.0.0.msi'
$checksumPackage = '8537f2b1133678713aac39c0a97a1c61846356ed1a2ea77c3d2954213c6f1c3b144a2e1d09587995a0ca11a094cc6d6ae459f34aeaaa008a7be1d9e54bdb2163'
$checksumPackage64 = '7ee69039b564c742aca707819ab6bad886ff8056e27e1cdfa39f5a8ce06618c0fa3c45ff3481a3234b32fe3765f99efae7458016a23c289839ddda688a9c768e'
$checksumTypePackage = 'SHA512'

$args = ""

if ($PackageParameters) {

    if ($PackageParameters["server"] -and $PackageParameters["client"]) {
        Write-Host "Installing SSH Server and Client"
    }
    elseif ($PackageParameters["server"]) {
        Write-Host "Installing only SSH Server"
        $args = "ADDLOCAL=Server"
    }
    elseif ($PackageParameters["client"]) {
        Write-Host "Installing only SSH Client"
        $args = "ADDLOCAL=Client"
    }
}
else {
    Write-Debug "No Package Parameters Passed in"
    Write-Host "Installing SSH Server and Client"
}

Import-Module -Name "$($toolsDir)\helpers.ps1"

$packageArgs = @{
    packageName    = 'Win32-OpenSSH'
    fileType       = 'MSI'
    url            = $urlPackage
    url64bit       = $urlPackage64
    checksum       = $checksumPackage
    checksum64     = $checksumPackage64
    checksumType   = $checksumTypePackage
    silentArgs     = "$($args) /qn"
    validExitCodes = @(
        0, # success
        3010 # success, restart required
    )
}

Install-ChocolateyPackage @packageArgs

Install-ChocolateyPath "${Env:ProgramFiles}\OpenSSH" -PathType 'Machine'
