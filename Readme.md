

One Liner Script :
 iwr "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" -OutFile "$env:TEMP\setup-digi-agent.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\setup-digi-agent.ps1" -ManagerIP "add manager ip here" -AgentName "add pc name here"