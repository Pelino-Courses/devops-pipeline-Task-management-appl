# Complete Infrastructure Setup - Azure Portal Guide

## ✅ What's Already Done
- Resource Group: `devopspipeline-dev-rg`
- Virtual Network: `devopspipeline-dev-vnet`  
- Public IP: `devopspipeline-dev-pip`
- Network Security Group: `devopspipeline-dev-nsg`
- Container Registry: `devopspipelinedevacrefkscn`
- SSH Key: `devopspipeline-dev-sshkey`

## 🎯 What We Need to Add (5 minutes)

### Step 1: Add Subnet to VNet (1 min)
1. Go to Azure Portal: https://portal.azure.com
2. Navigate to **Resource Groups** → `devopspipeline-dev-rg`
3. Click on **devopspipeline-dev-vnet**
4. In left menu, click **Subnets**
5. Click **+ Subnet**
6. Fill in:
   - **Name**: `vm-subnet`
   - **Subnet address range**: `10.0.1.0/24`
7. Click **Save**

### Step 2: Create Network Interface (1 min)
1. In the same resource group, click **+ Create**
2. Search for **Network Interface** → Select → **Create**
3. Fill in:
   - **Resource group**: `devopspipeline-dev-rg`
   - **Name**: `devopspipeline-dev-nic`
   - **Region**: `South Africa North`
   - **Virtual network**: `devopspipeline-dev-vnet`
   - **Subnet**: `vm-subnet`
   - **Public IP address**: `devopspipeline-dev-pip`
   - **Network security group**: `devopspipeline-dev-nsg`
4. Click **Review + create** → **Create**

### Step 3: Create Virtual Machine (3 min)
1. In resource group, click **+ Create**
2. Search for **Virtual Machine** → **Create**
3. **Basics tab**:
   - **Resource group**: `devopspipeline-dev-rg`
   - **VM name**: `devopspipeline-dev-vm`
   - **Region**: `South Africa North`
   - **Image**: `Ubuntu Server 22.04 LTS`
   - **Size**: `Standard_B2s`
   - **Authentication type**: `SSH public key`
   - **Username**: `azureuser`
   - **SSH public key source**: `Use existing key stored in Azure`
   - **Stored Keys**: Select `devopspipeline-dev-sshkey`

4. **Disks tab**: (Keep defaults - Standard SSD)

5. **Networking tab**:
   - **Virtual network**: `devopspipeline-dev-vnet`
   - **Subnet**: `vm-subnet`
   - **Public IP**: `devopspipeline-dev-pip`
   - **NIC network security group**: `None` (NSG is already attached to subnet)
   - **Delete public IP and NIC when VM is deleted**: ✅ (checked)

6. **Management tab**:
   - **Enable auto-shutdown**: ❌ (unchecked)

7. **Tags**: Add these three tags:
   - `Environment` = `dev`
   - `ManagedBy` = `Portal`
   - `Project` = `devopspipeline`

8. Click **Review + create** → **Create**

## ✅ Verify Completion
Once VM is created:
1. Go to **devopspipeline-dev-pip** resource
2. **Copy the Public IP address** - this is your app URL!

## 🚀 Next Steps

### 1. Get ACR Password (30 seconds)
```powershell
# Run this in PowerShell
cd terraform
Get-Content .\ssh-key | clip  # Copies private key to clipboard
```

In Azure Portal:
1. Go to **devopspipelinedevacrefkscn** (Container Registry)
2. Left menu → **Access keys**
3. Enable **Admin user**
4. Copy **password** value

### 2. Configure GitHub Secrets (5 minutes)
Follow **GITHUB_SECRETS_SETUP.md** to add all required secrets.

### 3. Push to Deploy! (Automatic)
```bash
git add .
git commit -m "Enable auto-deployment"
git push origin main
```

Watch deployment at: `https://github.com/Alain275/devops-pipeline-Task-management-application/actions`

## 🎉 Result
Your app will be live at: `http://<YOUR_VM_PUBLIC_IP>`

Every code push automatically:
- ✅ Builds new images
- ✅ Pushes to ACR
- ✅ Deploys to VM
- ✅ Restarts containers
