# CloudBridge Migration Toolkit

[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)](https://www.microsoft.com/windows)

## 🚀 Quick Overview
This toolkit migrates Windows computers from **on-premises Active Directory** to **Azure Active Directory** (cloud) and enrolls them in **Microsoft Intune** for management.

**What it does:**
1. ✅ Checks that user files are backed up to OneDrive
2. ✅ Removes the computer from your local domain
3. ✅ Joins the computer to Azure Active Directory
4. ✅ Enrolls the computer in Microsoft Intune

---

## 🔒 SECURITY WARNING - READ FIRST!

### **⚠️ Configuration Required Before Use**
This toolkit requires proper configuration before deployment:

- **Azure Tenant ID**: Must be configured for your organization
- **Secure Passwords**: Default passwords MUST be changed
- **Network Credentials**: Optional but recommended for domain operations
- **Provisioning Package**: Must match your Azure AD configuration

### **🚨 Never Commit Sensitive Data**
- Always use `MigrationConfig.template.psd1` as your starting point
- Never commit actual `MigrationConfig.psd1` to version control
- Protect credentials and tenant information

### **🛡️ Security Best Practices**
- Use complex passwords (15+ characters, mixed case, numbers, symbols)
- Limit access to configuration files to authorized IT staff only
- Test in a controlled environment before production deployment
- Review all logs for sensitive information before sharing

---

## ⚠️ IMPORTANT - Read This First!

### Before You Start
- **User files MUST be synced to OneDrive** before running this tool
- **The computer will restart 3 times** during migration
- **Users cannot use their computer** during the migration process (about 30-45 minutes)
- **Have the user log out** before starting migration

### What Users Need to Know
After migration, users will:
- Log in with their **email address** instead of their old username
- Use their **regular password** (same as before)
- Find all their files in the same locations (Desktop, Documents, etc.)

---

## 📋 Step-by-Step Setup Guide

### Step 1: Verify Prerequisites
**Before touching anything, check these:**

- [ ] Computer is connected to the internet
- [ ] User's OneDrive is syncing properly (green checkmark in system tray)
- [ ] User has logged out of the computer
- [ ] You have administrative access to the computer

### Step 2: Configure Migration Settings

1. **Open the configuration file:**
   - Navigate to: `AADMigration\Scripts\`
   - Open: `MigrationConfig.psd1`

2. **Update these settings for your environment:**

```powershell
@{
    # YOUR AZURE TENANT ID (Get this from your Azure admin)
    TenantID = "Your-Azure-Tenant-ID"
    
    # DEADLINE - When migration MUST complete
    DeferDeadline = "02/25/2025 18:00:00"
    
    # EARLIEST START DATE
    StartBoundary = "2025-02-20T12:00:00"
    
    # TEMPORARY ACCOUNT (Used during migration only)
    TempUser = "MigrationInProgress"
    TempPass = "Create-A-Local-Password"
    
    # DOMAIN CREDENTIALS (Optional but recommended)
    DomainLeaveUser = "DOMAIN\\admin-username"
    DomainLeavePass = "domain-admin-password"
    
    # PROVISIONING PACKAGE (Should already be correct)
    ProvisioningPack = "AAD-LCS-Join_PPKG.ppkg"
}
```

### Step 3: Deploy the Migration

#### Option A: Using SCCM (Recommended)
1. Package the entire `AADMigration` folder
2. Deploy as an Application
3. Set detection method for successful completion
4. Target specific computer collections

#### Option B: Manual Deployment
1. Copy the `AADMigration` folder to: `C:\ProgramData\`
2. Run as Administrator: `AADMigration\Toolkit\Deploy-Application.exe`

---

## 🔄 What Happens During Migration

### Phase 1: Pre-Migration Checks (5 minutes)
- **User sees:** Welcome dialog with migration information
- **System does:** Checks OneDrive sync status
- **Result:** Migration starts or stops if OneDrive isn't ready

### Phase 2: Domain Removal (10 minutes + restart)
- **User sees:** "Migration in Progress" full-screen message
- **System does:** 
  - Creates temporary admin account
  - Removes computer from domain
  - **RESTART #1**

### Phase 3: Azure AD Join (10 minutes + restart)
- **User sees:** "Migration in Progress" screen continues
- **System does:**
  - Joins computer to Azure Active Directory
  - Installs Azure AD configuration
  - **RESTART #2**

### Phase 4: Intune Enrollment (15 minutes + restart)
- **User sees:** "Migration in Progress" screen continues
- **System does:**
  - Enrolls in Microsoft Intune
  - Backs up BitLocker keys to Azure
  - Cleans up temporary accounts
  - **RESTART #3**

### Phase 5: Complete
- **User sees:** Login screen with message: "This PC has been migrated to Azure Active Directory"
- **System is:** Ready for user to log in with email address

---

## 🛠️ Troubleshooting Guide

### Migration Won't Start
**Problem:** Tool exits immediately or shows error

**Check these:**
1. **OneDrive Status**
   - Look in Windows Event Viewer → Applications and Services Logs
   - Look for "AAD_Migration_Script" events
   - Event ID 1337 = Good (OneDrive healthy)
   - Event ID 1338 = Wait (OneDrive syncing)
   - Event ID 1339 = Problem (OneDrive has errors)

**Fix:** 
- If Event 1338: Wait for OneDrive to finish syncing
- If Event 1339: Fix OneDrive sync issues first

### Computer Stuck on "Migration in Progress"
**Problem:** Screen shows migration message but nothing happens

**Check these:**
1. Wait 10 minutes (migration can appear stuck)
2. Check if computer is restarting automatically
3. Look at log files in: `C:\ProgramData\AADMigration\Logs\`

**Fix:**
- If stuck > 30 minutes: Restart computer manually
- Check logs for specific error messages

### User Can't Log In After Migration
**Problem:** User gets "account not recognized" error

**Check these:**
1. User is typing their full email address (not just username)
2. Internet connection is working
3. Computer shows "Connected to: [YourTenant].onmicrosoft.com"

**Fix:**
- Have user try: email@yourcompany.com instead of just "username"
- Restart computer and try again
- Check with Azure admin if account exists

### Files Missing After Migration
**Problem:** User reports missing Desktop/Documents files

**Check these:**
1. OneDrive sync status before migration
2. Check OneDrive folder: `C:\Users\[username]\OneDrive - [Company]`

**Fix:**
- Files should be in OneDrive folder
- May need to wait for OneDrive to sync down
- Check OneDrive recycle bin online

---

## 📁 File Structure Reference

```
AADMigration/
├── Files/
│   ├── AAD-LCS-Join_PPKG.ppkg     # Azure AD join configuration
│   ├── OneDriveLib.dll             # OneDrive status checker
│   ├── MigrationInProgress.bmp     # Full-screen image during migration
│   └── ServiceUI.exe               # User interface handler
├── Scripts/
│   ├── MigrationConfig.psd1        # ⚙️ MAIN CONFIGURATION FILE
│   ├── Check-OneDriveSyncStatus.ps1 # Verifies OneDrive backup
│   ├── Migrate-ToAADJOnly.ps1      # Main migration logic
│   ├── PostRunOnce.ps1             # After first restart
│   ├── PostRunOnce2.ps1            # After second restart
│   ├── PostRunOnce3.ps1            # Final cleanup
│   └── Deploy-Application.ps1       # User interface & workflow
└── Toolkit/                        # PowerShell App Deployment Toolkit
    └── [Various PSADT files]
```

---

## ✅ Pre-Migration Checklist

**Before starting ANY migration:**

- [ ] User has logged out completely
- [ ] OneDrive shows green checkmark (fully synced)
- [ ] Computer is plugged into power (laptops)
- [ ] Stable internet connection confirmed
- [ ] User has been notified of 30-45 minute downtime
- [ ] Configuration file has correct tenant ID
- [ ] Provisioning package is up to date
- [ ] You have admin credentials ready (if needed)

**After starting migration:**

- [ ] Do NOT interrupt the process
- [ ] Do NOT power off the computer
- [ ] Let all restarts complete automatically
- [ ] Monitor logs if issues occur

---

## 📞 Getting Help

### Log File Locations
- **Main Migration Log:** `C:\ProgramData\AADMigration\Logs\AD2AADJ.txt`
- **User Interface Log:** `C:\ProgramData\AADMigration\Logs\LaunchMigration.txt`
- **Windows Event Log:** Event Viewer → Application → Look for "AAD_Migration_Script"

### Common Event IDs
- **1337:** OneDrive sync healthy ✅
- **1338:** OneDrive currently syncing ⏳
- **1339:** OneDrive sync error ❌
- **1340:** Cannot determine OneDrive status ⚠️

### When to Contact Senior IT
- Migration fails multiple times
- Computer won't join Azure AD
- User account issues after migration
- BitLocker recovery needed
- OneDrive sync problems

---

## 🔒 Security Notes

### Temporary Account
- Account `MigrationInProgress` is created during migration
- **Automatically deleted** when migration completes
- If migration fails, manually delete this account

### BitLocker
- Automatically suspended during migration
- Keys backed up to Azure Active Directory
- Re-enabled after migration completes

### Network Security
- Computer briefly disconnects from domain
- Network adapters temporarily disabled during domain leave
- Normal connectivity restored after Azure AD join

---

*Last Updated: December 2024*
*Version: 1.0*

---

**⚡ Quick Reference:**
- **Config File:** `AADMigration\Scripts\MigrationConfig.psd1`
- **Start Migration:** `AADMigration\Toolkit\Deploy-Application.exe`
- **Check Logs:** `C:\ProgramData\AADMigration\Logs\`
- **Total Time:** 30-45 minutes (3 restarts)
- **User Impact:** Must use email to log in after migration
