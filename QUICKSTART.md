# 🎯 Quick Start - Automated Infrastructure & Deployment

## Option 1: Ansible Automation (Recommended - 5 minutes)

### 1. Complete Infrastructure with Ansible
```bash
# Install Azure collection
cd ansible
ansible-galaxy collection install -r requirements.yml

# Set Azure credentials
$env:AZURE_CLIENT_ID = "696ba8e3-0be5-4fd5-ba31-11b43224366f"
$env:AZURE_SECRET = "dpu8Q~qbRbk8d1h9QWSI~cjps6V~Ff3FzKPIdayg"
$env:AZURE_TENANT = "f946d46c-1763-482f-931d-f5389eb60728"
$env:AZURE_SUBSCRIPTION_ID = "0961e932-2c86-4df1-adeb-48aa98efb487"

# Provision remaining infrastructure (Subnet, NIC, VM)
ansible-playbook playbooks/provision-infrastructure.yml
```

**See**: `ansible/PROVISION_INFRASTRUCTURE.md` for details

### 2. Configure Automation (5 minutes)
Follow `GITHUB_SECRETS_SETUP.md` to add 12 GitHub secrets

### 3. Deploy! (Automatic)
```bash
git add .
git commit -m "Enable auto-deployment"
git push origin main
```

**Done!** Your app auto-deploys on every code push! 🚀

---

## Option 2: Manual Azure Portal (15 minutes)
If Ansible doesn't work, follow `COMPLETE_INFRASTRUCTURE.md` for manual steps.

---

## 🎉 After Setup
Every code push triggers:
1. ✅ CI Pipeline (tests, security scans)
2. ✅ CD Pipeline (builds, deploys to VM)
3. ✅ Live app updates automatically!

**Access your app**: `http://<YOUR_VM_PUBLIC_IP>`
