# Define the backup location
$destination = "Enter Destination "

#$computername = gc env:computername

if(!(test-path "$destination\$env:username + \ "))
{
  new-item "$destination\$env:username" -ItemType Directory

    if(!(test-path "$destination\$env:username"))
    {
      new-item "$destination\$env:username"   -ItemType Directory

     new-item "$destination\$env:username\AppData\Local\Microsoft\Outlook"   -ItemType Directory
     new-item "$destination\$env:username\Desktop"                           -ItemType Directory
     new-item "$destination\$env:username\Downloads"                         -ItemType Directory
     new-item "$destination\$env:username\Favorites"                         -ItemType Directory
     new-item "$destination\$env:username\Documents"                         -ItemType Directory
     new-item "$destination\$env:username\Cookies"                           -ItemType Directory
     new-item "$destination\$env:username\Pictures"                           -ItemType Directory

}}

Robocopy.exe "$env:userprofile\"                                      "$destination\$env:username\"                             /tee /log:"$destination\$env:username\Log.txt"  /zb /IPG:550 /FFT /XX /MIR  /Z /XA:SH /XD "AppData" "OneDrive - M+R Spedag Group" /XJD /R:1 /W:1 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA
#Robocopy.exe "$env:userprofile\AppData\Local\Microsoft\Outlook"                 "$destination\$env:username\Outlook"                               /tee /log:"$destination\$env:username\Outlook.txt"     /XX /MIR /z /XA:SH /XD /XJD /R:1 /W:1 /MT:32 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA
#Robocopy.exe "$env:userprofile\Desktop"                                        "$destination\$env:username\desktop"                               /tee /log:"$destination\$env:username\desktop.txt"     /XX /MIR  /z /XA:SH /XD /XJD /R:1 /W:1 /MT:32 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA  
#Robocopy.exe "$env:userprofile\Downloads"                                      "$destination\$env:username\Downloads"                             /tee /log:"$destination\$env:username\Downloads.txt"   /XX /MIR  /z /XA:SH /XD /XJD /R:1 /W:1 /MT:32 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA 
#Robocopy.exe "$env:userprofile\Favorites"                                      "$destination\$env:username\Favorites"                             /tee /log:"$destination\$env:username\Favorites.txt"   /XX /MIR  /z /XA:SH /XD /XJD /R:1 /W:1 /MT:32 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA 
#Robocopy.exe "$env:userprofile\cookies"                                        "$destination\$env:username\cookies"                               /tee /log:"$destination\$env:username\cookies.txt"     /XX /MIR  /z /XA:SH /XD /XJD /R:1 /W:1 /MT:32 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA 
#Robocopy.exe "$env:userprofile\Pictures"                                        "$destination\$env:username\Pictures"                              /tee /log:"$destination\$env:username\Pictures.txt"    /XX /MIR /z /XA:SH /XD /XJD /R:1 /W:1 /MT:32 /V /NP /XF   *.mp3 *.mp4  *.ost   *.iso  *.avi *.lnk *.exe *.FLV *.mkv *.MOV *.MWV *.amv /ETA 





# The following attempts to get the error code for Robocopy
# and use this as extra infromation and email determination.
# NO OTHER CODE BETWEEN THE SWITCH AND THE ROBOCOPY COMMAND


