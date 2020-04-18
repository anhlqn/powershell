<# 
.SYNOPSIS
    Schedule nmap scans.

.DESCRIPTION
    Run nmap scans, compare results, and send out notifications.

.NOTES 
#>

# Variables contain script attributes
$me = $MyInvocation.MyCommand.Name
$scriptDir = Split-Path -parent $MyInvocation.MyCommand.Definition

### Script logs ###
$logDir = "$scriptDir\log"
New-Item -ItemType Directory -ErrorAction SilentlyContinue $logDir | Out-Null

# Runtime log
$transLog = "$logDir\$($me)_transLog.txt"
$monthlyTransLog = "$logDir\$($me)_$((Get-Date).ToString("yyyy-MM"))_transLog.txt"

# Error log
$errorLog = "$logDir\$($me)_errorLog.txt"
$monthlyErrorLog = "$logDir\$($me)_$((Get-Date).ToString("yyyy-MM"))_errorLog.txt"

# ---------------------- Script Configuration ----------------------

# Define nmap scans
$scans = @{
    "port-scan-1" = "nmap 192.168.0.1/24"
    "port-scan-2" = "nmap 172.16.0.0/24"
}

## Notification settings
$enableLogRotation = "true"  # true/false 
$emailTransLog = "true"  # true/false
$emailErrorLog = "false"  # true/false

$fromAddr = "do_not_reply@example.com"
$smtpServer = "smtp.example.com"
$smtpPort = 25

# Comma-separated Emails
$transLogEmails = "your_email@example.com"
$errorLogEmails = "your_email@example.com"

# ---------------------- SCRIPT IMPLEMENTATION ----------------------

## Check and write to runtime/error log
If (Test-Path $transLog) { Remove-Item $transLog -ErrorAction SilentlyContinue }
If (Test-Path $errorLog) { Remove-Item $errorLog -ErrorAction SilentlyContinue }
#Add-Content $transLog "`n----------------------------------------------------------"
#Add-Content $transLog "$(Get-Date) Script started ..."
# ----------------------

$scans.GetEnumerator() | foreach {
    # Rename if scan result exists
    If (Test-Path "$($_.Name).xml") {
        Move-Item "$($_.Name).xml" "$($_.Name)-prev.xml" -Force -ErrorAction SilentlyContinue
    }
    
    # Run nmap
    Invoke-Expression "nmap $($_.Value) -oX $($_.Name).xml" -ErrorAction SilentlyContinue
    
    # Compare nmap results
    If ((Test-Path "$($_.Name).xml") -and (Test-Path "$($_.Name)-prev.xml")) {
        Invoke-Expression "ndiff $($_.Name)-prev.xml $($_.Name).xml" -ErrorAction SilentlyContinue |
            Select-String -Pattern "Nmap" -NotMatch | Add-Content $transLog
    }
    
}

## Log rotation
If ($enableLogRotation -eq "true" -and (Test-Path $transLog) -and ((Get-Item $transLog).Length -gt 0KB) ) {
    Add-Content $monthlyTransLog "`n$(Get-Date) ----------------------`n"
    Get-Content $transLog | Add-Content $monthlyTransLog 
    }
If ($enableLogRotation -eq "true" -and (Test-Path $errorLog) -and ((Get-Item $errorLog).Length -gt 0KB) ) {
    Add-Content $monthlyErrorLog "`n$(Get-Date) ----------------------`n"
    Get-Content $errorLog | Add-Content $monthlyErrorLog 
}  
    
## Email logs
If ($emailTransLog -eq "true" -and (Test-Path $transLog) -and ((Get-Item $transLog).Length -gt 0KB) ) { 
    foreach ($email in $transLogEmails) {
        Send-MailMessage -From $fromAddr -To $email -Subject "$me Trans log" -Attachments $transLog -SmtpServer $smtpServer
    }
}

If ($emailErrorLog -eq "true" -and (Test-Path $errorLog) -and ((Get-Item $errorLog).Length -gt 0KB) ) {
    foreach ($email in $errorLogEmails) {
        Send-MailMessage -From $fromAddr -To $email -Subject "$me Error log" -Attachments $errorLog -SmtpServer $smtpServer
    }
}