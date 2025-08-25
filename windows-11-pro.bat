@echo off
setlocal EnableDelayedExpansion

:: ========================================================================
:: Windows 11 Pro Installation & Activation Script
:: ========================================================================
:: LEGAL WARNING: This script uses KMS activation methods that may violate
:: Microsoft's Terms of Service. Use at your own risk and legal responsibility.
:: Consider purchasing legitimate Windows licenses instead.
:: ========================================================================
:: This script automatically detects if Windows 11 Pro is installed:
:: - If NOT installed: Runs installation/upgrade process
:: - If IS installed: Runs activation process
:: Requires Administrator privileges

title Windows 11 Pro Script

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
echo            Windows 11 Pro Installation & Activation
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
echo Visit: https://www.microsoft.com/store/windows
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
echo                    Detecting Current System
echo ================================================================

:: Enhanced detection to determine if Windows 11 Pro is installed
echo [DETECT] Checking current Windows edition...
echo.

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

echo ================================================================

if !pro_detected! equ 1 (
    echo [DETECTED] Windows 11 Pro is already installed!
    echo.
    echo [INFO] Checking current activation status...
    
    :: Check if Windows is already activated
    slmgr /xpr >"%temp%\activation_status.txt" 2>&1
    findstr /i "permanently activated" "%temp%\activation_status.txt" >nul
    set activation_check=%errorlevel%
    
    findstr /i "will expire" "%temp%\activation_status.txt" >nul
    if %errorlevel% equ 0 set activation_check=0
    
    del "%temp%\activation_status.txt" >nul 2>&1
    
    if !activation_check! equ 0 (
        echo [DETECTED] Windows 11 Pro is ALREADY ACTIVATED!
        echo.
        echo ================================================================
        echo                     Windows 11 Pro Ready!
        echo ================================================================
        echo.
        echo [SUCCESS] Your Windows 11 Pro is already installed and activated!
        echo.
        echo Current activation status:
        slmgr /xpr 2>nul
        echo.
        echo You have full access to all Windows 11 Pro features:
        echo  - BitLocker encryption
        echo  - Remote Desktop (host)  
        echo  - Group Policy Editor
        echo  - Hyper-V virtualization
        echo  - Windows Sandbox
        echo  - Domain Join capabilities
        echo.
        echo No further action needed!
        echo.
        echo ================================================================
        echo                      IMPORTANT DISCLAIMER
        echo ================================================================
        echo.
        echo THE SCRIPT AUTHOR IS NOT RESPONSIBLE FOR ANY CONSEQUENCES
        echo OF USING THIS SCRIPT, INCLUDING BUT NOT LIMITED TO:
        echo.
        echo  - System damage, data loss, or Windows installation corruption
        echo  - Legal consequences from Microsoft Terms of Service violations
        echo  - Account suspensions or activation failures
        echo  - Any other direct or indirect damages
        echo.
        echo By using this script, you acknowledge that you assume ALL RISKS
        echo and hold the author harmless from any negative outcomes.
        echo.
        echo ================================================================
        pause
        exit /b 0
    ) else (
        echo [DETECTED] Windows 11 Pro is installed but NOT ACTIVATED
        echo [ACTION] Proceeding to ACTIVATION process...
        goto :activate_windows
    )
) else (
    echo [DETECTED] Windows 11 Pro is NOT installed
    echo [ACTION] Proceeding to INSTALLATION process...
    goto :install_windows
)

:install_windows
echo.
echo ================================================================
echo               Windows 11 Pro Installation Process
echo ================================================================
echo.
echo This will upgrade your current Windows edition to Pro.
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

:: Step 0: Backup current license information
echo [STEP 0] Backing up current Windows license information...
echo.
echo ----------------------------------------------------------------
echo                     CURRENT LICENSE BACKUP
echo ----------------------------------------------------------------
echo.
echo [INFO] Your current Windows license details (SAVE THIS INFO):

:: Get current license info
slmgr /dli 2>nul
if %errorlevel% neq 0 (
    echo [INFO] No current license information available.
) else (
    echo.
    echo [INFO] Detailed license information:
    slmgr /dlv 2>nul
)

echo.
echo [INFO] Attempting to retrieve FULL product key...

:: Try to get full product key using PowerShell
powershell -Command "try { (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey } catch { 'OEM Key not found in UEFI' }" >"%temp%\oa3_key.txt" 2>nul
set /p oa3_key=<"%temp%\oa3_key.txt"
del "%temp%\oa3_key.txt" >nul 2>&1

if not "!oa3_key!"=="OEM Key not found in UEFI" if not "!oa3_key!"=="" (
    echo FULL OEM Product Key: !oa3_key!
    echo ^(This is your original Windows key from UEFI/BIOS^)
) else (
    echo [INFO] Attempting alternative key extraction...
    
    :: Try alternative PowerShell method for installed key
    powershell -Command "$key = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductKey; if ($key) { $key } else { 'No OEM key available' }" >"%temp%\alt_key.txt" 2>nul
    set /p alt_key=<"%temp%\alt_key.txt"
    del "%temp%\alt_key.txt" >nul 2>&1
    
    if not "!alt_key!"=="No OEM key available" if not "!alt_key!"=="" (
        echo FULL Product Key: !alt_key!
    ) else (
        echo [WARNING] Could not retrieve full product key automatically.
        echo.
        echo MANUAL KEY RETRIEVAL OPTIONS:
        echo  1. Check Windows Settings ^> System ^> About ^> Product Key
        echo  2. Look for Windows sticker on your computer
        echo  3. Check email receipt if you purchased Windows digitally
        echo  4. Use tool like ProduKey ^(search "ProduKey Nirsoft"^)
        echo  5. For OEM systems: Key may be embedded in UEFI ^(above methods^)
        echo.
        echo IMPORTANT: The partial key shown above may be all that's available
        echo if this is a volume license or KMS-activated system.
    )
)