Switch ($LASTEXITCODE)
{

33
	{
		$exit_code = "21"
		$exit_reason = "[***Patial Copy***] Robocopy did not copy all Files.  Files are locked and in use"
		$backupState = "ERROR"
	}
	16
	{
		$exit_code = "16"
		$exit_reason = "[***FATAL ERROR***] Robocopy did not copy any files.  Check the command line parameters and verify that Robocopy has enough rights to write to the destination folder"
		$backupState = "ERROR"
	}
	15
	{
		$exit_code = "15"
		$exit_reason = "[FAILED] OKCOPY + FAIL MISMATCH EXTRA COPY"
		$backupState = "ERROR"
	}
	14
	{
		$exit_code = "14"
		$exit_reason = "[FAILED] FAIL MISMATCH EXTRA"
		$backupState = "ERROR"
	}
	13
	{
		$exit_code = "13"
		$exit_reason = "[FAILED] OKCOPY + FAIL MISMATCH COPY"
		$backupState = "ERROR"
	}
	12
	{
		$exit_code = "12"
		$exit_reason = "[FAILED] FAIL MISMATCH"
		$backupState = "ERROR"
	}
	11
	{
		$exit_code = "11"
		$exit_reason = "[FAILED] OKCOPY + FAIL EXTRA COPY"
		$backupState = "ERROR"
	}
	10
	{
		$exit_code = "10"
		$exit_reason = "[FAILED] FAIL EXTRA"
		$backupState = "ERROR"
	}
	9
	{
		$exit_code = "9"
		$exit_reason = "[FAILED] FAIL COPY"
		$backupState = "ERROR"
	}
	8
	{
		$exit_code = "8"
		$exit_reason = "[FAILED COPIES] Some files or directories could not be copied and the retry limit was exceeded"
		$backupState = "ERROR"
	}
    7
	{
		$exit_code = "7"
		$exit_reason = "Files were copied, a file mismatch was present, and additional files were present."
		$backupState = "ERROR"
	}
    6
    {
		$exit_code = "6"
		$exit_reason = "Additional files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory."
		$IncludeAdmin = $False
		$backupState = "ERROR"
    }
    5
    {
		$exit_code = "5"
		$exit_reason = "Some files were copied. Some files were mismatched. No failure was encountered."
		$IncludeAdmin = $False
		$backupState = "ERROR"
    }
	4
	{
		$exit_code = "4"
		$exit_reason = "MISMATCHED files or directories were detected.  Examine the log file for more information"
		$IncludeAdmin = $False
		$backupState = "ERROR"
	}
    3
    {
		$exit_code = "3"
		$exit_reason = "Some files were copied. Additional files were present. No failure was encountered."
		$IncludeAdmin = $False
		$backupState = "SUCCESSFULL"
    }
	2
	{
		$exit_code = "2"
		$exit_reason = "EXTRA FILES or directories were detected.  Examine the log file for more information"
		$IncludeAdmin = $False
		$backupState = "SUCCESSFULL"
	}
	1
	{
		$exit_code = "1"
		$exit_reason = "One of more files were copied SUCCESSFULLY"
		$IncludeAdmin = $False
		$backupState = "SUCCESSFULL"
	}
	0
	{
		$exit_code = "0"
		$exit_reason = "NO CHANGE occurred and no files were copied"
		$backupState = "SUCCESSFULL"
		$SendEmail = $False
		$IncludeAdmin = $False
	}
	default
	{
		$exit_code = "Unknown ($LASTEXITCODE)"
		$exit_reason = "Unknown Reason"
		$IncludeAdmin = $False
	}
}

$Subject = "[" + $env:username + "] " + "[" + $backupState + "] " + $Subject + ";" + $exit_reason + ";EC: " + $exit_code

