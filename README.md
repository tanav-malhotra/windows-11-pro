# Windows 11 Pro Installation & Activation Scripts

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-orange.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Windows](https://img.shields.io/badge/Windows-11-0078D4.svg)](https://www.microsoft.com/windows)
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)](https://www.microsoft.com/windows)
[![Warning](https://img.shields.io/badge/⚠️-Legal%20Risk-red.svg)](https://www.microsoft.com/licensing)

> **🚨 IMPORTANT LEGAL WARNING**: These scripts use KMS activation methods that may violate Microsoft's Terms of Service. Use at your own risk and legal responsibility. Consider purchasing legitimate Windows licenses instead.

> **⚠️ AUTHOR LIABILITY DISCLAIMER**: The script author is NOT responsible for any consequences of using this script, including system damage, legal issues, data loss, or any other negative outcomes. By using this script, you assume ALL risks and hold the author harmless.

A comprehensive set of batch scripts to upgrade any Windows edition to Windows 11 Pro and activate it using KMS activation methods.

## 🚀 Features

- **Easy Installation**: Automated upgrade from Windows 11 Home (or other editions) to Pro
- **Activation Support**: Complete activation using KMS servers
- **Error Handling**: Robust error checking and user-friendly feedback
- **Admin Verification**: Automatic administrator privilege checking
- **Progress Tracking**: Real-time progress updates during installation
- **Safety Checks**: Verification of system compatibility before proceeding

## 📋 What You Get

### Enhanced Windows 11 Pro Features

After successfully running these scripts, you'll have access to:

- **🔐 BitLocker Encryption**: Full disk encryption for enhanced security
- **🖥️ Remote Desktop (Host)**: Access your computer remotely from anywhere
- **⚙️ Group Policy Editor**: Advanced system configuration options
- **🔧 Hyper-V Virtualization**: Run virtual machines natively
- **📦 Windows Sandbox**: Isolated environment for testing applications
- **🏢 Domain Join**: Connect to corporate/enterprise networks
- **📊 Advanced Networking**: Enhanced networking and security features

## 📁 Files Included

| File | Description |
|------|-------------|
| `windows-11-pro.bat` | All-in-one script - detects Windows state and runs install OR activate automatically |
| `README.md` | This documentation file |

## 🛠️ Prerequisites

Before running these scripts, ensure you have:

- ✅ Windows 11 (any edition) - Home, Education, etc.
- ✅ Administrator privileges on your computer
- ✅ Active internet connection
- ✅ All important work saved (restart required)

### System Compatibility

The scripts will automatically check if your Windows edition can be upgraded to Pro. Most Windows 11 editions are compatible, including:

- Windows 11 Home
- Windows 11 Education  
- Windows 11 Home Single Language
- Most other Windows 11 variants

## 📖 Usage Instructions

**One script does everything automatically!**

1. **Right-click** on `windows-11-pro.bat`
2. Select **"Run as administrator"**  
3. Follow the on-screen prompts
4. The script will automatically:
   - **Detect** if Windows 11 Pro is installed
   - **Install** Windows 11 Pro if not detected (then immediate restart)
   - **Activate** Windows 11 Pro if already installed
5. **If installation was needed**: Restart immediately and run the script again to activate (clear instructions provided)

### Command Line Usage

```batch
# Run the script:
windows-11-pro.bat

# The script handles everything automatically based on your system state
```

That's it! No multiple scripts, no manual steps - just one script that intelligently handles your entire Windows 11 Pro upgrade and activation process.

## 🔍 What the Script Does

### Windows 11 Pro Script (`windows-11-pro.bat`)

**The all-in-one solution that automatically handles everything:**

1. **Administrator Check**: Verifies admin privileges
2. **Legal Warnings**: Interactive consent for KMS activation risks  
3. **Smart Detection**: Uses 3 methods to detect Windows 11 Pro installation:
   - SystemInfo check (improved parsing)
   - PowerShell WMI check (modern, reliable)
   - DISM check (most authoritative)
4. **Intelligent Routing**:
   - **If Pro NOT detected** → Runs complete installation process
   - **If Pro IS detected + NOT activated** → Runs activation process  
   - **If Pro IS detected + ALREADY activated** → Shows success and exits
5. **Complete Process**: Handles license backup, edition checking, installation, and activation

**Workflow Examples:**

**Scenario 1 - Pro Not Installed:**
```
[DETECTED] Windows 11 Pro is NOT installed  
[ACTION] Proceeding to INSTALLATION process...
(Runs full install)

================================================================
                      IMPORTANT NEXT STEPS
================================================================

1. Your computer MUST restart to complete Pro installation
2. After restart, RE-RUN THIS SAME SCRIPT to activate Windows 11 Pro
3. The script will detect Pro is installed and run activation automatically

================================================================

CRITICAL: Please read the above instructions carefully!
After restart, you MUST run this same script again for activation.

Do you want to restart now? (Y/N): Y

Restarting immediately...
```

**Scenario 2 - Pro Installed, Not Activated:**
```
[DETECTED] Windows 11 Pro is already installed!
[DETECTED] Windows 11 Pro is installed but NOT ACTIVATED
[ACTION] Proceeding to ACTIVATION process...
(Runs activation)

================================================================
                     Activation Successful!
================================================================

[SUCCESS] Windows 11 Pro has been activated successfully!

You now have full access to all Windows 11 Pro features:
 - BitLocker encryption
 - Remote Desktop (host)
 - Group Policy Editor
 - Hyper-V virtualization
 - Windows Sandbox
 - Domain Join capabilities
```

**Scenario 3 - Pro Installed and Already Activated:**
```
[DETECTED] Windows 11 Pro is already installed!
[DETECTED] Windows 11 Pro is ALREADY ACTIVATED!
[SUCCESS] No further action needed!
```

#### Smart Edition Detection

The script automatically detects what Windows editions your PC supports:

**If Pro upgrade is supported:**
```
[SUCCESS] Your Windows edition is compatible with Pro upgrade!

Available upgrade editions on your system:
----------------------------------------------------------------
  Target Edition : Professional
  Target Edition : Education
----------------------------------------------------------------
```

**If Pro upgrade is NOT supported:**
```
[ERROR] Your Windows edition CANNOT be upgraded to Pro

                  Available Upgrade Editions:
----------------------------------------------------------------
  Target Edition : Home Single Language  
  Target Edition : Education
----------------------------------------------------------------

WHAT YOU CAN DO:
1. Upgrade to one of the supported editions above
2. Purchase a new Windows 11 Pro license from Microsoft
3. Consider a clean Windows 11 Pro installation
```

#### Triple Detection System

The script uses 3 detection methods to verify Windows 11 Pro installation:

```
[CHECK] Verifying Windows 11 Pro installation...
[INFO] Checking system information...
Current OS: Microsoft Windows 11 Home
[INFO] Double-checking with PowerShell WMI...
PowerShell OS: Microsoft Windows 11 Pro  
[INFO] Checking current Windows edition with DISM...
Current Edition: Professional

[SUCCESS] Windows 11 Pro detected!
```

This helps identify if the issue is detection-related or if the Windows upgrade actually failed.

#### License Backup & Status Display

The script provides comprehensive license information during both installation and activation phases:

**Installation Phase - License Backup:**
```
----------------------------------------------------------------
                     CURRENT LICENSE BACKUP
----------------------------------------------------------------

Your current Windows license details (SAVE THIS INFO):
Name: Windows 11 Home
Description: Windows Operating System - Windows 11, OEM_DM channel
Partial Product Key: XXXXX-NKJV6
License Status: Licensed

Attempting to retrieve FULL product key...
FULL OEM Product Key: XXXXX-XXXXX-XXXXX-XXXXX-NKJV6
(This is your original Windows key from UEFI/BIOS)

Have you saved the license information above? (Y/N):
```

**Activation Phase - Pre-Activation Status:**
```
----------------------------------------------------------------
             CURRENT LICENSE STATUS (Pre-Activation)
----------------------------------------------------------------

Your current Windows license status:
Name: Windows 11 Pro
Description: Windows Operating System - Windows 11, VOLUME_KMSCLIENT channel  
Partial Product Key: XXXXX-T83GX
License Status: Initial grace period

The above shows your current license state BEFORE activation.
```

#### Full Product Key Recovery

The install script attempts to retrieve your **complete 25-character product key** using multiple methods:

| Method | What It Retrieves | When Available |
|--------|------------------|----------------|
| **UEFI/BIOS** | OEM keys embedded in hardware | Pre-built computers (Dell, HP, etc.) |
| **PowerShell WMI** | Currently installed key | Most Windows installations |
| **Registry Query** | Active license key | Volume/Enterprise licenses |

**If automatic extraction fails**, the script provides these options:

✅ **Windows Settings**: System → About → Product Key  
✅ **Physical Sticker**: Check your computer case/laptop  
✅ **Email Receipt**: Digital purchase confirmations  
✅ **ProduKey Tool**: Free utility by Nirsoft  
✅ **UEFI Embedded**: Pre-installed on most modern PCs

**Why Only Partial Keys Sometimes?**
- **Security**: Windows hides full keys for protection
- **Volume Licensing**: Corporate keys may be centrally managed  
- **KMS Systems**: Already activated systems may not show original keys

## 🔧 Technical Details

### Product Keys Used

- **Installation Key**: `VK7JG-NPHTM-C97JM-9MPGT-3V66T` (Generic Windows 11 Pro key)
- **Activation Key**: `W269N-WFGWX-YVC9B-4J6C9-T83GX` (KMS client key)

### KMS Server

- **Server**: `kms8.msguides.com`
- **Protocol**: Standard KMS activation
- **Renewal**: Automatic every 180 days

### Services Modified

- **License Manager**: Configured to auto-start
- **Windows Update**: Configured to auto-start

## ⚖️ LEGAL DISCLAIMER - READ CAREFULLY

> **🚨 CRITICAL LEGAL NOTICE**: By using these scripts, you acknowledge that you understand and accept full responsibility for the legal implications.

### Microsoft Terms of Service & Licensing

**IMPORTANT LEGAL CONSIDERATIONS**:

- **KMS Activation**: These scripts use Key Management Service (KMS) activation methods
- **Intended Use**: KMS is designed for enterprise volume licensing scenarios, not individual consumer use
- **Terms Violation**: Using these methods **MAY VIOLATE** Microsoft's Software License Terms
- **Microsoft Policy**: Microsoft does not authorize or support these activation methods for retail users
- **Detection Risk**: Microsoft may detect and disable non-compliant activations

### Your Legal Responsibilities

**BY USING THESE SCRIPTS, YOU AGREE**:
- ✅ You understand this may violate Microsoft's Terms of Service
- ✅ You accept full legal responsibility for your use of these scripts
- ✅ You will not hold the script authors liable for any consequences
- ✅ You understand Microsoft may disable your activation at any time
- ✅ You are using this for educational/testing purposes only

### Recommended Legal Alternatives

**INSTEAD OF THESE SCRIPTS, CONSIDER**:
- 💳 **Purchase Legitimate License**: Buy Windows 11 Pro from Microsoft or authorized retailers
- 🎓 **Educational Discounts**: Students/educators may qualify for significant discounts
- 💼 **Business Licensing**: Companies should use proper volume licensing
- 🔄 **Upgrade Programs**: Check for official Microsoft upgrade promotions

### Geographic & Jurisdictional Considerations

**LEGAL VARIATIONS BY REGION**:
- Laws regarding software activation vary by country/region
- Some jurisdictions may have stricter penalties for license violations  
- Users outside the US should verify local laws regarding software licensing
- Corporate users face higher risks and potential audit consequences

## 🚨 Important Warnings & Disclaimers

### 🛡️ Security Considerations

- Scripts require administrator privileges (necessary for Windows modification)
- Network connections are made to external KMS servers
- Generic product keys are used (standard Microsoft keys for this purpose)
- No malicious code or data collection is performed

### 🔄 Activation Renewal

- KMS activation typically lasts 180 days
- Automatic renewal attempts occur periodically
- Re-run the activation script if activation expires
- Internet connection required for renewals

## 🛠️ Troubleshooting

### Common Issues and Solutions

#### "This script must be run as Administrator"
- **Solution**: Right-click `windows-11-pro.bat` → "Run as administrator"

#### "Your Windows edition cannot be upgraded to Pro"
- **Cause**: Your current Windows edition doesn't support direct upgrade to Pro
- **Script Response**: Automatically displays all editions your PC DOES support
- **Solutions**: 
  - Upgrade to one of the supported editions shown by the script
  - Purchase a new Windows 11 Pro license from Microsoft Store
  - Consider a clean Windows 11 Pro installation

#### "Could not retrieve full product key automatically"
- **Cause**: Windows key is not stored in UEFI or is a volume/KMS license
- **Script Response**: Shows manual recovery options and alternative methods
- **Solutions**:
  - **OEM Systems**: Key is usually embedded in UEFI (script will find it)
  - **Retail Keys**: Check email receipt or Windows Settings → About
  - **Physical Sticker**: Look on computer case or under laptop
  - **ProduKey Tool**: Download free utility from Nirsoft
  - **Command Line**: Run `wmic path softwarelicensingservice get OA3xOriginalProductKey`

#### "Windows 11 Pro is not detected" (after installation + restart)
- **Cause**: Windows edition upgrade may have failed or only partially completed
- **Script Response**: Shows detection results from 3 different methods for diagnosis
- **Solutions**:
  - Check Settings → System → About to see if it shows "Windows 11 Pro"
  - If it shows Pro in Settings but script fails: Detection issue (run script again)
  - If it still shows Home/other edition: Re-run the script to attempt installation again
  - Try manual verification: Open CMD and run `dism /online /get-currentedition`

#### "WMIC is not recognized" or parsing errors in detection
- **Cause**: Script parsing issues or deprecated WMIC command on newer Windows  
- **Script Response**: Now uses PowerShell instead of deprecated WMIC
- **Solutions**:
  - **Updated Script**: This issue is fixed in the latest version
  - **Manual Check**: Open Settings → System → About to verify Windows edition
  - **Command Line**: Run `dism /online /get-currentedition` to check edition
  - **PowerShell Check**: Run `Get-CimInstance -ClassName Win32_OperatingSystem`

#### "Failed to install product key"
- **Cause**: Network connectivity issues
- **Solutions**: 
  - Check internet connection
  - Temporarily disable firewall/antivirus
  - Try again later if KMS server is busy

#### "Activation failed"
- **Cause**: KMS server unavailable or network issues
- **Solutions**:
  - Verify internet connection
  - Check Windows Firewall settings
  - Try running the activation script again
  - Wait and retry (servers may be temporarily unavailable)

#### Windows Update Issues After Installation
- **Solution**: Run Windows Update manually after activation
- Check for and install any pending updates

### Error Codes

| Error | Meaning | Solution |
|-------|---------|----------|
| 0x80070005 | Access denied | Run as administrator |
| 0xC004F074 | KMS server unavailable | Check network, retry later |
| 0x8007232B | DNS name does not exist | Check internet connection |

## 🔍 Verification

### How to Verify Success

After running both scripts:

1. **Open Settings** (Windows + I)
2. **Navigate to** System → About
3. **Look for**:
   - "Windows 11 Pro" in the edition field
   - "Windows is activated" message
   - No watermarks on desktop

### Command-Line Verification

Open Command Prompt as Administrator and run:

```batch
slmgr /xpr          # Shows activation expiration
slmgr /dlv          # Detailed license information  
systeminfo          # System information including OS
```

## 🏗️ Development & Testing

### Script Development

These scripts were developed with enterprise-grade standards:

- **Error Handling**: Comprehensive error checking and user feedback
- **Logging**: Progress tracking and status updates
- **Safety**: Pre-flight checks and validation
- **User Experience**: Clear instructions and confirmation prompts

### Testing Environment

Tested on:
- Windows 11 Home → Pro upgrades
- Windows 11 Education → Pro upgrades  
- Fresh installations and existing systems
- Various hardware configurations

## 📚 Additional Resources

### Microsoft Documentation
- [Windows 11 Pro Features](https://www.microsoft.com/windows/business)
- [KMS Client Setup Keys](https://docs.microsoft.com/en-us/windows-server/get-started/kmsclientkeys)
- [Windows Activation](https://support.microsoft.com/en-us/windows/activate-windows-c39005d4-95ee-b91e-b9ea-fd716c0e9ac0)

### Video Tutorial
There's also a video tutorial available that demonstrates this process:
- [YouTube Tutorial](https://www.youtube.com/watch?v=Q132Tr40z_8)

## 🙏 Attribution & Credits

This project is based on the excellent work by the Windows activation community:

- **Primary Source**: [foreverlate's Windows 11 Pro Activation Guide](https://gist.github.com/foreverlate/7a5caff2ddf645ad8086348f3ce9e20b)
- **Original Guide**: Forked from kimgiftww's activation method
- **Method**: KMS activation using standard Microsoft client keys
- **Community**: Thanks to all contributors who have shared and improved these methods

### Key Sources
- Generic product keys: Standard Microsoft KMS client keys
- Activation method: Community-developed KMS activation process
- KMS Server: `kms8.msguides.com` (community-maintained)

## 🤝 Contributing

If you encounter issues or have improvements to suggest:

1. Create detailed bug reports with error messages
2. Test thoroughly before submitting changes
3. Follow the existing code style and error handling patterns
4. Update documentation for any new features

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## 🚨 AUTHOR LIABILITY DISCLAIMER

**THE SCRIPT AUTHOR IS NOT RESPONSIBLE FOR ANY CONSEQUENCES OF USING THIS SCRIPT**

By downloading, running, or using this script in any way, you acknowledge and agree that:

### 🛡️ No Responsibility for Damages
The author assumes **NO LIABILITY** for any consequences, including but not limited to:
- 💻 **System damage, corruption, or failure to boot**
- 📁 **Data loss or file corruption** 
- 🔧 **Windows installation damage requiring reinstallation**
- ⚖️ **Legal consequences from Microsoft Terms of Service violations**
- 🚫 **Account suspensions, bans, or activation failures**
- 💰 **Financial costs for system repair or legitimate licenses**
- ⏰ **Time loss or productivity impact**
- 🔗 **Any other direct, indirect, or consequential damages**

### 📋 Your Acknowledgment
By using this script, you explicitly acknowledge that:
- ✅ You assume **ALL RISKS** associated with using this script
- ✅ You have been warned of potential legal and technical risks
- ✅ You will not hold the author liable for any negative outcomes
- ✅ You understand Microsoft may take action against unauthorized activation
- ✅ You are responsible for any consequences of your actions

### ⚖️ Legal Recommendation
**STRONGLY RECOMMENDED**: Purchase legitimate Windows 11 Pro licenses from [Microsoft](https://www.microsoft.com/store/windows) instead of using these methods.

## ⚠️ FINAL LEGAL DISCLAIMER & RISK ACKNOWLEDGMENT

**🚨 USE AT YOUR OWN RISK - NO WARRANTY PROVIDED**:

### Liability & Risk Acknowledgment
- **NO GUARANTEE**: These scripts are provided "AS IS" without any warranty
- **USER RESPONSIBILITY**: You assume ALL risks associated with using these scripts
- **NO LIABILITY**: Authors/contributors are NOT responsible for:
  - System damage, data loss, or corruption
  - Microsoft license violations or legal consequences  
  - Account suspensions or activation disabling
  - Legal fees, fines, or other penalties
  - Any direct or indirect damages

### Microsoft's Rights & Enforcement
**MICROSOFT MAY**:
- Detect and disable unauthorized activations
- Suspend or ban Microsoft accounts
- Pursue legal action for license violations
- Block access to Windows updates or services
- Audit enterprise users for compliance

### Strong Recommendations
**BEFORE USING THESE SCRIPTS**:
1. 💾 **Backup all important data**
2. 🧠 **Understand you may face legal consequences**  
3. 💰 **Consider purchasing a legitimate Windows 11 Pro license** (~$199 retail)
4. 📖 **Read Microsoft's Software License Terms**
5. ⚖️ **Consult legal counsel if using in business environments**

### Educational Purpose Statement
This repository exists solely for:
- Educational understanding of Windows activation mechanisms
- Testing and research in isolated environments
- Academic study of software licensing systems

**NOT intended for**:
- Production systems or business use
- Circumventing legitimate software purchases
- Commercial distribution or resale

---

## 🛡️ Protect Yourself Legally

**RECOMMENDED ACTIONS**:
- Purchase legitimate Windows licenses from [Microsoft Store](https://www.microsoft.com/store/windows)
- Check for [educational discounts](https://www.microsoft.com/en-us/education/products/windows) if you're a student
- Use [Microsoft Volume Licensing](https://www.microsoft.com/licensing/) for business deployments
- Consider [Windows 11 upgrade eligibility](https://www.microsoft.com/windows/windows-11-upgrade) for free legitimate upgrades

**By downloading or using these scripts, you acknowledge reading and agreeing to all terms above.**
