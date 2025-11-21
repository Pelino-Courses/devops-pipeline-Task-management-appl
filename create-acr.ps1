# Script to create Azure Container Registry
# Run this in PowerShell where Azure CLI is available

Write-Host "Creating Azure Container Registry..." -ForegroundColor Yellow

# Create ACR
az acr create `
    --resource-group devopspipeline-dev-rg `
    --name devopspipelinedevacr `
    --sku Basic `
    --admin-enabled true `
    --location southafricanorth

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nACR created successfully!" -ForegroundColor Green
    
    Write-Host "`nGetting ACR credentials..." -ForegroundColor Yellow
    az acr credential show --name devopspipelinedevacr --resource-group devopspipeline-dev-rg
    
    Write-Host "`n`n==================================================" -ForegroundColor Cyan
    Write-Host "NEXT STEPS:" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Cyan
    Write-Host "1. Copy the USERNAME and PASSWORD from above" -ForegroundColor White
    Write-Host "2. Go to GitHub Secrets: https://github.com/Pelino-Courses/devops-pipeline-Task-management-appl/settings/secrets/actions" -ForegroundColor White
    Write-Host "3. Update these secrets:" -ForegroundColor White
    Write-Host "   - ACR_USERNAME = <username from above>" -ForegroundColor Yellow
    Write-Host "   - ACR_PASSWORD = <password1 from above>" -ForegroundColor Yellow
    Write-Host "   - ACR_LOGIN_SERVER = devopspipelinedevacr.azurecr.io" -ForegroundColor Yellow
    Write-Host "4. Push a dummy commit to trigger deployment" -ForegroundColor White
    Write-Host "==================================================" -ForegroundColor Cyan
} else {
    Write-Host "`nFailed to create ACR. Check the error above." -ForegroundColor Red
}
