# win32-openssh install

$ErrorActionPreference = 'Stop';
$PackageParameters = Get-PackageParameters

$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$urlPackage = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.5.0.0p1-Beta/OpenSSH-Win32-v9.5.0.0.msi'
$urlPackage64 = 'https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.5.0.0p1-Beta/OpenSSH-Win64-v9.5.0.0.msi'
$checksumPackage = '09bb63fe0005ac98826787a1b1b408d8f29c5d118df6c4a8382c79c269caac340d8ef70c2f9e47f58dd4e2c08a6365ad9a1601af588beddda55c3d83976a235e'
$checksumPackage64 = ''
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
