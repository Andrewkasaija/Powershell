$computers = 'Enter Computer Name'
$sourcefile = "Source file for the MSI"

$jobscript = {
	Param($computer)
	$destinationFolder = "\\$computer\C$\Temp"

	if (!(Test-Path -path $destinationFolder))
 {
		New-Item $destinationFolder -Type Directory
	}
	Copy-Item -Path $sourcefile -Destination $destinationFolder
	Invoke-Command -ComputerName $computer -ScriptBlock { Msiexec Enter location path of MSI FILE /i  /log C:\MSIInstall.log }
}

$computer | 
	ForEach-Object{
		Start-Job -ScriptBlock $jobscript -ArgumentList $_ -Credential $domaincredentail
	}
