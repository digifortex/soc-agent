

One Liner Script :
irm "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" | iex -Args "add ip here", "name-of-the-pc here"

Safer version:
$scriptPath = "$env:TEMP\setup-digi-agent.ps1"
Invoke-WebRequest "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" -OutFile $scriptPath
powershell -ExecutionPolicy Bypass -File $scriptPath -ManagerIP "49.249.133.170" -AgentName "satya-pc"