# Test log file size to determine if it should be emailed
# or just a status email
If ((Get-ChildItem $Filelog).Length -lt 15mb)
#ammend to if GET $FullSumlog ,$Summarylog
{
If ($IncludeAdmin)
{
If ($AsAttachment)
{
Send-MailMessage -From $Sender -To $Recipients -Cc $Admin -Subject $Subject -Body " $env:username Backup results are attached." -Attachment $FullSumlog ,$Summarylog -DeliveryNotificationOption onFailure -SmtpServer $SMTPServer
} Else {
Send-MailMessage -From $Sender -To $Recipients -Cc $Admin -Subject $Subject -Body (Get-Content $FullSumlog  | Out-String) -DeliveryNotificationOption onFailure -SmtpServer $SMTPServer
                                                                                   
}
} Else {
If ($AsAttachment)
{
Send-MailMessage -From $Sender -To $Recipients -Subject $Subject -Body " Backup results are attached." -Attachment $FullSumlog ,$Summarylog  -DeliveryNotificationOption onFailure -SmtpServer $SMTPServer
} Else {
Send-MailMessage -From $Sender -To $Recipients -Subject $Subject -Body (Get-Content $FullSumlog ,$Summarylog | Out-String) -DeliveryNotificationOption onFailure -SmtpServer $SMTPServer
}
}
} Else {
# Creat the email body from the beginning and end of the $Logfile
$Body = "Logfile was too large to send." + (Get-Content $FullSumlog $Summarylog -TotalCount 15 | Out-String) + (Get-Content $FullSumlog $Summarylog | Out-String)
# Include Admin if log file was too large to email
Send-MailMessage -From $Sender -To $Recipients -Cc $Admin -Subject $Subject -Body $Body -DeliveryNotificationOption onFailure -SmtpServer $SMTPServer
#Exclude Admin if log file was too large to email
#Send-MailMessage -From $Sender -To $Recipients -Subject $Subject -Body $Body -DeliveryNotificationOption onFailure -SmtpServer $SMTPServer
}

##### Combine all  Log files a single Fine
$Logfile = "$destination\$env:username\Log.txt"
#$Logfile1 = "$destination\$env:username\Documents.txt"
#$Logfile2 = "$destination\$env:username\Favorites.txt"
#$Logfile3 = "$destination\$env:username\desktop.txt"
#$Logfile4 = "$destination\$env:username\Downloads.txt"
#$Logfile5 = "$destination\$env:username\cookies.txt"
#$Logfile6 = "$destination\$env:username\Outlook.txt"

#Collect  ROBOCOPY Table Format-Append all folders
<#
Get-Content $Logfile |Select -First 8 | Select -Last 10   |Out-File -filepath "$destination\$env:username\log1.txt" -append
Get-Content $Logfile1|Select -First 8 | Select -Last 10   |Out-File -filepath "$destination\$env:username\log1.txt" -append
Get-Content $Logfile2|Select -First 8 | Select -Last 10   |Out-File -filepath "$destination\$env:username\log1.txt" -append
Get-Content $Logfile3|Select -First 8 | Select -Last 10   |Out-File -filepath "$destination\$env:username\log1.txt" -append
Get-Content $Logfile4|Select -First 8 | Select -Last 10   |Out-File -filepath "$destination\$env:username\log1.txt" -append
#>



# combine Logs to find String base find error pattern#
$Filelog = "$destination\$env:username\log.txt"

#Get-Content $Logfile,$Logfile1,$Logfile2,$Logfile3,$Logfile4,$Logfile6 | Out-File -filepath "$destination\$env:username\log.txt" |Out-String
#Get-Content $Logfile,$Logfile1,$Logfile2,$Logfile3,$Logfile4          | Out-File -filepath "$destination\$env:username\log.txt" |Out-String


$FullSumlog= "$destination\$env:username\Summuray.csv"
 
Select-String "$destination\$env:username\log.txt" -Pattern "ERROR 33", "3 (0x00000003)"  -Context 2, 3 | Format-List -Property  Pattern, Line, LineNumber   | Out-File -filepath "$destination\$env:username\Summuray.csv" |Out-String
#Select-String "$destination\$env:username\log.txt" -Pattern "ERROR 33", "3 (0x00000003)"  -Context 2, 3 | Format-List -Property  Pattern, Line, LineNumber   | Out-File -filepath "$destination\$env:username\Summuray.csv" |Out-String



###############################################################

