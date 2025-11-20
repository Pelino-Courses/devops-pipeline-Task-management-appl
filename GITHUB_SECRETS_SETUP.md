# GitHub Secrets Configuration for Automatic Deployment

## 🎯 Goal
Configure GitHub secrets so that **every code change** automatically triggers:
1. Building new Docker images
2. Pushing to Azure Container Registry
3. Deploying to your VM via Ansible

## 🔐 Required GitHub Secrets

Go to: **Your Repo → Settings → Secrets and variables → Actions → New repository secret**

### Azure Credentials
```
TF_API_TOKEN
Value: <Your Terraform Cloud API Token>

AZURE_CLIENT_ID
Value: 696ba8e3-0be5-4fd5-ba31-11b43224366f

AZURE_CLIENT_SECRET
Value: dpu8Q~qbRbk8d1h9QWSI~cjps6V~Ff3FzKPIdayg

AZURE_TENANT_ID
Value: f946d46c-1763-482f-931d-f5389eb60728

AZURE_SUBSCRIPTION_ID
Value: 0961e932-2c86-4df1-adeb-48aa98efb487
```

### Container Registry (Get from Azure Portal)
```
ACR_NAME
Value: devopspipelinedevacrefkscn

ACR_LOGIN_SERVER
Value: devopspipelinedevacrefkscn.azurecr.io

ACR_USERNAME
Value: devopspipelinedevacrefkscn

ACR_PASSWORD
Value: <Get from Azure Portal - ACR → Access keys → Enable Admin user → password>
```

**To get ACR credentials:**
```powershell
az acr credential show --name devopspipelinedevacrefkscn --query "passwords[0].value" -o tsv
```

### Database Credentials
```
DB_USER
Value: taskapp

DB_PASSWORD
Value: <Generate a strong password>

DB_NAME
Value: taskmanagement
```

### SSH Key (For Ansible)
```
SSH_PRIVATE_KEY
Value: <Content of terraform/ssh-key (the private key file)>
```

**To copy private key:**
```powershell
Get-Content terraform\ssh-key | clip
```

## ✅ How to Verify Setup

1. **Add all secrets** to GitHub
2. **Push any code change** to main branch:
   ```bash
   git add .
   git commit -m "Test auto-deployment"
   git push origin main
   ```
3. **Watch the magic happen** at: `https://github.com/<your-username>/<repo>/actions`

## 🚀 What Happens Automatically

When you push to `main`:
1. ✅ **CI Pipeline** runs (lint, test, security scan)
2. ✅ **CD Pipeline** runs:
   - Builds Docker images for frontend & backend
   - Pushes images to Azure Container Registry
   - Connects to your VM via SSH
   - Runs Ansible playbook to:
     - Install Docker & security tools
     - Pull latest images
     - Start containers with Docker Compose
3. ✅ **App is live** at your VM's public IP!

## 🔄 Continuous Deployment

Every time you:
- Fix a bug
- Add a feature  
- Update dependencies

Just `git push` and your live app updates automatically! 🎉
