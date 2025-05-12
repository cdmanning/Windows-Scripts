@ECHO OFF 

TITLE System Info

ECHO Please wait... Checking system information.


:: Section 1: Windows information
ECHO ============================

ECHO WINDOWS INFO

ECHO ============================

systeminfo | findstr /c:"OS Name"

systeminfo | findstr /c:"System Type"

systeminfo | findstr /c:"Domain"

echo Username:                  %username%


:: Section 2: Hardware information.
ECHO ============================

ECHO HARDWARE INFO

ECHO ============================

wmic cpu get name | findstr/n ^^|findstr "2"


systeminfo | findstr /c:"Total Physical Memory"

wmic diskdrive get name,model,size

wmic path win32_videocontroller get name

wmic path win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution


:: Section 3: Networking information.
ECHO ============================

ECHO NETWORK INFO

ECHO ============================

:: Prints out the hostname to the console
ipconfig /all | findstr "Host Name"
::Prints out the IPv4 address to the console
ipconfig /all | findstr IPv4
:: Prints out the Subnet Mask to the console
ipconfig /all | findstr "Subnet Mask"
:: Prints out the Default Gateway and the IPv4 address the console
ipconfig /all | findstr "Default Gateway"
:: Wait for user input

set "ip="
for /f "tokens=2,3 delims={,}" %%a in ('"WMIC NICConfig where IPEnabled="True" get DefaultIPGateway /value | find "I" "') do if not defined ip set ip=%%~a
echo    Default Gateway . . . . . . . . . : %ip%



PAUSE