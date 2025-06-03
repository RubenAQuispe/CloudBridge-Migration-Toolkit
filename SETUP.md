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

1. **Copy the template configuration:**
   ```powershell
   Copy-Item "AADMigration\Scripts\MigrationConfig.template.psd1" "AADMigration\Scripts\MigrationConfig.psd1"
   ```

2. **Edit the configuration file:**
   ```powershell
   notepad "AADMigration\Scripts\MigrationConfig.psd1"
   ```

3. **Update the following values:**
   ```powershell
   # Replace with your actual Azure Tenant ID
   TenantID = "your-tenant-id-here"
   
   # Set your migration deadline
   DeferDeadline = "03/31/2025 18:00:00"
   
   # Set earliest start date
   StartBoundary = "2025-01-15T12:00:00"
   
   # Create a secure password (15+ characters)
   TempPass = "YourSecurePasswordHere123!@#"
   
   # Optional: Domain admin credentials
   DomainLeaveUser = "DOMAIN\admin-username"
   DomainLeavePass = "domain-admin-password"
   ```

### **Step 4: Copy Provisioning Package**

1. Copy your downloaded `.ppkg` file to:
   ```
   AADMigration\Files\AAD-LCS-Join_PPKG.ppkg
   ```

2. Verify the filename matches exactly what's in your configuration file

## 🚀 Deployment Options

### **Option A: SCCM Deployment (Recommended)**

1. **Create Application Package:**
   - Package the entire `AADMigration` folder
   - Set deployment type as "Script Installer"
   - Installation program: `Deploy-Application.exe`

2. **Configure Detection Method:**
   - Registry detection
   - Key: `HKLM\SOFTWARE\AADMigration`
   - Value: `MigrationComplete`

3. **Deploy to Collection:**
   - Target specific computer collections
   - Set deployment as "Required"
   - Schedule for maintenance windows

### **Option B: Manual Deployment**

1. **Copy files to target computer:**
   ```powershell
   Copy-Item "AADMigration" "C:\ProgramData\" -Recurse -Force
   ```

2. **Run the preparation script:**
   ```powershell
   cd "C:\ProgramData"
   .\Prepare-DeviceMigration.ps1
   ```

3. **Start migration:**
   ```powershell
   cd "C:\ProgramData\AADMigration\Toolkit"
   .\Deploy-Application.exe
   ```

### **Option C: Group Policy Deployment**

1. **Create startup script:**
   ```batch
   powershell.exe -ExecutionPolicy Bypass -File "\\server\share\Prepare-DeviceMigration.ps1"
   ```

2. **Deploy via GPO:**
   - Computer Configuration > Policies > Windows Settings > Scripts
   - Add startup script
   - Target appropriate OU

## ✅ Validation Steps

### **Before Migration**
- [ ] Verify OneDrive sync is complete (green checkmark)
- [ ] Confirm user is logged out
- [ ] Check network connectivity to Azure
- [ ] Validate configuration file settings

### **During Migration**
- [ ] Monitor migration progress (3 restarts expected)
- [ ] Check event logs for AAD_Migration_Script events
- [ ] Verify temporary account creation/deletion

### **After Migration**
- [ ] Confirm Azure AD join: `dsregcmd /status`
- [ ] Verify Intune enrollment in Company Portal
- [ ] Test user login with email address
- [ ] Confirm OneDrive sync resumption

## 🐛 Troubleshooting Quick Reference

### **Common Issues**

| Problem | Cause | Solution |
|---------|-------|----------|
| Migration won't start | OneDrive not synced | Wait for sync completion |
| Stuck on "Migration in Progress" | Network issues | Check connectivity, wait 30 min |
| Can't login after migration | Wrong login format | Use full email address |
| Files missing | OneDrive sync incomplete | Check OneDrive folder |

### **Log File Locations**
- Main log: `C:\ProgramData\AADMigration\Logs\AD2AADJ.txt`
- UI log: `C:\ProgramData\AADMigration\Logs\LaunchMigration.txt`
- Event log: Windows Event Viewer > Application > AAD_Migration_Script

## 📞 Support Resources

### **Documentation**
- [Main README](README.md) - Complete documentation
- [Security Policy](SECURITY.md) - Security guidelines
- [Microsoft Docs](https://docs.microsoft.com/azure/) - Azure documentation

### **Tools**
- [Azure Portal](https://portal.azure.com) - Azure management
- [Microsoft Endpoint Manager](https://endpoint.microsoft.com) - Intune management
- [dsregcmd](https://docs.microsoft.com/windows-server/administration/windows-commands/dsregcmd) - Azure AD join status

---

**Need Help?** 
- Check the [troubleshooting section](README.md#troubleshooting-guide) in the main README
- Review [security guidelines](SECURITY.md) for best practices
- Create an issue on GitHub for community support
