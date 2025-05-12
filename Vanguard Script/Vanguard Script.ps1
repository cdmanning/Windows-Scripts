<#
    .Description
    Disables the Vanguard Anti-Cheat and prevents it from launching/running in the background on launch.
#>

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$needsRestart = $false
$currentScriptPath = $MyInvocation.MyCommand.Definition

#if not ran with administrator privileges: creates new elevated powershell instance and runs the script again
if (-not $isAdmin) {

    Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass '$currentScriptPath'" -Verb RunAs
    exit
}

try {
    $service = Get-Service -Name "vgc"
    if ($service.StartType -eq "Manual") {
        $service | Set-Service -StartupType "Disabled"
        Stop-Service $service -ErrorAction SilentlyContinue
        Write-Host "VGC disabled"
    }
    else {
        $service | Set-Service -StartupType "Manual"
        Write-Host "VGC enabled"
    }
    $service = Get-Service -Name "vgk"
    if ($service.StartType -eq "System") {
        $service | Set-Service -StartupType "Disabled"
        Stop-Service $service -ErrorAction SilentlyContinue
        Write-Output "VGK disabled"
    }
    else {
        $command = { sc.exe config vgk start = system }.$command | Out-Null
        $needsRestart = $true
        Write-Host "VGK enabled"
    }
}
catch {
    Write-Host $_
}

Get-Process -Name "vgtray" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

function Test-MrParameter {

    $input = Read-Host "To load driver, restart is required. Would you like to restart now?`nPlease enter y/n to continue"

    if ($input -eq "y") {
        Restart-Computer -Confirm
    }
    elseif ($input -eq "n") {

    }
    else {
        Test-MrParameter
    }
}

if ($needsRestart) {
    Test-MrParameter
} else {
    Write-Host "Press any key to continue..." -NoNewline
    [void][System.Console]::ReadKey($true)
}













    #Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$currentScriptPath`"" -Verb RunAs