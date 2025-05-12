echo off
chcp 65001
mkdir ".\ "
echo [.ShellClassInfo] > ".\ \desktop.ini"
echo IconResource=%SystemRoot%\System32\shell32.dll,49 >> ".\ \desktop.ini"
attrib +s ".\ "
ie4uinit.exe -show

