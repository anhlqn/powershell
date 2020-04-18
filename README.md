# Introduction
All about Powershell scripting from references to sample scripts.

# Main Module
**Ops** is a Powershell module that contains all commonly used functions shared by other scripts. Perhaps the easiest way to use this module is to copy the `Ops` folder to `C:\Program Files\WindowsPowerShell\Modules`. Please share if you know a better approach. After that, functions in this module can be used anywhere on the machine without having to explicitly run `Import-Module /path/to/Ops.psm1 -Force`.

To reload the module in a session, run 
```
Import-Module Ops -Force
````

### Send-CustomEmail
This function can be used to test email spoofing and troubleshoot issues with SPF, DKIM, and DMARC records.

# References
## Best Practices

## Good Read
- https://social.technet.microsoft.com/wiki/contents/articles/7803.powershell-deep-dive-and-best-practice.aspx: Scope, workflows, debugging, using WMI, snappins, and profiles/execution policies
- https://kevinmarquette.github.io/2017-05-27-Powershell-module-building-basics/: Powershell: Building a Module, one microstep at a time
- https://poshcode.gitbooks.io/powershell-practice-and-style/: The PowerShell Best Practices and Style Guide