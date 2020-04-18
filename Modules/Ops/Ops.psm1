function Send-CustomEmail {
    <#
    .SYNOPIS
        Sends an email with different Mail.From and Header.From address

    .EXAMPLE
        Send-CustomEmail -MailFrom "mailfrom@example.com" -HeaderFrom "header@example.com" -Recipient "someone@gmail.com" -Subject "Test"
    #>

    param (
        [string]$MailFrom,
        [string]$HeaderFrom,
        [string]$Recipient,
        [string]$Subject,
        [string]$Body,
        [string]$Attach,
        [string]$SmtpServer = "smtp.example.com"
    )

    # Create email object
    $MailMessage = New-Object System.Net.Mail.MailMessage
    $SMTPClient = New-Object System.Net.Mail.smtpClient

    $SMTPClient.host = $SmtpServer
    $MailMessage.Sender = $MailFrom
    $MailMessage.From = $HeaderFrom
    $MailMessage.To.add($Recipient)
    $MailMessage.Subject = $Subject
    $MailMessage.Body = $Body
    if ($Attach) {$MailMessage.attachments.add($Attach)}

    # Send email
    $SMTPClient.Send($MailMessage)
}

function Convert-SecureStringToText {
    <#
    .SYNOPIS
        Converts secure string back to plain text

    .PARAMETER SecureString
        Specifies a secure string

    .EXAMPLE
        Convert-SecureStringToText -SecureString $password
    #>

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        $SecureString
    )
    Process {
        [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecureString))
    }
}