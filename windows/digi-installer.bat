@echo off
SETLOCAL ENABLEEXTENSIONS

:: Prompt for required input
set /p ManagerIP=Enter Manager IP: 
set /p AgentName=Enter Agent Name: 

:: URL to the PowerShell installer script on GitHub (change this to your raw .ps1 file URL)
set "PS_SCRIPT_URL=https://digi-agents-pro.s3.ap-south-1.amazonaws.com/digi-agent.msi"

:: Temp path to store the downloaded script
set "TEMP_PS1=%TEMP%\install-digi-agent.ps1"

:: Download the PowerShell script
echo Downloading script from GitHub...
powershell -Command "Invoke-WebRequest -Uri '%PS_SCRIPT_URL%' -OutFile '%TEMP_PS1%'"

:: Check if download was successful
if not exist "%TEMP_PS1%" (
    echo Failed to download PowerShell script.
    exit /b 1
)

:: Check for administrator access
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Requesting admin privileges...
    powershell -Command "Start-Process -Verb RunAs -FilePath '%~f0'"
    exit /b
)

:: Execute the PowerShell script with parameters
powershell -ExecutionPolicy Bypass -NoProfile -File "%TEMP_PS1%" -ManagerIP "%ManagerIP%" -AgentName "%AgentName%"

:: Cleanup
del "%TEMP_PS1%" >nul 2>&1

echo.
echo ===> Digi Agent installation completed!
pause
ENDLOCAL
