@echo off
goto check_Permissions
:check_Permissions
    echo Administrative permissions required. Detecting permissions...
    net session >nul 2>&1 
    if %errorLevel% == 0 ( 
        echo Success: Administrative permissions confirmed.
	START /B /wait rundll32.exe sysdm.cpl,EditEnvironmentVariables
	exit
    ) else (
        echo Failure: Current permissions inadequate.
    )
    pause >nul