param (
    [Parameter(Mandatory = $true)]
    [string]$ManagerIP,

    [Parameter(Mandatory = $true)]
    [string]$AgentName
)

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
    -ArgumentList "/q DIGI_MANAGER='$ManagerIP' DIGI_AGENT_NAME='$AgentName'" `
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
    Write-Host "internal_options.conf cleaned successfully."
} else {
    Write-Host "Error: $inputFile not found!"
    exit 1
}

# ============================
# Start DigiSvc
# ============================
Write-Host "Starting DigiSvc service..."
Start-Service -Name DigiSvc

Write-Host "`n✅ Digi Agent setup completed successfully!"
