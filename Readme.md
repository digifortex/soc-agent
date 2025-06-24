

One Liner Script :
irm "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" | iex -Args "add ip here", "name-of-the-pc here"

Safer version:
$scriptPath = "$env:TEMP\setup-digi-agent.ps1"
Invoke-WebRequest "https://raw.githubusercontent.com/digifortex/soc-agent/main/windows/setup-digi-agent.ps1" -OutFile $scriptPath
powershell -ExecutionPolicy Bypass -File $scriptPath -ManagerIP "49.249.133.170" -AgentName "satya-pc"



param : The term 'param' is not recognized as the name of a cmdlet, function, script file, or operable program. Check
the spelling of the name, or if a path was included, verify that the path is correct and try again.
At C:\Users\aurod\AppData\Local\Temp\setup-digi-agent.ps1:7 char:1
+ param (
+ ~~~~~
    + CategoryInfo          : ObjectNotFound: (param:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
