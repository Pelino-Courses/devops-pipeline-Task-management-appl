# Quick Setup Script - Get SSH Private Key for GitHub

Write-Host "=== SSH Private Key for GitHub Secrets ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "Copy the ENTIRE output below (including BEGIN and END lines)" -ForegroundColor Yellow
Write-Host "Use this as the value for the SSH_PRIVATE_KEY secret in GitHub" -ForegroundColor Yellow
Write-Host ""
Write-Host "======== START COPYING HERE ========" -ForegroundColor Green

Get-Content "C:\Users\DELL\Desktop\devops-pipeline-Task-management-application\terraform\github-deploy-key"

Write-Host "======== STOP COPYING HERE ========" -ForegroundColor Green
Write-Host ""
Write-Host "Next: Go to https://github.com/Alain275/devops-pipeline-Task-management-application/settings/secrets/actions" -ForegroundColor Cyan
Write-Host "Create secret named: SSH_PRIVATE_KEY" -ForegroundColor White
Write-Host "Paste the content above as the value" -ForegroundColor White
