# Contributing to CloudBridge Migration Toolkit

Thank you for your interest in contributing to the CloudBridge Migration Toolkit! This project helps IT professionals migrate Windows computers from on-premises Active Directory to Azure Active Directory with Microsoft Intune enrollment.

## 🤝 How to Contribute

### Reporting Issues
- **Bug Reports**: Use the GitHub issue tracker to report bugs
- **Feature Requests**: Suggest new features or improvements
- **Security Issues**: Follow our [Security Policy](SECURITY.md) for reporting vulnerabilities

### Contributing Code
1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes** with clear commit messages
4. **Test thoroughly** in a safe environment
5. **Submit a pull request** with detailed description

## 🔒 Security Considerations

### **Critical Security Rules**
- **NEVER** commit real credentials, tenant IDs, or sensitive data
- Always use placeholder values in configuration files
- Test security implications of any changes
- Follow the security guidelines in [SECURITY.md](SECURITY.md)

### **Configuration Files**
- Modify `MigrationConfig.psd1` with clear placeholder values
- Ensure placeholders are obvious and secure (e.g., "YOUR-TENANT-ID-HERE")
- Add clear comments for any new configuration options
- Never commit real credentials or tenant-specific data

## 📋 Development Guidelines

### **Code Standards**
- Follow PowerShell best practices and naming conventions
- Add comprehensive comments for complex logic
- Include error handling and logging
- Maintain compatibility with PowerShell 5.1+

### **Testing Requirements**
- Test all changes in isolated lab environments
- Validate migration scenarios end-to-end
- Verify security controls and access restrictions
- Document test results and scenarios

### **Documentation Standards**
- Update relevant documentation for any changes
- Include clear examples and use cases
- Maintain professional tone and formatting
- Ensure accuracy of technical details

## 🛠️ Setting Up Development Environment

### **Prerequisites**
- Windows 10/11 with PowerShell 5.1+
- Visual Studio Code (recommended)
- Git for version control
- Access to Azure AD test tenant (for testing)

### **Development Setup**
1. Clone your fork: `git clone https://github.com/your-username/CloudBridge-Migration-Toolkit.git`
2. Create isolated test environment
3. Configure `MigrationConfig.psd1` with test tenant data
4. Never commit actual configuration files with real credentials

### **Testing Environment**
- Use dedicated test Azure AD tenant
- Isolated test computers (VMs recommended)
- Network isolation for migration testing
- Backup and restore capabilities

## 📝 Pull Request Process

### **Before Submitting**
- [ ] Code follows PowerShell best practices
- [ ] All changes tested in lab environment
- [ ] Documentation updated appropriately
- [ ] No sensitive data in commits
- [ ] Commit messages are clear and descriptive

### **Pull Request Description**
Include in your PR description:
- **Purpose**: What problem does this solve?
- **Changes**: What modifications were made?
- **Testing**: How was this tested?
- **Impact**: What areas might be affected?
- **Screenshots**: If UI changes, include before/after

### **Review Process**
1. Automated checks for security and standards
2. Manual code review by maintainers
3. Testing verification in lab environment
4. Security review for sensitive changes
5. Documentation review and approval

## 🎯 Contribution Areas

### **High Priority**
- Additional error handling and recovery
- Enhanced logging and troubleshooting
- Improved user experience and messaging
- Security enhancements and hardening

### **Welcome Contributions**
- Bug fixes and stability improvements
- Documentation improvements and translations
- Additional deployment methods
- PowerShell module packaging
- Automated testing frameworks

### **Feature Ideas**
- Multi-tenant support
- Additional cloud platforms
- Enhanced reporting capabilities
- Integration with other migration tools
- Automated rollback capabilities

## 📞 Getting Help

### **Discussion Channels**
- GitHub Issues for bug reports and feature requests
- GitHub Discussions for general questions
- Security issues via private disclosure (see [SECURITY.md](SECURITY.md))

### **Documentation Resources**
- [Setup Guide](SETUP.md) - Configuration instructions
- [Security Policy](SECURITY.md) - Security guidelines
- [Detailed Guide](AADMigration/DETAILED-GUIDE.md) - Feature documentation
- [Microsoft Docs](https://docs.microsoft.com/azure/) - Azure references

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the same [LGPL v3](COPYING.Lesser) license that covers the project.

## 🏆 Recognition

Contributors who make significant improvements will be:
- Added to the contributors list
- Mentioned in release notes
- Credited in documentation updates

## ❤️ Thank You

Your contributions help IT professionals worldwide migrate to modern cloud infrastructure safely and efficiently. Every bug fix, feature enhancement, and documentation improvement makes a difference!

---

**Questions?** Create a GitHub issue or discussion. We're here to help!
