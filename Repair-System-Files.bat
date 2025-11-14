:: Checks for corrupted system files after checking for administrator privileges
@echo off
goto check_Permissions
:check_Permissions
    net session >nul 2>&1 
    if %errorLevel% == 0 ( 
	sfc /SCANNOW
    pause >nul
    exit
	exit
    ) else (
        echo Requires administrator privileges
    )
    pause >nul