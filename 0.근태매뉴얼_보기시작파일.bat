@echo off
setlocal
chcp 65001 > nul

set "PORT=5510"
set "ROOT=%~dp0"
set "URL=http://127.0.0.1:%PORT%/index.html"

cd /d "%ROOT%"

where py > nul 2> nul
if not errorlevel 1 (
  start "AttendanceManualServer" cmd /k "cd /d ""%ROOT%"" && py -m http.server %PORT% --bind 127.0.0.1"
  goto wait_open
)

where python > nul 2> nul
if not errorlevel 1 (
  start "AttendanceManualServer" cmd /k "cd /d ""%ROOT%"" && python -m http.server %PORT% --bind 127.0.0.1"
  goto wait_open
)

echo.
echo Python was not found.
echo Install Python or make sure py/python is available in PATH.
echo.
pause
exit /b 1

:wait_open
timeout /t 2 /nobreak > nul
start "" "%URL%"
exit /b 0