echo.
echo ----------------------------------------------------------------
echo IMPORTANT: The above information shows your current Windows
echo license. Save this information in case you need to restore
echo your original license later!
echo ----------------------------------------------------------------
echo.

set /p backup_confirm="Have you saved the license information above? (Y/N): "
if /i "!backup_confirm!" neq "Y" (
    echo.
    echo Please copy/screenshot the license information above before continuing.
    echo Press any key when ready...
    pause >nul
)

echo.
echo [INFO] Proceeding with Windows 11 Pro installation...
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
    echo     [ERROR] Your Windows edition CANNOT be upgraded to Pro
    echo ================================================================
    echo.
    echo Your current Windows edition does not support upgrading to Pro.
    echo However, here are the editions your PC DOES support:
    echo.
    echo ----------------------------------------------------------------
    echo                  Available Upgrade Editions:
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
echo                 Installation Process Complete
echo ================================================================
echo.
echo The Windows 11 Pro installation process has been initiated.
echo.
echo NEXT STEPS:
echo  1. If you see an error dialog, simply close it
echo  2. Restart your computer when prompted
echo  3. After restart, Windows will install Pro features
echo  4. Run this script again to activate Windows 11 Pro
echo.
echo Your system will now show Windows 11 Pro in Settings.
echo However, it will not be activated until you run activation.
echo.
echo ================================================================
echo                      IMPORTANT NEXT STEPS
echo ================================================================
echo.
echo 1. Your computer MUST restart to complete Pro installation
echo 2. After restart, RE-RUN THIS SAME SCRIPT to activate Windows 11 Pro
echo 3. The script will detect Pro is installed and run activation automatically
echo.
echo ================================================================
echo.
echo CRITICAL: Please read the above instructions carefully!
echo After restart, you MUST run this same script again for activation.
echo.
set /p restart="Do you want to restart now? (Y/N): "
if /i "!restart!" equ "Y" (
    echo.
    echo Restarting immediately...
    shutdown /r /t 1 /c "Restarting to complete Windows 11 Pro installation - Run script again after restart!"
) else (
    echo.
    echo ================================================================
    echo                    MANUAL RESTART REQUIRED
    echo ================================================================
    echo.
    echo Please restart your computer manually to complete the installation.
    echo.
    echo IMPORTANT: After restart, run THIS SAME SCRIPT again!
    echo The script will automatically detect Pro and activate it for you.
    echo.
)

echo.
echo ================================================================
echo                      IMPORTANT DISCLAIMER
echo ================================================================
echo.
echo THE SCRIPT AUTHOR IS NOT RESPONSIBLE FOR ANY CONSEQUENCES
echo OF USING THIS SCRIPT, INCLUDING BUT NOT LIMITED TO:
echo.
echo  - System damage, data loss, or Windows installation corruption
echo  - Legal consequences from Microsoft Terms of Service violations
echo  - Account suspensions or activation failures
echo  - Any other direct or indirect damages
echo.
echo By using this script, you acknowledge that you assume ALL RISKS
echo and hold the author harmless from any negative outcomes.
echo.
echo ================================================================
pause
exit /b 0

:activate_windows
echo.
echo ================================================================
echo               Windows 11 Pro Activation Process
echo ================================================================
echo.
echo This script will activate your Windows 11 Pro installation.
echo.
echo PREREQUISITES:
echo  - Windows 11 Pro must be installed (not just upgraded)
echo  - Internet connection required for KMS server access
echo  - Administrator privileges (already verified)
echo.

:: Display current license status before activation
echo ----------------------------------------------------------------
echo             CURRENT LICENSE STATUS (Pre-Activation)
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
echo                     Activation Successful!
echo ================================================================
echo.
echo [SUCCESS] Windows 11 Pro has been activated successfully!
echo.
echo Current activation status:
slmgr /xpr 2>nul
echo.
echo VERIFICATION STEPS:
echo  1. Go to Settings ^> System ^> About
echo  2. Look for "Windows is activated" message
echo  3. Check that it shows "Windows 11 Pro"
echo.
echo ================================================================
echo              Windows 11 Pro Features Now Available
echo ================================================================
echo.
echo You now have full access to all Windows 11 Pro features:
echo  - BitLocker encryption
echo  - Remote Desktop (host)
echo  - Group Policy Editor
echo  - Hyper-V virtualization
echo  - Windows Sandbox
echo  - Domain Join capabilities
echo  - Advanced networking features
echo  - Enhanced security options
echo  - Professional management tools
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
echo ================================================================
echo                      IMPORTANT DISCLAIMER
echo ================================================================
echo.
echo THE SCRIPT AUTHOR IS NOT RESPONSIBLE FOR ANY CONSEQUENCES
echo OF USING THIS SCRIPT, INCLUDING BUT NOT LIMITED TO:
echo.
echo  - System damage, data loss, or Windows installation corruption
echo  - Legal consequences from Microsoft Terms of Service violations
echo  - Account suspensions or activation failures
echo  - Any other direct or indirect damages
echo.
echo By using this script, you acknowledge that you assume ALL RISKS
echo and hold the author harmless from any negative outcomes.
echo.
echo ================================================================
echo.
pause
exit /b 0