$Summarylog= "$destination\$env:username\log2.txt"
Get-ChildItem $Logfile  | ForEach-Object {Get-Content $_ -TotalCount 8; Get-Content $_ -Tail 15}   | Out-File -filepath "$destination\$env:username\log2.txt" 
#Get-ChildItem $Logfile1 | ForEach-Object {Get-Content $_ -TotalCount 7; Get-Content $_ -Tail 12}  | Out-File -filepath "$destination\$env:username\log2.txt" -append
#Get-ChildItem $Logfile2 | ForEach-Object {Get-Content $_ -TotalCount 7; Get-Content $_ -Tail 12}  | Out-File -filepath "$destination\$env:username\log2.txt" -append
#Get-ChildItem $Logfile3 | ForEach-Object {Get-Content $_ -TotalCount 7; Get-Content $_ -Tail 12}  | Out-File -filepath "$destination\$env:username\log2.txt" -append
#Get-ChildItem $Logfile6 | ForEach-Object {Get-Content $_ -TotalCount 7; Get-Content $_ -Tail 12}  | Out-File -filepath "$destination\$env:username\log2.txt" -append


# combine Logs to Display  table formats#





#Email
##################################################################

$Subject = "Backup Results: BackUp  Job- Local To Remote"
$SMTPServer = "mail SMTP Server"
$Sender = "Enter Email Address"
$Recipients = "Enter Recipient"
$Admin = " "
$SendEmail = $True
$IncludeAdmin = $False
$AsAttachment = $True


############################################################




<#
######### Treat lOG FILE- Summary based#################
Get-Content $Logfile | Out-File -filepath "$destination\$env:username\Pictures_LOG.txt" |Out-String
Get-Content $Logfile1 | Out-File -filepath "$destination\$env:username\Documents_LOG.txt" |Out-String
Get-Content $Logfile2 | Out-File -filepath "$destination\$env:username\Favorites_LOG.txt" |Out-String
Get-Content $Logfile3 | Out-File -filepath "$destination\$env:username\desktop_LOG.txt" |Out-String
Get-Content $Logfile4 | Out-File -filepath "$destination\$env:username\Downloads_LOG.txt" |Out-String
Get-Content $Logfile5 | Out-File -filepath "$destination\$env:username\cookies_LOG.txt" |Out-String
Get-Content $Logfile6 | Out-File -filepath "$destination\$env:username\AppData\Local\Microsoft\Outlook.txt" |Out-String
#>



 
function Select-RoboSummary {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string]$log,
        [parameter(Mandatory=$false,ValueFromPipeline=$false)]
        [switch]$separateUnits
    )
    PROCESS
    {
       

        $cellHeaders = @( "Total","Copied", "Skipped", "Mismatch", "Failed", "Extras")

        $rowTypes    = @("Dirs", "Files", "Bytes")

        # Extract rows

        $rows = $log | Select-String -Pattern "(Dirs|Files|Bytes)\s*:(\s*([0-9]+(\.[0-9]+)?( [a-zA-Z]+)?)+)+" -AllMatches
        if ($rows.Count -eq 0)
        {
            throw "Summary table not found"
        }

        if ($rows.Matches.Count -ne $rowTypes.Count)
        {
            throw "Unexpected number of rows/ Expected {0}, found {1}" -f $rowTypes.Count, $rowsMatch.Count
        }

        # Merge each row with its corresponding row type, with property names of the cell headers
        for($x = 0; $x -lt $rows.Matches.Count; $x++)
        {
            $rowType  = $rowTypes[$x]
            $rowCells = $rows.Matches[$x].Groups[2].Captures | foreach{ $_.ToString().Trim() }

            if ($cellHeaders.Length -ne $rowCells.Count)
            {
                throw "Unexpected amount of cells in a row. Expected {0} cells (the amount of headers) but found {1}" -f $cellHeaders.Length,$rowCells.Count
            }

            $row = New-Object -TypeName PSObject
            $row | Add-Member -Type NoteProperty Type($rowType)

            for($i = 0; $i -lt $rowCells.Count; $i++)
            {
                $header = $cellHeaders[$i]
                $cell   = $rowCells[$i]

                if ($separateUnits -and ($cell -match " "))
                {
                    $cell = $cell -split " "
                }

                $row | Add-Member -Type NoteProperty -Name $header -Value $cell
            }

            $row
        }
    }
}
<#remember to treat each log File seperate.

