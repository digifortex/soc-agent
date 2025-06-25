param (
    [Parameter(Mandatory = $true)]
    [string]$ManagerIP,

    [Parameter(Mandatory = $true)]
    [string]$AgentName
)


# Check for Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Error: Please run this script as an Administrator!" -ForegroundColor Red
    exit 1
}

# ==============================================
# Download MSI from S3
# ==============================================
$downloadUrl = "https://digi-agents-pro.s3.ap-south-1.amazonaws.com/digi-agent.msi"
$localInstallerPath = "$env:TEMP\digi-agent.msi"

Write-Host "Downloading installer from $downloadUrl..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $localInstallerPath

# ==============================================
# Install digi-agent silently
# ==============================================
Write-Host "Installing digi-agent with ManagerIP = $ManagerIP and AgentName = $AgentName..."
Start-Process -FilePath $localInstallerPath `
    -ArgumentList "/q DIGI_MANAGER=$ManagerIP DIGI_AGENT_NAME=$AgentName" `
    -Wait

# ============================
# Wait briefly before next steps
# ============================
Start-Sleep -Seconds 1

# ==============================================
# Clean internal_options.conf
# ==============================================
$inputFile = "C:\Program Files (x86)\ossec-agent\internal_options.conf"
$tempFile = "$inputFile.cleaned"

# Write-Host "Sanitizing internal_options.conf..."
if (Test-Path $inputFile) {
    Get-Content $inputFile | ForEach-Object {
        $_ -replace '[^\x00-\x7F]', ''
    } | Set-Content -Encoding ascii $tempFile

    Remove-Item $inputFile -Force
    Rename-Item -Path $tempFile -NewName (Split-Path $inputFile -Leaf)
    # Write-Host "internal_options.conf cleaned successfully."
} else {
    Write-Host "Error: $inputFile not found!"
    exit 1
}

# ============================
# Start DigiSvc
# ============================
Write-Host "Starting DigiSvc service..."
Start-Service -Name DigiSvc

# ============================
# Cleanup Installer
# ============================
if (Test-Path $localInstallerPath) {
    Remove-Item $localInstallerPath -Force
    Write-Host "Installer file cleaned up."
}

# ============================
# Self-Destruct Script (Optional)
# ============================
# Remove script if it was downloaded to TEMP
$myPath = $MyInvocation.MyCommand.Definition
if ($myPath -like "$env:TEMP\*") {
    Write-Host "Cleaning up script: $myPath"
    Start-Sleep -Seconds 2
    Remove-Item $myPath -Force
}

Write-Host "`n===> Digi Agent setup completed successfully! <===`n" -ForegroundColor Green
