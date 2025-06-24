# Digi Agent Windows Installer

This project provides an automated PowerShell script to install and configure the Digi Agent on Windows systems. The script downloads the latest agent MSI, installs it silently, sanitizes configuration files, starts the required service, and cleans up after itself.

---

## 🚀 Quick Start

### One-Liner Installation

Replace the placeholders with your actual **Manager IP** and **Agent Name** before running:

```powershell
iwr "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" -OutFile "$env:TEMP\setup-digi-agent.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\setup-digi-agent.ps1" -ManagerIP "<MANAGER_IP>" -AgentName "<AGENT_NAME>"
```

- `<MANAGER_IP>`: The IP address of your Digi Manager.
- `<AGENT_NAME>`: A unique name for this agent (e.g., your PC name).

---

## 📝 Script Features

- **Admin Check:** Ensures the script is run with administrator privileges.
- **Automated Download:** Fetches the latest Digi Agent MSI from S3.
- **Silent Install:** Installs the agent with your provided Manager IP and Agent Name.
- **Config Sanitization:** Cleans up `internal_options.conf` to remove non-ASCII characters.
- **Service Start:** Starts the Digi Agent service automatically.
- **Cleanup:** Removes the installer and (optionally) the script itself after installation.

---

## ⚠️ Requirements

- **Windows 10/11** (or compatible server OS)
- **PowerShell 5.1+**
- **Administrator privileges**

---

## 🛠️ Manual Installation Steps

1. **Download the script:**

   ```powershell
   Invoke-WebRequest "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" -OutFile "$env:TEMP\setup-digi-agent.ps1"
   ```

2. **Run the script with parameters:**
   ```powershell
   powershell -ExecutionPolicy Bypass -File "$env:TEMP\setup-digi-agent.ps1" -ManagerIP "<MANAGER_IP>" -AgentName "<AGENT_NAME>"
   ```

---

## 🧩 Troubleshooting

- **"param : The term 'param' is not recognized..."**  
  Make sure you are running the script as a file using `-File`, not with `iex` or by pasting into the console.

- **"Please run this script as an Administrator!"**  
  Right-click PowerShell and select **Run as administrator**.

---

## 📂 Project Structure

```
windows/
  └── setup-digi-agent.ps1
Readme.md
```

---

## 📄 License

MIT License (or your preferred license)

---

## 🤝 Contributing

Pull requests and issues are welcome! Please adhere to the project's coding standards and include tests for any new features or bug fixes.
