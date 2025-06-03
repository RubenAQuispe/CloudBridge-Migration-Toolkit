@{
	# ===================================================================
	# CloudBridge Migration Toolkit Configuration
	# ===================================================================
	# SECURITY WARNING: This file contains sensitive configuration data.
	# Ensure you customize all settings before deployment!
	# ===================================================================

	MigrationPath = "C:\ProgramData\AADMigration"
	UseOneDriveKFM = $True
	InstallOneDrive = $True
	
	# REQUIRED: Replace with your Azure Active Directory Tenant ID
	# Get this from Azure Portal -> Azure Active Directory -> Properties -> Tenant ID
	TenantID = "YOUR-AZURE-TENANT-ID-HERE"
	
	# REQUIRED: Set your migration deadline (when migration MUST complete)
	DeferDeadline = "12/31/2025 18:00:00"
	DeferTimes = ""
	
	# REQUIRED: Set earliest migration start date
	StartBoundary = "2025-01-01T12:00:00"
	
	# Temporary user account (used during migration only)
	TempUser = "MigrationInProgress"
	
	# REQUIRED: Create a secure password for temporary account
	# SECURITY: Use a complex password with 15+ characters, mixed case, numbers, symbols
	TempPass = "CHANGE-ME-CREATE-SECURE-PASSWORD"
	
	# OPTIONAL: Domain credentials for leaving domain (recommended but not required)
	# If provided, migration can leave domain with network connection
	DomainLeaveUser = ""
	DomainLeavePass = ""
	
	# Provisioning package filename (should match your Azure AD package)
	ProvisioningPack = "AAD-LCS-Join_PPKG.ppkg"

}
