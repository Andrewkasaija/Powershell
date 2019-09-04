
' AUTHOR: Andrew
' DATE Modified   : 24/05/2012
' COMMENT: This script will backup user profile files/folders to specified location 


On Error Resume Next

Dim fso 
Dim oFolder1, objFolder, oFolder
Dim path
Dim WSHShell
Dim colFolders
Dim sDocsAndSettings 
Dim strComputer
Dim strDirectory

strComputer = "."

Set WSHShell = CreateObject("WScript.Shell")
Set fso = createobject("Scripting.FileSystemObject")

'===========================================================
'CHANGE SDESTINATION FOLDER PATH HERE
sPath =  "Enter path to destination"
'===========================================================
Set proFolder = fso.GetFolder(sPath)

'COPY FILES FROM USER PROFILES
sDocsAndSettings = "C:\Users\"   
Set colFolders = fso.GetFolder(sDocsAndSettings) 

For Each oFolder In colFolders.SubFolders
	Select Case LCase(oFolder.Name)
		Case "admin", "administrator", "newuser", "all users", "default user", "default user.original", "localservice", "networkservice"
			'LEAVE THE DEFAULT PROFILES ON THE MACHINE
		Case Else
			'MsgBox oFolder.Name			
			If fso.FolderExists(proFolder) Then
				strDirectory = proFolder & "\" & oFolder.Name 
				If fso.FolderExists(strDirectory) Then
				Else 
					Set objFolder = fso.CreateFolder(strDirectory)
				End If
				MsgBox "Backing up " & oFolder.Name & " profile data"
				'COPY USER PROFILE FOLDERS to "D:\Backp Profiles"
				fso.CopyFolder sDocsAndSettings & oFolder.Name & "\Favorites" , objFolder & "\", True
				
				fso.CopyFolder sDocsAndSettings & oFolder.Name & "\Desktop" , objFolder & "\", True
			End If
	End Select 
Next

MsgBox "Backup has been completed successfully!"

Set fso = Nothing
Set WSHShell = Nothing