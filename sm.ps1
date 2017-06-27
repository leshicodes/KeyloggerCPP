﻿Param( [String]$Att, 
       [String]$Subj,
       [String]$Body
     )

Function Send-Mail
{
    Param(
            [Parameter(Mandatory=$true)] [string]$To, 
            [Parameter(Mandatory=$true)] [string]$From,
            [Parameter(Mandatory=$true)] [string]$Password,
            [Parameter(Mandatory=$true)] [string]$Subject,
            [Parameter(Mandatory=$true)] [string]$Body,
            [Parameter(Mandatory=$true)] [string]$Attachment
        )

	try
	{
		$Msg = New-Object System.Net.Mail.MailMessage($From, $To, $Subject, $Body)
		$Srv = "smtp.gmail.com"
		if($Attachment -ne $null)
		{
			try
			{
				$attachments = $Attachment -split ("\:\:");

				ForEach($val in $attachments)
				{
					$attach = New-Object System.Net.Mail.Attachment($val)
					$Msg.Attachments.Add($attach) 
				}
			}
			catch
			{
				exit 2;
			}

			$Client = New-Object Net.Mail.SmtpClient($Srv, 587)
			$Client.EnableSsl = $true
			$Client.Credentials = New-Object System.Net.NetworkCredential($From.Split("@")[0], $Password)
			$Client.Send($Msg)
			Remove-Variable -Name Client
			Remove-Variable -Name Password
			exit 7;
		}
	} catch {
			exit 3;
	}
}

try {
	Send-Mail -To "galaxy21982198@gmail.com" -From "galaxy21982198@gmail.com" -Password "8912eDuuD?" -Body $Body -Subject $Subj -Attachment $Att
} catch {
    exit 4;
}