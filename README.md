# Introduction
All about Powershell scripting from references to sample scripts.

# Core Module
**CoreModule** is a custom Powershell module that contains all commonly used functions shared by other scripts. I guess the easiest way to use this module is to copy the Core-Module folder to `C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\`, but it may not be the most secure way. Please share if you know a better approach. After that, functions in this module can be used anywhere on the machine without having to explicitly run `Import-Module CoreModule.psm1 -Force`.

To reload the module in a session, run 
```
Import-Module CoreModule -Force
````
### Send-CustomEmail
This function can be used to test email spoofing and troubleshoot issues with SPF, DKIM, and DMARC records.

# References
## Best Practices

## Good Read
- https://social.technet.microsoft.com/wiki/contents/articles/7803.powershell-deep-dive-and-best-practice.aspx: Scope, workflows, debugging, using WMI, snappins, and profiles/execution policies
- https://kevinmarquette.github.io/2017-05-27-Powershell-module-building-basics/: Powershell: Building a Module, one microstep at a time
