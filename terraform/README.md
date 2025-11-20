# Terraform Infrastructure Setup Guide

This guide will help you set up Azure infrastructure using Terraform Cloud.

## Prerequisites

✅ Terraform Cloud account (app.terraform.io)  
✅ Microsoft Azure account  
✅ Azure CLI installed  
✅ Terraform CLI installed

## Step-by-Step Guide

### Step 1: Create Azure Service Principal

1. Open PowerShell and login to Azure:
```powershell
az login
```

2. Get your subscription ID:
```powershell
az account show --query id --output tsv
```

3. Create service principal (replace YOUR_SUBSCRIPTION_ID):
```powershell
az ad sp create-for-rbac --name "devops-pipeline-sp" --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
```

4. **Save the output** - you'll need these values:
```json
{
  "appId": "YOUR_CLIENT_ID",
  "displayName": "devops-pipeline-sp",
  "password": "YOUR_CLIENT_SECRET",
  "tenant": "YOUR_TENANT_ID"
}
```

### Step 2: Set Up Terraform Cloud

1. Go to https://app.terraform.io
2. Sign in to your account
3. Click "New workspace"
4. Select "CLI-driven workflow"
5. Name it: `devops-pipeline-infrastructure`
6. Click "Create workspace"

### Step 3: Configure Workspace Variables

In your Terraform Cloud workspace, go to "Variables" and add:

**Environment Variables** (for Azure authentication):
- `ARM_CLIENT_ID` = appId from Step 1 (not sensitive)
- `ARM_CLIENT_SECRET` = password from Step 1 (**MARK AS SENSITIVE**)
- `ARM_SUBSCRIPTION_ID` = your subscription ID (not sensitive)
- `ARM_TENANT_ID` = tenant from Step 1 (not sensitive)

**Terraform Variables** (for infrastructure configuration):
- `ssh_public_key` = your SSH public key (**MARK AS SENSITIVE**)

### Step 4: Update backend.tf

Edit `terraform/backend.tf` and replace `your-org-name` with your Terraform Cloud organization name.

### Step 5: Generate SSH Key Pair

```powershell
# Create .ssh directory if it doesn't exist
mkdir -Force ~\.ssh

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -f ~\.ssh\devops-pipeline -N '""'

# Display public key
Get-Content ~\.ssh\devops-pipeline.pub
```

Copy the public key output and add it to Terraform Cloud workspace variables as `ssh_public_key`.

### Step 6: Login to Terraform Cloud

```powershell
cd terraform
terraform login
```

Follow the prompts to authenticate.

### Step 7: Initialize Terraform

```powershell
terraform init
```

You should see: "Terraform has been successfully initialized!"

### Step 8: Validate Configuration

```powershell
terraform validate
```

Should return: "Success! The configuration is valid."

### Step 9: Plan Infrastructure

```powershell
terraform plan
```

Review the plan to see what resources will be created:
- 1 Resource Group
- 1 Virtual Network
- 1 Subnet
- 1 Network Security Group
- 1 Public IP
- 1 Network Interface
- 1 SSH Public Key
- 1 Linux VM (Ubuntu 22.04)
- 1 Container Registry
- 1 Role Assignment

### Step 10: Apply Infrastructure

```powershell
terraform apply
```

Type `yes` when prompted. This will take 5-10 minutes.

### Step 11: Save Outputs

```powershell
terraform output -json | Out-File -FilePath ..\terraform-outputs.json
```

## What Gets Created

### Networking
- **Resource Group**: Main container for all resources
- **Virtual Network**: 10.0.0.0/16 address space
- **Subnet**: 10.0.1.0/24 for VM
- **Network Security Group**: Allows SSH (22), HTTP (80), HTTPS (443), App (3000)
- **Public IP**: Static IP for VM access

### Compute
- **Virtual Machine**: Ubuntu 22.04 LTS, Standard_B2s
  - 30 GB SSD
  - System-assigned managed identity
  - SSH access with your key

### Container Registry
- **Azure Container Registry**: Basic SKU
  - Admin access enabled
  - VM has AcrPull role to pull images

## Accessing Your VM

After apply completes, get the public IP:
```powershell
terraform output vm_public_ip
```

SSH to your VM:
```powershell
ssh -i ~\.ssh\devops-pipeline azureuser@<VM_PUBLIC_IP>
```

## Viewing Resources in Azure Portal

1. Go to https://portal.azure.com
2. Search for your resource group: `devopspipeline-dev-rg`
3. You'll see all created resources

## Destroying Infrastructure (When Done)

```powershell
terraform destroy
```

Type `yes` to confirm. This will delete all Azure resources.

## Troubleshooting

### Error: Invalid credentials
- Check your ARM_* environment variables in Terraform Cloud
- Ensure service principal has Contributor role

### Error: Quota exceeded
- Check your Azure subscription quotas
- Try a smaller VM size in variables.tf

### Error: Name already exists
- ACR names must be globally unique
- Change project_name in variables.tf

## Cost Estimate

With default configuration (~$40-50/month):
- VM (Standard_B2s): ~$30/month
- Public IP (Static): ~$3/month
- Container Registry (Basic): ~$5/month
- Network/Storage: ~$5/month

**Remember to destroy resources when not in use!**

## Next Steps

After infrastructure is created:
1. Configure GitHub Secrets with ACR credentials
2. Update CI/CD pipeline to push images to ACR
3. Deploy application to VM using Docker
4. Set up monitoring and logging
