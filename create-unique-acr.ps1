# Create ACR with unique name
az acr create --resource-group devopspipeline-dev-rg --name taskmanagementacr2025 --sku Basic --admin-enabled true --location southafricanorth

# Get ACR credentials
az acr credential show --name taskmanagementacr2025