#DESKTOP
Get-Content $Logfile3 -Raw | Select-RoboSummary | Sort-Object Type | Format-Table |Out-File -filepath "$destination\$env:username\Desk_Summary_Log.txt" |Out-String
Get-Content $Logfile3 -Raw | Select-RoboSummary | Where{ $_.Failed -gt 0 } |Out-File -filepath "$destination\$env:username\Error_Desk_Log.txt" |Out-String
#Select-String -Path "D:\CODs\Andrew.Kasaija\Documents.txt" -Pattern "ERROR 33" -Context 2, 3 | Format-List -Property * LineNumber, Line, Pattern  | Out-File -filepath "D:\CODs\Andrew.Kasaija\123.csv" |Out-String

#PICTURES
Get-Content $Logfile -Raw | Select-RoboSummary | Sort-Object Type | Format-Table |Out-File -filepath "$destination\$env:username\P_Summary_Log.txt" |Out-String
Get-Content $Logfile -Raw | Select-RoboSummary | Where{ $_.Failed -gt 0 } |Out-File -filepath "$destination\$env:username\Error_P_Log.txt" |Out-String

#FAVOURITES 
Get-Content $Logfile2 -Raw | Select-RoboSummary | Sort-Object Type | Format-Table |Out-File -filepath "$destination\$env:username\F_Summary_Log.txt" |Out-String
Get-Content $Logfile2 -Raw | Select-RoboSummary | Where{ $_.Failed -gt 0 } |Out-File -filepath "$destination\$env:username\Error_F_Log.txt" |Out-String

#DOWNLOADS
Get-Content $Logfile2 -Raw | Select-RoboSummary | Sort-Object Type | Format-Table |Out-File -filepath "$destination\$env:username\D_Summary_Log.txt" |Out-String
Get-Content $Logfile2 -Raw | Select-RoboSummary | Where{ $_.Failed -gt 0 } |Out-File -filepath "$destination\$env:username\Error_D_Log.txt" |Out-String

#Documents


Get-Content $Logfile1 -Raw | Select-RoboSummary | Sort-Object Type | Format-Table |Out-File -filepath "$destination\$env:username\Documents_Summary_Log.txt" |Out-String

Get-Content $Logfile1 -Raw | Select-RoboSummary | Where{ $_.Failed -gt 0 }    |Out-File -filepath "$destination\$env:username\Error_Documents_Log.txt" |Out-String
#>





 #$FullSumlog = "$destination\$env:username\Error_D_Log.txt", "$destination\$env:username\Error_F_Log.txt", "$destination\$env:username\Error_P_Log.txt" ,"$destination\$env:username\Error_Desk_Log.txt","$destination\$env:username\Error_Documents_Log.txt"

 #Get-Content  $Filelog -Raw  | Select-RoboSummary | Where{ $_.Failed -gt 0 } -Pattern "ERROR 33" -Context 2, 3 | Format-List -Property  LineNumber, Line, Pattern  | Out-File -filepath "$destination\$env:username\Summary_Error_Log.txt" |Out-String
 
 
 
 
 
 
 #Get-ChildItem -Path "$destination\$env:username\Documents_Summary_Log.txt" -Recurse | Get-Content -Wait | Select-String "ERROR" 
 #gci "$destination\$env:username\Documents_Summary_Log.txt" -rec | gc -Wai | Select-String "warning|error"

 #Get-ChildItem -Path "$destination\$env:username\Documents_Summary_Log.txt" -Recurse | Get-Content -Wait | Select-String "/(?:\w+)|(?:(?:ERROR\:\ RETRY\ LIMIT\ EXCEEDED))/" |Out-File -filepath "$destination\$env:username\1Log.txt" |Out-String


 #Get-Content $Logfile,$Logfile2,$Logfile4 | Out-File -filepath "$destination\$env:username\log.txt" |Out-String
#$Logfile5,
#$Logfile6


####Log Based Filtering #####





