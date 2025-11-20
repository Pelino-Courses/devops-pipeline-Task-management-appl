# Security Documentation

## Security Measures

### Infrastructure Security
- **Network Security Group (NSG)**: Restricts traffic to essential ports only (22, 80, 443, 3000).
- **SSH Hardening**: Password authentication disabled, SSH key only.
- **Firewall (UFW)**: Configured on the VM to deny incoming traffic by default.
- **Fail2Ban**: Protects against brute-force attacks on SSH.

### Application Security
- **Container Security**: Images are scanned for vulnerabilities using Trivy.
- **Least Privilege**: Containers run as non-root users where possible.
- **Secrets Management**: Sensitive data (DB creds) passed via environment variables/GitHub Secrets.

### CI/CD Security
- **SAST**: CodeQL analysis for static code security.
- **Dependency Scanning**: Trivy scans npm dependencies.
- **Secret Scanning**: Gitleaks checks for exposed secrets in code.
- **IaC Scanning**: Checkov scans Terraform code for misconfigurations.
- **DAST**: OWASP ZAP scans the running application for vulnerabilities.

## Compliance
- **Logs**: System logs are monitored.
- **Updates**: Unattended upgrades enabled for security patches.
