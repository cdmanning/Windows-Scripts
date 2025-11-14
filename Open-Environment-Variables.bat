:: Opens the Windows Environment Variables editor with administrator privileges (Used to resolve a Windows 10 issue)
@echo off
goto check_Permissions
:check_Permissions
    net session >nul 2>&1 
    if %errorLevel% == 0 ( 
	START /B /wait rundll32.exe sysdm.cpl,EditEnvironmentVariables
	exit
    ) else (
        echo Requires administrator privileges
    )
    pause >nul