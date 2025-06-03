# CloudBridge Migration Toolkit - Quick Setup Guide

## 🚀 Getting Started

This guide will help you configure the CloudBridge Migration Toolkit for your environment.

## 📋 Prerequisites

### **Azure Requirements**
- [ ] Azure Active Directory tenant
- [ ] Microsoft Intune subscription
- [ ] Azure AD Connect (for hybrid scenarios)
- [ ] Global Administrator or Intune Administrator permissions

### **On-Premises Requirements**
- [ ] Active Directory domain environment
- [ ] Domain Administrator credentials
- [ ] SCCM (optional, for automated deployment)
- [ ] Network connectivity to Azure services

### **Client Requirements**
- [ ] Windows 10/11 Professional or Enterprise
- [ ] OneDrive for Business installed and configured
- [ ] PowerShell 5.1 or later
- [ ] Administrative access to target computers

## ⚙️ Configuration Steps

### **Step 1: Get Your Azure Tenant ID**

1. Sign in to the [Azure Portal](https://portal.azure.com)
2. Navigate to **Azure Active Directory**
3. Click **Properties**
4. Copy the **Tenant ID** (GUID format)

### **Step 2: Create Azure AD Provisioning Package**

1. In Azure Portal, go to **Azure Active Directory** > **Devices** > **Device enrollment**
2. Click **Windows enrollment** > **Devices**
3. Click **Download** next to **Bulk enrollment**
4. Generate a new provisioning package
5. Download the `.ppkg` file
6. Rename it to `AAD-LCS-Join_PPKG.ppkg`

### **Step 3: Configure the Migration Toolkit**

1. **Open the configuration file:**
   ```powershell
   notepad "AADMigration\Scripts\MigrationConfig.psd1"
   ```

2. **Update the required values:**
   ```powershell
   @{
       # ⚠️ REQUIRED: Replace with your actual Azure Tenant ID
       TenantID = "YOUR-AZURE-TENANT-ID-HERE"
       
       # ⚠️ REQUIRED: Create a secure password (15+ characters)
       TempPass = "CHANGE-ME-CREATE-SECURE-PASSWORD"
       
       # Set your migration deadline
       DeferDeadline = "03/31/2025 18:00:00"
       
       # Set earliest start date
       StartBoundary = "2025-01-15T12:00:00"
       
       # Optional: Domain admin credentials (recommended)
       DomainLeaveUser = "DOMAIN\admin-username"
       DomainLeavePass = "domain-admin-password"
       
       # Other settings (usually don't need changes)
       TempUser = "MigrationInProgress"
       ProvisioningPack = "AAD-LCS-Join_PPKG.ppkg"
       # ... additional settings
   }
   ```

### **Step 4: Replace Provisioning Package**

1. Copy your downloaded `.ppkg` file to:
   ```
   AADMigration\Files\AAD-LCS-Join_PPKG.ppkg
   ```

2. Replace the template file with your tenant-specific package

## 🚀 Deployment Workflow

### **Packaging for Deployment**

1. **After configuration, create deployment package:**
   - Compress the `AADMigration` folder to `AADMigration.zip`
   - Copy both `AADMigration.zip` and `Prepare-DeviceMigration.ps1` to target computers

2. **Deployment structure:**
   ```
   Target Computer Folder/
   ├── AADMigration.zip              # Compressed toolkit
   └── Prepare-DeviceMigration.ps1   # Initialization script
   ```

### **Execution**

3. **Run the migration:**
   ```powershell
   # Right-click → Run as Administrator
   .\Prepare-DeviceMigration.ps1
   ```

The script will automatically:
- Extract `AADMigration.zip` to the correct location
- Set up the migration environment
- Launch the migration toolkit

## 🚀 Deployment Options

### **Option A: SCCM Deployment (Recommended)**

1. **Create Application Package:**
   - Package both `AADMigration.zip` and `Prepare-DeviceMigration.ps1`
   - Set deployment type as "Script Installer"
   - Installation program: `Prepare-DeviceMigration.ps1`

2. **Configure Detection Method:**
   - Registry detection
   - Key: `HKLM\SOFTWARE\AADMigration`
   - Value: `MigrationComplete`

3. **Deploy to Collection:**
   - Target specific computer collections
   - Set deployment as "Required"
   - Schedule for maintenance windows

### **Option B: Manual Deployment**

1. **Copy deployment package to target computer:**
   ```powershell
   # Copy both files to the same folder
   Copy-Item "AADMigration.zip" "C:\Temp\"
   Copy-Item "Prepare-DeviceMigration.ps1" "C:\Temp\"
   ```

2. **Execute the migration:**
   ```powershell
   cd "C:\Temp"
   .\Prepare-DeviceMigration.ps1
   ```

### **Option C: Group Policy Deployment**

1. **Create startup script:**
   ```batch
   powershell.exe -ExecutionPolicy Bypass -File "\\server\share\Prepare-DeviceMigration.ps1"
   ```

2. **Deploy via GPO:**
   - Computer Configuration > Policies > Windows Settings > Scripts
   - Add startup script with network path to your deployment package
   - Target appropriate OU

## ✅ Validation Steps

### **Before Migration**
- [ ] Verify OneDrive sync is complete (green checkmark)
- [ ] Confirm user is logged out
- [ ] Check network connectivity to Azure
- [ ] Validate configuration file settings
- [ ] Test deployment package on a test computer

### **During Migration**
- [ ] Monitor migration progress (3 restarts expected)
- [ ] Check event logs for AAD_Migration_Script events
- [ ] Verify temporary account creation/deletion
- [ ] Watch for "Migration in Progress" screen

### **After Migration**
- [ ] Confirm Azure AD join: `dsregcmd /status`
- [ ] Verify Intune enrollment in Company Portal
- [ ] Test user login with email address
- [ ] Confirm OneDrive sync resumption
- [ ] Check BitLocker key escrow to Azure

## 🐛 Troubleshooting Quick Reference

### **Common Issues**

| Problem | Cause | Solution |
|---------|-------|----------|
| Migration won't start | OneDrive not synced | Wait for sync completion |
| Extraction fails | Missing files | Verify both files are in same folder |
| Stuck on "Migration in Progress" | Network issues | Check connectivity, wait 30 min |
| Can't login after migration | Wrong login format | Use full email address |
| Files missing | OneDrive sync incomplete | Check OneDrive folder |

### **Log File Locations**
- Main log: `C:\ProgramData\AADMigration\Logs\AD2AADJ.txt`
- UI log: `C:\ProgramData\AADMigration\Logs\LaunchMigration.txt`
- Event log: Windows Event Viewer > Application > AAD_Migration_Script

### **Verification Commands**
```powershell
# Check Azure AD join status
dsregcmd /status

# Check Intune enrollment
Get-WmiObject -Namespace "root\cimv2\mdm\dmmap" -Class "MDM_DevDetail_Ext01"

# Verify OneDrive sync
Get-ChildItem "$env:USERPROFILE\OneDrive*"
```

## 📞 Support Resources

### **Documentation**
- [Main README](README.md) - Complete documentation
- [Security Policy](SECURITY.md) - Security guidelines
- [Detailed Guide](AADMigration/DETAILED-GUIDE.md) - In-depth feature documentation

### **External Resources**
- [Azure Portal](https://portal.azure.com) - Azure management
- [Microsoft Endpoint Manager](https://endpoint.microsoft.com) - Intune management
- [Microsoft Docs](https://docs.microsoft.com/azure/) - Azure documentation

### **Support Channels**
- Create GitHub Issues for bugs or feature requests
- Review documentation for setup and troubleshooting
- Check Event Logs for detailed error information

---

**⚠️ Security Reminder:** 
- Always use secure passwords (15+ characters minimum)
- Protect configuration files from unauthorized access
- Test in lab environment before production deployment
- Review [Security Policy](SECURITY.md) for enterprise guidelines

**🚀 Ready to Deploy?** 
Follow the deployment workflow above and monitor logs for successful completion!
