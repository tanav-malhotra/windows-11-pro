@echo off
setlocal EnableDelayedExpansion

:: ========================================================================
:: Windows 11 Pro Installation/Upgrade Script
:: ========================================================================
:: LEGAL WARNING: This script uses KMS activation methods that may violate
:: Microsoft's Terms of Service. Use at your own risk and legal responsibility.
:: Consider purchasing legitimate Windows licenses instead.
:: ========================================================================
:: This script upgrades Windows Home (or other editions) to Windows 11 Pro
:: Requires Administrator privileges

title Windows 11 Pro Installation Script

:: Color and formatting
color 0B

:: Check for Administrator privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] This script must be run as Administrator!
    echo.
    echo Please right-click on this script and select "Run as administrator"
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================================
echo           Windows 11 Pro Installation/Upgrade Script
echo ================================================================
echo.
echo *** LEGAL WARNING - READ CAREFULLY ***
echo.
echo This script uses KMS activation methods that MAY VIOLATE Microsoft's
echo Terms of Service. Microsoft does not authorize these methods for 
echo retail users. You assume ALL legal risks.
echo.
echo MICROSOFT MAY:
echo  - Detect and disable unauthorized activations
echo  - Suspend Microsoft accounts  
echo  - Pursue legal action for license violations
echo.
echo RECOMMENDED: Purchase legitimate Windows 11 Pro license instead.
echo.
set /p legal="Do you understand and accept these legal risks? (Y/N): "
if /i "!legal!" neq "Y" (
    echo Wise choice! Consider purchasing a legitimate license.
    echo Visit: https://www.microsoft.com/store/windows
    pause
    exit /b 0
)
echo.
echo ================================================================
echo                    Technical Process Warning
echo ================================================================
echo.
echo This script will upgrade your current Windows edition to Pro.
echo.
echo TECHNICAL WARNING: This process will:
echo  - Remove current product key
echo  - Clear KMS settings
echo  - Install Windows 11 Pro edition
echo  - Require a system restart
echo.
echo Make sure to save your work before continuing.
echo.
set /p confirm="Do you want to continue with installation? (Y/N): "
if /i "!confirm!" neq "Y" (
    echo Installation cancelled by user.
    pause
    exit /b 0
)

echo.
echo [INFO] Starting Windows 11 Pro installation process...
echo.

:: Step 1: Check if edition is upgradeable
echo [STEP 1] Checking if your Windows edition can be upgraded to Pro...
echo.

:: Run DISM command and capture output
echo [INFO] Scanning available upgrade editions...
DISM /online /Get-TargetEditions > "%temp%\target_editions.txt" 2>&1

:: Check if Professional is available
findstr /i "Professional" "%temp%\target_editions.txt" >nul
if %errorlevel% neq 0 (
    echo.
    echo ================================================================
    echo [ERROR] Your Windows edition CANNOT be upgraded to Pro
    echo ================================================================
    echo.
    echo Your current Windows edition does not support upgrading to Pro.
    echo However, here are the editions your PC DOES support:
    echo.
    echo ----------------------------------------------------------------
    echo                Available Upgrade Editions:
    echo ----------------------------------------------------------------
    
    :: Display available editions in a nice format
    for /f "tokens=*" %%a in ('findstr /i "Edition" "%temp%\target_editions.txt"') do (
        echo   %%a
    )
    
    echo ----------------------------------------------------------------
    echo.
    echo WHAT YOU CAN DO:
    echo  1. Upgrade to one of the supported editions above
    echo  2. Purchase a new Windows 11 Pro license from Microsoft
    echo  3. Consider a clean Windows 11 Pro installation
    echo.
    echo Microsoft Store: https://www.microsoft.com/store/windows
    echo.
    
    :: Cleanup temp file
    del "%temp%\target_editions.txt" >nul 2>&1
    pause
    exit /b 1
)

:: Professional is available - show success message
echo [SUCCESS] Your Windows edition is compatible with Pro upgrade!
echo.

echo Available upgrade editions on your system:
echo ----------------------------------------------------------------
for /f "tokens=*" %%a in ('findstr /i "Edition" "%temp%\target_editions.txt"') do (
    echo   %%a
)
echo ----------------------------------------------------------------
echo.

:: Cleanup temp file
del "%temp%\target_editions.txt" >nul 2>&1

:: Step 2: Remove current product key
echo [STEP 2] Removing current product key...
slmgr.vbs /upk
if %errorlevel% neq 0 (
    echo [WARNING] Failed to remove product key, continuing...
)
echo [INFO] Waiting for operation to complete...
timeout /t 3 /nobreak >nul
echo.

:: Step 3: Clear product key from registry
echo [STEP 3] Clearing product key from registry...
slmgr.vbs /cpky
if %errorlevel% neq 0 (
    echo [WARNING] Failed to clear product key from registry, continuing...
)
echo [INFO] Waiting for operation to complete...
timeout /t 3 /nobreak >nul
echo.

:: Step 4: Clear KMS settings
echo [STEP 4] Clearing KMS server settings...
slmgr.vbs /ckms
if %errorlevel% neq 0 (
    echo [WARNING] Failed to clear KMS settings, continuing...
)
echo [INFO] Waiting for operation to complete...
timeout /t 3 /nobreak >nul
echo.

:: Step 5: Start required services
echo [STEP 5] Starting License Manager service...
sc config LicenseManager start= auto
net start LicenseManager
if %errorlevel% neq 0 (
    echo [WARNING] License Manager service may already be running.
)
echo.

echo [STEP 6] Starting Windows Update service...
sc config wuauserv start= auto
net start wuauserv
if %errorlevel% neq 0 (
    echo [WARNING] Windows Update service may already be running.
)
echo.

:: Step 7: Install Windows 11 Pro
echo [STEP 7] Installing Windows 11 Pro edition...
echo.
echo [INFO] This will start the Windows Pro installation.
echo [INFO] You may see a progress dialog and possibly an error at the end.
echo [INFO] If you get an error, simply close it and restart your computer.
echo.
echo Installing Windows 11 Pro...
changepk.exe /productkey VK7JG-NPHTM-C97JM-9MPGT-3V66T

echo.
echo ================================================================
echo                    Installation Process Complete
echo ================================================================
echo.
echo The Windows 11 Pro installation process has been initiated.
echo.
echo NEXT STEPS:
echo  1. If you see an error dialog, simply close it
echo  2. Restart your computer when prompted
echo  3. After restart, Windows will install Pro features
echo  4. Run the activate-windows-11-pro.bat script to activate
echo.
echo Your system will now show Windows 11 Pro in Settings.
echo However, it will not be activated until you run the activation script.
echo.
set /p restart="Do you want to restart now? (Y/N): "
if /i "!restart!" equ "Y" (
    echo Restarting in 10 seconds...
    shutdown /r /t 10 /c "Restarting to complete Windows 11 Pro installation"
) else (
    echo Please restart manually to complete the installation.
)

echo.
pause
exit /b 0
