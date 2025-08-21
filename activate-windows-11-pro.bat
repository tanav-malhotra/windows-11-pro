@echo off
setlocal EnableDelayedExpansion

:: ========================================================================
:: Windows 11 Pro Activation Script
:: ========================================================================
:: LEGAL WARNING: This script uses KMS activation methods that may violate
:: Microsoft's Terms of Service. Use at your own risk and legal responsibility.
:: Consider purchasing legitimate Windows licenses instead.
:: ========================================================================
:: This script activates Windows 11 Pro using KMS activation
:: Requires Administrator privileges and Windows 11 Pro to be installed

title Windows 11 Pro Activation Script

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
echo              Windows 11 Pro Activation Script
echo ================================================================
echo.
echo *** LEGAL WARNING - READ CAREFULLY ***
echo.
echo This script uses KMS activation that MAY VIOLATE Microsoft's Terms
echo of Service. Microsoft may detect and disable this activation.
echo You assume ALL legal risks and consequences.
echo.
echo MICROSOFT ENFORCEMENT RISKS:
echo  - Activation may be detected and disabled
echo  - Microsoft accounts may be suspended
echo  - Legal action possible for license violations
echo  - Updates/services may be blocked
echo.
echo RECOMMENDED: Purchase legitimate Windows 11 Pro license (~$199)
echo Visit: https://www.microsoft.com/store/windows
echo.
set /p legal="Do you accept these legal risks and proceed? (Y/N): "
if /i "!legal!" neq "Y" (
    echo Smart decision! Consider purchasing a legitimate license.
    pause
    exit /b 0
)
echo.
echo ================================================================
echo                    Technical Requirements
echo ================================================================
echo.
echo This script will activate your Windows 11 Pro installation.
echo.
echo PREREQUISITES:
echo  - Windows 11 Pro must be installed (not just upgraded)
echo  - Internet connection required for KMS server access
echo  - Administrator privileges (already verified)
echo.

:: Check if Windows 11 Pro is installed using multiple detection methods
echo [CHECK] Verifying Windows 11 Pro installation...

:: Method 1: Check using systeminfo (improved parsing)
echo [INFO] Checking system information...
for /f "tokens=2* delims=: " %%i in ('systeminfo ^| findstr /c:"OS Name"') do set os_name=%%i %%j
for /f "tokens=2* delims=: " %%i in ('systeminfo ^| findstr /c:"OS Version"') do set os_version=%%i %%j

echo Current OS: !os_name!
echo Version: !os_version!
echo.

:: Method 2: Check using PowerShell (WMIC replacement)
echo [INFO] Double-checking with PowerShell WMI...
for /f "usebackq delims=" %%i in (`powershell -Command "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty Caption"`) do set ps_os=%%i
echo PowerShell OS: !ps_os!
echo.

:: Method 3: Check using dism (improved parsing)
echo [INFO] Checking current Windows edition with DISM...
for /f "tokens=3*" %%i in ('dism /online /get-currentedition ^| findstr /c:"Current Edition"') do set current_edition=%%i
echo Current Edition: !current_edition!
echo.

:: Check if Pro is detected by any method
set pro_detected=0

echo !os_name! | findstr /i "Pro" >nul
if %errorlevel% equ 0 set pro_detected=1

echo !ps_os! | findstr /i "Pro" >nul
if %errorlevel% equ 0 set pro_detected=1

echo !current_edition! | findstr /i "Professional" >nul
if %errorlevel% equ 0 set pro_detected=1

if !pro_detected! equ 0 (
    echo.
    echo ================================================================
    echo [ERROR] Windows 11 Pro is not detected on this system
    echo ================================================================
    echo.
    echo POSSIBLE CAUSES:
    echo  1. Install script hasn't completed - restart may be required
    echo  2. Windows 11 Pro installation failed
    echo  3. System is still processing the edition change
    echo.
    echo WHAT TO DO:
    echo  1. RESTART your computer if you just ran the install script
    echo  2. Check Settings ^> System ^> About for Windows edition
    echo  3. Re-run install-windows-11-pro.bat if Pro isn't shown
    echo  4. Try this activation script again after restart
    echo.
    echo If Windows shows "Windows 11 Pro" in Settings but this script
    echo still fails, there may be a detection issue. Contact support.
    echo.
    pause
    exit /b 1
)

echo [SUCCESS] Windows 11 Pro detected!
echo.

:: Display current license status before activation
echo ----------------------------------------------------------------
echo              CURRENT LICENSE STATUS (Pre-Activation)
echo ----------------------------------------------------------------
echo.
echo [INFO] Your current Windows license status:
slmgr /dli 2>nul
echo.
echo [INFO] Activation details:
slmgr /xpr 2>nul
echo.
echo ----------------------------------------------------------------
echo The above shows your current license state BEFORE activation.
echo This information may be useful for troubleshooting.
echo ----------------------------------------------------------------
echo.

set /p confirm="Do you want to proceed with activation? (Y/N): "
if /i "!confirm!" neq "Y" (
    echo Activation cancelled by user.
    pause
    exit /b 0
)

echo.
echo [INFO] Starting Windows 11 Pro activation process...
echo.

:: Step 1: Install Windows 11 Pro product key
echo [STEP 1] Installing Windows 11 Pro product key...
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install product key!
    echo Please check your internet connection and try again.
    echo.
    pause
    exit /b 1
)
echo [SUCCESS] Product key installed successfully!
echo [INFO] Waiting for operation to complete...
timeout /t 5 /nobreak >nul
echo.

:: Step 2: Set KMS server
echo [STEP 2] Setting KMS server (kms8.msguides.com)...
slmgr /skms kms8.msguides.com
if %errorlevel% neq 0 (
    echo [ERROR] Failed to set KMS server!
    echo Please check your internet connection and firewall settings.
    echo.
    pause
    exit /b 1
)
echo [SUCCESS] KMS server configured successfully!
echo [INFO] Waiting for operation to complete...
timeout /t 5 /nobreak >nul
echo.

:: Step 3: Activate Windows
echo [STEP 3] Activating Windows 11 Pro...
echo [INFO] This may take a moment, please wait...
slmgr /ato
if %errorlevel% neq 0 (
    echo [ERROR] Activation failed!
    echo.
    echo This could be due to:
    echo  - Internet connection issues
    echo  - KMS server being temporarily unavailable
    echo  - Firewall blocking the activation request
    echo.
    echo Please check your connection and try again later.
    pause
    exit /b 1
)

echo.
echo ================================================================
echo                    Activation Successful!
echo ================================================================
echo.
echo [SUCCESS] Windows 11 Pro has been activated successfully!
echo.
echo VERIFICATION STEPS:
echo  1. Go to Settings ^> System ^> About
echo  2. Look for "Windows is activated" message
echo  3. Check that it shows "Windows 11 Pro"
echo.
echo You now have access to all Windows 11 Pro features including:
echo  - BitLocker encryption
echo  - Remote Desktop (host)
echo  - Group Policy Editor
echo  - Hyper-V virtualization
echo  - Windows Sandbox
echo  - And many more professional features
echo.

:: Optional: Show activation status
set /p showstatus="Do you want to display activation status? (Y/N): "
if /i "!showstatus!" equ "Y" (
    echo.
    echo Current activation status:
    slmgr /xpr
)

echo.
echo Thank you for using this activation script!
echo Your Windows 11 Pro is now fully activated and ready to use.
echo.
pause
exit /b 0
