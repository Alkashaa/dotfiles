@echo off
:: Backup the current registry state
reg export "HKCU\System\CurrentControlSet\Control\Keyboard Layout" "C:\backup.reg"

:: Remap Caps Lock to Escape
reg add "HKCU\System\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /t REG_BINARY /d 00000000000000000300000000003A000000000000 /f

:: Success message
echo Caps Lock has been successfully remapped to Escape. Please restart your computer for changes to take effect.

pause
