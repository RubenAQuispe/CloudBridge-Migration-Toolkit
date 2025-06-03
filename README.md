# CloudBridge Migration Toolkit

[![License: LGPL v3](https://img.shields.io/badge/License-LGPL%20v3-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)](https://www.microsoft.com/windows)
[![Release](https://img.shields.io/github/v/release/RubenAQuispe/CloudBridge-Migration-Toolkit)](https://github.com/RubenAQuispe/CloudBridge-Migration-Toolkit/releases)

## 🚀 Overview

**Enterprise-grade toolkit for migrating Windows computers from on-premises Active Directory to Azure Active Directory with Microsoft Intune enrollment.**

This automated solution provides a seamless migration experience that:
- ✅ **Validates OneDrive backup** before starting migration
- ✅ **Removes computers from local domain** safely
- ✅ **Joins computers to Azure Active Directory** automatically
- ✅ **Enrolls in Microsoft Intune** for cloud management
- ✅ **Backs up BitLocker keys** to Azure for security
- ✅ **Provides user-friendly experience** with clear messaging

---

## 🚀 Quick Start Deployment

### **📦 Step 1: Download & Configure**

1. **Download** the latest release from [GitHub Releases](https://github.com/RubenAQuispe/CloudBridge-Migration-Toolkit/releases)

2. **Configure** your migration settings:
   ```powershell
   # Edit: AADMigration/Scripts/MigrationConfig.psd1
   @{
       TenantID = "YOUR-AZURE-TENANT-ID-HERE"           # ⚠️ REQUIRED: Your Azure tenant ID
       TempPass = "CHANGE-ME-CREATE-SECURE-PASSWORD"    # ⚠️ REQUIRED: Strong temporary password
       DeferDeadline = "02/25/2025 18:00:00"           # Migration deadline
       StartBoundary = "2025-02-20T12:00:00"           # Earliest start time
       # ... other settings
   }
   ```

### **📁 Step 2: Package for Deployment**

3. **Compress** the `AADMigration` folder:
   - Right-click the `AADMigration` folder
   - Select "Send to → Compressed (zipped) folder"
   - Name it `AADMigration.zip`

4. **Prepare deployment package** with both files:
   ```
   Deployment Package/
   ├── AADMigration.zip              # The compressed toolkit
   └── Prepare-DeviceMigration.ps1   # The initialization script
   ```

### **🚀 Step 3: Deploy & Execute**

5. **Copy both files** to the target computer in the same folder

6. **Run the migration**:
   ```powershell
   # Right-click → Run as Administrator
   .\Prepare-DeviceMigration.ps1
   ```

**That's it!** The script will automatically extract the toolkit and begin the migration process.

---

## ⚡ What Happens During Migration

| Phase | Duration | User Experience | System Actions |
|-------|----------|-----------------|----------------|
| **🔍 Pre-Check** | 5 min | Welcome dialog | OneDrive validation |
| **🔄 Domain Leave** | 10 min + restart | "Migration in Progress" screen | Remove from AD domain |
| **☁️ Azure Join** | 10 min + restart | Full-screen migration message | Join Azure AD |
| **📱 Intune Enroll** | 15 min + restart | Continued migration display | Enroll in Intune |
| **✅ Complete** | - | Login screen ready | User can log in with email |

**Total Time:** 30-45 minutes with 3 automatic restarts

---

## 🔒 Security & Prerequisites

### **⚠️ Before You Begin:**
- [ ] **OneDrive synced** - User files MUST be backed up to OneDrive
- [ ] **User logged out** - User must be completely signed out
- [ ] **Internet connected** - Stable connection required
- [ ] **Power connected** - Plug in laptops to prevent interruption
- [ ] **Azure tenant configured** - Tenant ID and settings ready

### **🛡️ Security Features:**
- **Credential Protection** - Sensitive data sanitized in public repository
- **Template Configuration** - Placeholder values require customization
- **BitLocker Management** - Keys automatically escrowed to Azure
- **Comprehensive Logging** - Detailed audit trail for troubleshooting
- **Rollback Capability** - Logs available for issue resolution

---

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| **[SETUP.md](SETUP.md)** | Detailed configuration guide |
| **[SECURITY.md](SECURITY.md)** | Security policy and best practices |
| **[AADMigration/DETAILED-GUIDE.md](AADMigration/DETAILED-GUIDE.md)** | Complete feature documentation |
| **[CONTRIBUTING.md](CONTRIBUTING.md)** | Community contribution guidelines |

---

## 🛠️ Deployment Methods

### **Method 1: SCCM/ConfigMgr (Recommended)**
```powershell
# Package the AADMigration folder
# Deploy as Application
# Use Prepare-DeviceMigration.ps1 as installation command
```

### **Method 2: Group Policy**
```powershell
# Copy files via GPO
# Execute via startup script
# Monitor via centralized logging
```

### **Method 3: Manual/Remote**
```powershell
# Copy deployment package to target PC
# Execute via PowerShell remoting
# Monitor progress via logs
```

---

## 📞 Support & Troubleshooting

### **🔍 Quick Diagnostics:**
- **Migration Logs:** `C:\ProgramData\AADMigration\Logs\AD2AADJ.txt`
- **Event Viewer:** Look for "AAD_Migration_Script" events
- **OneDrive Status:** Event ID 1337 (good) vs 1339 (error)

### **📋 Common Issues:**

| Problem | Solution |
|---------|----------|
| OneDrive not synced | Wait for sync completion before starting |
| Computer stuck on migration screen | Check logs, wait 30 min, then restart if needed |
| User can't log in | Use full email address instead of username |
| Missing files | Check OneDrive folder for synced content |

### **🆘 Getting Help:**
- **Create GitHub Issue** for bugs or feature requests
- **Review Documentation** for setup and troubleshooting
- **Check Event Logs** for detailed error information

---

## 🏗️ System Requirements

- **OS:** Windows 10/11 (Version 1803+)
- **PowerShell:** 5.1 or later
- **Network:** Internet connectivity required
- **Permissions:** Administrator access
- **Storage:** 2GB free space minimum
- **OneDrive:** Installed and syncing

---

## 📈 Key Features

### **🔄 Automated Migration Workflow**
- Zero-touch migration experience
- Automatic restart handling
- Progress indication for users
- Error recovery mechanisms

### **☁️ Cloud Integration**
- Azure Active Directory join
- Microsoft Intune enrollment
- OneDrive sync validation
- BitLocker key backup

### **🛡️ Enterprise Security**
- Credential sanitization
- Audit logging
- Rollback capabilities
- Security policy compliance

### **👥 User Experience**
- Clear progress messaging
- Minimal user interaction
- Familiar post-migration environment
- Email-based authentication

---

## 📄 License

This project is licensed under the LGPL v3 License - see the [COPYING.Lesser](AADMigration/Toolkit/AppDeployToolkit/COPYING.Lesser) file for details.

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:
- Reporting issues
- Submitting improvements
- Security considerations
- Development standards

---

## ⭐ About

**CloudBridge Migration Toolkit** simplifies the transition from traditional on-premises infrastructure to modern cloud-based device management. Built for IT professionals who need reliable, scalable, and secure migration solutions.

**Tested with:** Windows 10/11, Azure AD, Microsoft Intune, OneDrive for Business

---

**📧 Questions?** Create a [GitHub Issue](https://github.com/RubenAQuispe/CloudBridge-Migration-Toolkit/issues) or check our [documentation](AADMigration/DETAILED-GUIDE.md)!
