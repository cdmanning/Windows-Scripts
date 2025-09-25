@ECHO OFF 

TITLE System Info

ECHO Please wait... Checking system information.



ECHO ============================

ECHO WINDOWS INFO

ECHO ============================

systeminfo | findstr /c:"OS Name"
systeminfo | findstr /c:"System Type"
systeminfo | findstr /c:"Domain"
echo Username:                      %username%



ECHO ============================

ECHO HARDWARE INFO

ECHO ============================

powershell.exe -c "Write-Host 'Installed CPUs:                ' -NoNewline; (Get-WmiObject Win32_Processor).Name -join ', '"

powershell.exe -c "$memoryObjects = Get-CimInstance Win32_PhysicalMemory; $totalMemory = ($memoryObjects | Measure-Object -Property Capacity -Sum).Sum / 1GB; $formattedMemory = [math]::Round($totalMemory, 0); $speeds = ($memoryObjects | Select-Object -ExpandProperty Speed) -join ', '; Write-Host 'Total Physical Memory:         ' -NoNewline; Write-Host "$formattedMemory GBs at $speeds  MHz"

powershell.exe -c "$gpus = Get-WmiObject Win32_VideoController; $output = 'Installed GPUs:'; for ($i = 0; $i -lt $gpus.Count; $i++) { if ($i -eq 0) { $output += '                ' + $gpus[$i].Name } else { $output += \"`r`n                               \" + $gpus[$i].Name } }; Write-Host $output"

powershell.exe -c "$drives = Get-WmiObject Win32_DiskDrive; $output = 'Installed Disk Drives:'; for ($i = 0; $i -lt $drives.Count; $i++) { if ($i -eq 0) { $output += '         ' + $drives[$i].Model + ' - ' + [math]::Round($drives[$i].Size / 1GB, 0) + ' GB' } else { $output += \"`r`n                               \" + $drives[$i].Model + \" - \" + [math]::Round($drives[$i].Size / 1GB, 0) + \" GB\" } }; Write-Host $output"



ECHO ============================

ECHO NETWORK INFO

ECHO ============================

ipconfig /all | findstr "Host Name"
ipconfig /all | findstr IPv4
ipconfig /all | findstr "Subnet Mask"
ipconfig /all | findstr "Default Gateway"


PAUSE