# Deployment Guide

## Prerequisites
- Azure Subscription
- Terraform Cloud Account
- GitHub Account
- Azure Service Principal

## Infrastructure Deployment (Terraform)
1. **Configure Terraform Cloud**:
   - Create a workspace named `devops-pipeline-infrastructure`.
   - Set Execution Mode to `Remote`.
   - Add the following variables:
     - `ARM_CLIENT_ID`
     - `ARM_CLIENT_SECRET`
     - `ARM_TENANT_ID`
     - `ARM_SUBSCRIPTION_ID`
     - `ssh_public_key`

2. **Run Terraform**:
   - Locally: `cd terraform && terraform init && terraform apply`
   - Via CI/CD: Push changes to `terraform/` directory.

## Application Deployment (Ansible & GitHub Actions)
The application deployment is automated via GitHub Actions (`.github/workflows/cd-pipeline.yml`).

### Pipeline Steps:
1. **Build & Push**: Docker images for frontend and backend are built and pushed to Azure Container Registry (ACR).
2. **Deploy**: Ansible playbook `setup-server.yml` is executed on the Azure VM.
   - Installs Docker & Security tools.
   - Pulls latest images from ACR.
   - Starts containers using Docker Compose.

### Manual Deployment (Optional)
To run Ansible manually:
```bash
ansible-playbook -i ansible/inventory/azure_rm.yml ansible/playbooks/setup-server.yml
```
