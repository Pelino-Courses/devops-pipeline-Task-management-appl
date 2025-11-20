# Complete Azure Infrastructure using Azure CLI (with direct path)
Write-Host "=== Completing Azure Infrastructure ===" -ForegroundColor Cyan

$azPath = "C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin\az.cmd"
if (!(Test-Path $azPath)) {
    $azPath = "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd"
}

if (!(Test-Path $azPath)) {
    Write-Host "ERROR: Azure CLI not found. Trying system az command..." -ForegroundColor Red
    $azPath = "az"
}

$resourceGroup = "devopspipeline-dev-rg"
$location = "southafricanorth"

Write-Host "`nStep 1/3: Creating Subnet..." -ForegroundColor Yellow
& $azPath network vnet subnet create `
    --resource-group $resourceGroup `
    --vnet-name "devopspipeline-dev-vnet" `
    --name "vm-subnet" `
    --address-prefixes 10.0.1.0/24

Write-Host "`nStep 2/3: Creating Network Interface..." -ForegroundColor Yellow
& $azPath network nic create `
    --resource-group $resourceGroup `
    --name "devopspipeline-dev-nic" `
    --vnet-name "devopspipeline-dev-vnet" `
    --subnet "vm-subnet" `
    --network-security-group "devopspipeline-dev-nsg" `
    --public-ip-address "devopspipeline-dev-pip"

Write-Host "`nStep 3/3: Creating Virtual Machine..." -ForegroundColor Yellow
Write-Host "This will take ~2 minutes..." -ForegroundColor Gray

& $azPath vm create `
    --resource-group $resourceGroup `
    --name "devopspipeline-dev-vm" `
    --location $location `
    --nics "devopspipeline-dev-nic" `
    --image Ubuntu2204 `
    --size Standard_B2s `
    --admin-username azureuser `
    --ssh-key-name "devopspipeline-dev-sshkey" `
    --tags Environment=dev ManagedBy=AzureCLI Project=devopspipeline

Write-Host "`nGetting VM Public IP..." -ForegroundColor Yellow
$publicIp = & $azPath network public-ip show `
    --resource-group $resourceGroup `
    --name "devopspipeline-dev-pip" `
    --query ipAddress `
    --output tsv

Write-Host "`n=== INFRASTRUCTURE COMPLETE! ===" -ForegroundColor Green
Write-Host "VM Public IP: $publicIp" -ForegroundColor Cyan
Write-Host "`nSSH Command: ssh azureuser@$publicIp" -ForegroundColor White
Write-Host "`nNext: Configure GitHub Secrets!" -ForegroundColor Yellow
