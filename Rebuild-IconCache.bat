:: Rebuilds the icon-cache and refreshes the Explorer service
taskkill /F /IM explorer.exe
del %localappdata%\Microsoft\Windows\Explorer\iconcache*
start explorer.exe