function Send-CustomEmail {
    <#
    .SYNOPIS
    Sends email with different Mail.From and Header.From address

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
        [string]$smtpServer = "smtp.example.com"
    )

    # Create email object
    $MailMessage = New-Object System.Net.Mail.MailMessage
    $SMTPClient = New-Object System.Net.Mail.smtpClient

    $SMTPClient.host = $smtpServer
    $MailMessage.Sender = $MailFrom
    $MailMessage.From = $HeaderFrom
    $MailMessage.To.add($Recipient)
    $MailMessage.Subject = $Subject
    $MailMessage.Body = $Body
    if ($Attach) {$MailMessage.attachments.add($Attach)}

    # Send email
    $SMTPClient.Send($MailMessage)
}