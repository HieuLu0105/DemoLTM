@echo off
setlocal

where mosquitto >nul 2>nul
if errorlevel 1 (
  echo Mosquitto was not found. Install Mosquitto and add mosquitto.exe to PATH first.
  pause
  exit /b 1
)

where py >nul 2>nul
if errorlevel 1 (
  echo Python Launcher "py" was not found. Install Python 3 first.
  pause
  exit /b 1
)

start "Group15 MQTT Server" cmd /k mosquitto -c "%~dp0mosquitto.conf" -v
start "Group15 Web Server" cmd /k py -m http.server 8080 --bind 0.0.0.0 --directory "%~dp0"

set "LAN_IP="
for /f "usebackq delims=" %%I in (`powershell -NoProfile -Command "Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue ^| Where-Object { $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.254*' } ^| Select-Object -First 1 -ExpandProperty IPAddress"`) do set "LAN_IP=%%I"

echo.
echo This computer is now serving the whiteboard on the LAN.
if defined LAN_IP (
  echo Open http://%LAN_IP%:8080/ on this computer and the other group computer.
) else (
  echo Run ipconfig to find this computer's IPv4 address, then open http://YOUR-IP:8080/ on both computers.
)
echo Allow Python and Mosquitto on Private networks in the Windows Firewall prompt.
echo Do not expose ports 8080 or 9001 to the public Internet.
echo.
pause
