@{
	# ===================================================================
	# CloudBridge Migration Toolkit Configuration Template
	# ===================================================================
	# SETUP INSTRUCTIONS:
	# 1. Copy this file to "MigrationConfig.psd1"
	# 2. Replace all "YOUR-" placeholders with your actual values
	# 3. Never commit the actual MigrationConfig.psd1 to version control
	# ===================================================================

	MigrationPath = "C:\ProgramData\AADMigration"
	UseOneDriveKFM = $True
	InstallOneDrive = $True
	
	# REQUIRED: Replace with your Azure Active Directory Tenant ID
	# Get this from Azure Portal -> Azure Active Directory -> Properties -> Tenant ID
	# Example: "a1b2c3d4-e5f6-7890-abcd-ef1234567890"
	TenantID = "YOUR-AZURE-TENANT-ID-HERE"
	
	# REQUIRED: Set your migration deadline (when migration MUST complete)
	# Format: "MM/DD/YYYY HH:MM:SS" (24-hour format)
	DeferDeadline = "YOUR-MIGRATION-DEADLINE-HERE"
	DeferTimes = ""
	
	# REQUIRED: Set earliest migration start date
	# Format: "YYYY-MM-DDTHH:MM:SS" (ISO 8601 format)
	StartBoundary = "YOUR-START-DATE-HERE"
	
	# Temporary user account (used during migration only)
	# This account is automatically created and deleted during migration
	TempUser = "MigrationInProgress"
	
	# REQUIRED: Create a secure password for temporary account
	# SECURITY REQUIREMENTS:
	# - Minimum 15 characters
	# - Include uppercase, lowercase, numbers, and symbols
	# - Do not use dictionary words or common patterns
	TempPass = "YOUR-SECURE-TEMP-PASSWORD-HERE"
	
	# OPTIONAL: Domain credentials for leaving domain (recommended but not required)
	# If provided, migration can leave domain while connected to network
	# Format: "DOMAIN\username" or "username@domain.com"
	DomainLeaveUser = "YOUR-DOMAIN-ADMIN-USER-HERE"
	DomainLeavePass = "YOUR-DOMAIN-ADMIN-PASSWORD-HERE"
	
	# Provisioning package filename (should match your Azure AD package)
	# Generate this package from Azure Portal -> Azure Active Directory -> Devices -> Device enrollment
	ProvisioningPack = "AAD-LCS-Join_PPKG.ppkg"

}
