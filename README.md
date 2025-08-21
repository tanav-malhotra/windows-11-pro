# Windows 11 Pro Installation & Activation Scripts

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-orange.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Windows](https://img.shields.io/badge/Windows-11-0078D4.svg)](https://www.microsoft.com/windows)
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)](https://www.microsoft.com/windows)
[![Warning](https://img.shields.io/badge/⚠️-Legal%20Risk-red.svg)](https://www.microsoft.com/licensing)

> **🚨 IMPORTANT LEGAL WARNING**: These scripts use KMS activation methods that may violate Microsoft's Terms of Service. Use at your own risk and legal responsibility. Consider purchasing legitimate Windows licenses instead.

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
| `install-windows-11-pro.bat` | Upgrades current Windows edition to Pro |
| `activate-windows-11-pro.bat` | Activates Windows 11 Pro using KMS |
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

### Method 1: Step-by-Step Process (Recommended)

#### Step 1: Install Windows 11 Pro

1. **Right-click** on `install-windows-11-pro.bat`
2. Select **"Run as administrator"**
3. Follow the on-screen prompts
4. **Restart your computer** when prompted
5. Wait for Windows to complete the Pro installation

#### Step 2: Activate Windows 11 Pro

1. After restart and Pro installation is complete
2. **Right-click** on `activate-windows-11-pro.bat`
3. Select **"Run as administrator"**
4. Follow the on-screen prompts
5. Verify activation in Settings → System → About

### Method 2: Quick Setup

For experienced users who want to run both scripts in sequence:

```batch
# Run as Administrator
install-windows-11-pro.bat
# Restart computer when prompted
# After restart, run:
activate-windows-11-pro.bat
```

## 🔍 What the Scripts Do

### Installation Script (`install-windows-11-pro.bat`)

1. **Privilege Check**: Verifies administrator rights
2. **License Backup**: Displays and saves current Windows license information
   - Shows current product key and edition details
   - Prompts user to save this information for potential restoration
   - Critical for troubleshooting or reverting changes
3. **Compatibility Check**: Scans your Windows edition for Pro upgrade support
   - ✅ **If compatible**: Shows all available upgrade editions and proceeds
   - ❌ **If incompatible**: Displays supported editions and alternative solutions
4. **Key Removal**: Removes existing product keys (`slmgr.vbs /upk`)
5. **Registry Cleanup**: Clears product key from registry (`slmgr.vbs /cpky`)
6. **KMS Reset**: Clears existing KMS settings (`slmgr.vbs /ckms`)
7. **Service Setup**: Configures License Manager and Windows Update services
8. **Edition Upgrade**: Installs Windows 11 Pro using generic product key
9. **Restart Prompt**: Guides user through restart process

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

### Activation Script (`activate-windows-11-pro.bat`)

1. **Enhanced System Verification**: Uses 3 detection methods to confirm Windows 11 Pro
   - SystemInfo check (traditional method, improved parsing)
   - PowerShell WMI check (modern replacement for deprecated WMIC)
   - DISM check (most authoritative Windows edition detection)
2. **License Status Display**: Shows current Windows license state before activation
   - Current product key and edition information
   - Activation status and expiration details
   - Useful for troubleshooting and comparison
3. **Product Key Installation**: Installs KMS client key (`slmgr /ipk`)
4. **KMS Server Setup**: Configures KMS server (`slmgr /skms`)
5. **Activation**: Attempts online activation (`slmgr /ato`)
6. **Status Verification**: Optional activation status display

#### Triple Detection System

If the activation script can't detect Windows 11 Pro, it will show detailed diagnostic information:

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

Both scripts now provide comprehensive license information:

**Install Script - License Backup:**
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

**Activate Script - Pre-Activation Status:**
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
- **Solution**: Right-click the script → "Run as administrator"

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

#### "Windows 11 Pro is not detected" (after install script + restart)
- **Cause**: Windows edition upgrade may have failed or only partially completed
- **Script Response**: Shows detection results from 3 different methods for diagnosis
- **Solutions**:
  - Check Settings → System → About to see if it shows "Windows 11 Pro"
  - If it shows Pro in Settings but script fails: Detection issue (run activate script again)
  - If it still shows Home/other edition: Re-run the install script
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
