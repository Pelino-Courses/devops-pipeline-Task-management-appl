# Complete Azure Infrastructure Setup
# This script completes the remaining resources that Terraform started

Write-Host "=== Completing Azure Infrastructure ===" -ForegroundColor Cyan

# Variables from existing resources
$resourceGroup = "devopspipeline-dev-rg"
$location = "southafricanorth"
$vnetName = "devopspipeline-dev-vnet"
$subnetName = "vm-subnet"
$nsgName = "devopspipeline-dev-nsg"
$publicIpName = "devopspipeline-dev-pip"
$nicName = "devopspipeline-dev-nic"
$vmName = "devopspipeline-dev-vm"
$sshKeyName = "devopspipeline-dev-sshkey"

Write-Host "Step 1: Creating Subnet..." -ForegroundColor Yellow
az network vnet subnet create `
    --resource-group $resourceGroup `
    --vnet-name $vnetName `
    --name $subnetName `
    --address-prefixes 10.0.1.0/24

Write-Host "Step 2: Creating Network Interface..." -ForegroundColor Yellow
az network nic create `
    --resource-group $resourceGroup `
    --name $nicName `
    --vnet-name $vnetName `
    --subnet $subnetName `
    --public-ip-address $publicIpName `
    --network-security-group $nsgName

Write-Host "Step 3: Creating Virtual Machine..." -ForegroundColor Yellow
az vm create `
    --resource-group $resourceGroup `
    --name $vmName `
    --location $location `
    --nics $nicName `
    --image Ubuntu2204 `
    --size Standard_B2s `
    --admin-username azureuser `
    --ssh-key-name $sshKeyName `
    --tags Environment=dev ManagedBy=AzureCLI Project=devopspipeline

Write-Host "Step 4: Getting VM Public IP..." -ForegroundColor Yellow
$vmPublicIp = az network public-ip show `
    --resource-group $resourceGroup `
    --name $publicIpName `
    --query ipAddress `
    --output tsv

Write-Host "`n=== Infrastructure Complete! ===" -ForegroundColor Green
Write-Host "VM Public IP: $vmPublicIp" -ForegroundColor Green
Write-Host "`nNext Steps:" -ForegroundColor Cyan
Write-Host "1. Configure GitHub Secrets (see GITHUB_SECRETS_SETUP.md)" -ForegroundColor White
Write-Host "2. Push your code to trigger automatic deployment" -ForegroundColor White
Write-Host "3. Access your app at: http://$vmPublicIp" -ForegroundColor White
