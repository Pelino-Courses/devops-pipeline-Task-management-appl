# 🚀 Complete Infrastructure with Ansible

## Prerequisites
- Ansible installed
- Azure CLI logged in
- Existing resources from Terraform (RG, VNet, NSG, Public IP, SSH Key, ACR)

## Quick Setup (5 minutes)

### Step 1: Install Ansible Azure Collection
```bash
cd ansible
ansible-galaxy collection install -r requirements.yml
```

### Step 2: Set Azure Credentials as Environment Variables
```powershell
# Run in PowerShell
$env:AZURE_CLIENT_ID = "696ba8e3-0be5-4fd5-ba31-11b43224366f"
$env:AZURE_SECRET = "dpu8Q~qbRbk8d1h9QWSI~cjps6V~Ff3FzKPIdayg"
$env:AZURE_TENANT = "f946d46c-1763-482f-931d-f5389eb60728"
$env:AZURE_SUBSCRIPTION_ID = "0961e932-2c86-4df1-adeb-48aa98efb487"
```

### Step 3: Run the Playbook
```bash
cd ansible
ansible-playbook playbooks/provision-infrastructure.yml
```

## What It Does
1. ✅ Creates subnet in existing VNet
2. ✅ Creates network interface with Public IP & NSG
3. ✅ Creates Ubuntu 22.04 VM (Standard_B2s)
4. ✅ Displays VM public IP address

## Expected Output
```
TASK [Display VM information] **************
ok: [localhost] => {
    "msg": [
        "=== Infrastructure Complete! ===",
        "VM Name: devopspipeline-dev-vm",
        "Public IP: <YOUR_IP>",
        "SSH Command: ssh azureuser@<YOUR_IP>",
        "Next: Configure GitHub Secrets and push code to deploy!"
    ]
}
```

## After Completion
1. **Copy the Public IP** from output
2. Follow **GITHUB_SECRETS_SETUP.md** to configure automation
3. Push code to deploy!

## Troubleshooting

### Error: "azure.azcollection not found"
```bash
ansible-galaxy collection install azure.azcollection
```

### Error: "Unable to authenticate"
- Verify environment variables are set
- Or use Azure CLI: `az login`

### Check existing resources
```bash
ansible-playbook playbooks/provision-infrastructure.yml --check
```
