# Display available Python versions
Write-Host "Choose the Python version you want to install:"
Write-Host "1) Python 3.12.0 (latest stable)"
Write-Host "2) Python 3.11.6"
Write-Host "3) Python 3.10.12"
Write-Host "4) Python 3.9.18 (LTS)"
Write-Host "5) Exit"

# Get user input
$choice = Read-Host "Enter the number corresponding to your choice"

# Define download URLs for the Python installers
$pythonUrls = @{
    "1" = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
    "2" = "https://www.python.org/ftp/python/3.11.6/python-3.11.6-amd64.exe"
    "3" = "https://www.python.org/ftp/python/3.10.12/python-3.10.12-amd64.exe"
    "4" = "https://www.python.org/ftp/python/3.9.18/python-3.9.18-amd64.exe"
}

# Check if the user selected a valid option
if ($choice -eq "5") {
    Write-Host "Exiting the script. Goodbye!"
    exit
} elseif ($pythonUrls.ContainsKey($choice)) {
    $url = $pythonUrls[$choice]
    $installer = "$env:TEMP\python-installer.exe"

    # Download the installer
    Write-Host "Downloading Python installer from $url..."
    Invoke-WebRequest -Uri $url -OutFile $installer

    # Run the installer silently
    Write-Host "Installing Python. This may take a few minutes..."
    Start-Process -FilePath $installer -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait

    # Verify installation
    Write-Host "Verifying Python installation..."
    $pythonPath = (Get-Command python).Source
    if ($pythonPath) {
        Write-Host "Python successfully installed at $pythonPath."
        python --version
    } else {
        Write-Host "Python installation failed. Please check the logs."
    }

    # Clean up
    Remove-Item $installer -Force
} else {
    Write-Host "Invalid selection. Please run the script again."
}
