On Error Resume Next 
Set objSysInfo = CreateObject("ADSystemInfo") 
 
' ########### This section connects to Active Directory as the currently logged on user 
 strUser = objSysInfo.UserName
 
Set objUser = GetObject("LDAP://" & strUser)  
 
' ########### This section sets up the variables we want to call in the script (items on the left; whereas the items on the right are the active directory database field names) - ie strVariablename = objuser.ad.databasename 
 
strGiven = objuser.givenName 
strSurname = objuser.sn  
strFax = objuser.facsimileTelephoneNumber
strTitle = objUser.Title
strDepartment = objUser.Department
strCompany = objUser.Company
strPhone = objUser.telephoneNumber 
strMobile = objUser.mobile
strEmail =objuser.mail 
strWeb = objuser.wWWHomePage 
strNotes = objuser.info 
strExt = objuser.ipPhone 
strDDI = objuser.homephone 
strEmailTEXT = "Email: " 
strAddress = objuser.streetAddress
strCity = objUser.physicalDeliveryOfficeName
strCountry = objuser.co

 
' ########### Sets up word template
' ########### Sets up Word Templete for new Emails
 '

 
Set objWord = CreateObject("Word.Application") 
Set objDoc = objWord.Documents.Add() 
Set objSelection = objWord.Selection 
 
objSelection.Style = "No Spacing" 
Set objEmailOptions = objWord.EmailOptions 
Set objSignatureObject = objEmailOptions.EmailSignature 
Set objSignatureEntries = objSignatureObject.EmailSignatureEntries 
 
' ########### Calls the variables from above section and inserts into word template, also sets initial font typeface, colour etc. 
objSelection.ParagraphFormat.Alignment = AlignParagraphLeft
objSelection.Font.Name = "Arial" 
objSelection.Font.Size = 10 
objselection.Font.Bold = false 
objSelection.Font.Color = RGB (0,0,0)
 
objSelection.TypeParagraph() 
objSelection.TypeParagraph()
objSelection.TypeText strGiven & " " & strSurname
objSelection.TypeParagraph()  
objSelection.TypeText strTitle
objSelection.TypeParagraph()
objSelection.TypeParagraph()
objSelection.TypeText strCompany
objSelection.TypeParagraph()
objSelection.TypeText strAddress
objSelection.TypeParagraph()
objSelection.TypeText strCity & " - " &  strCountry
objSelection.TypeParagraph()
objSelection.TypeParagraph()
objSelection.TypeText "Phone:" & "  " &  strPhone
objSelection.TypeParagraph()
objSelection.TypeText "Direct:" & " " & strExt
objSelection.TypeParagraph()
objSelection.TypeText "Mobile:" & " " & strMobile
objSelection.TypeParagraph()
objSelection.TypeText "Fax:" & "    " & strFax
objSelection.TypeParagraph()

objselection.TypeText
Set objLink = objSelection.Hyperlinks.Add(objSelection.Range, "mailto: " & strEmail, , , strEmail) 
  objLink.Range.Font.Name = "Arial" 
  objLink.Range.Font.Size = 10 
  objLink.Range.Font.Bold = false
 
objSelection.TypeParagraph()
objSelection.TypeParagraph()

objSelection.TypeText 
Set objLink = objSelection.Hyperlinks.Add(objSelection.Range, "Company Website") 
  objLink.Range.Font.Name = "Arial" 
  objLink.Range.Font.Size = 10 
  objLink.Range.Font.Bold = false 
  objSelection.TypeParagraph()


 
Set objLink = objSelection.Hyperlinks.Add(objSelection.InlineShapes.AddPicture("\\siglogo.jpg"))
 objSelection.TypeParagraph() 
objSelection.TypeText "Enter Disclaimer."

objSelection.TypeParagraph() 
Set objLink = objSelection.Hyperlinks.Add(objSelection.InlineShapes.AddPicture("\\siglogo.jpg"))
 

' ########### Tells outlook to use this signature for new messages. Signature is called Email Signature. 
 
Set objSelection = objDoc.Range() 
objSignatureEntries.Add "AD_Signature_New", objSelection
objSignatureObject.NewMessageSignature = "AD_Signature_New"
objDoc.Saved = True
' ############ New Line Block Code 
' ########### Sets up word template 
' ########### Sets up Word Templete for reply Emails


Set objDoc = objWord.Documents.Add() 
Set objSelection = objWord.Selection 
 
objSelection.Style = "No Spacing" 
Set objEmailOptions = objWord.EmailOptions 
Set objSignatureObject = objEmailOptions.EmailSignature 
Set objSignatureEntries = objSignatureObject.EmailSignatureEntries 
 
' ########### Calls the variables from above section and inserts into word template, also sets initial font typeface, colour etc. 
objSelection.ParagraphFormat.Alignment = AlignParagraphLeft
objSelection.Font.Name = "Arial" 
objSelection.Font.Size = 10 
objselection.Font.Bold = false 
objSelection.Font.Color = RGB (0,0,0)
 
objSelection.TypeParagraph() 
objSelection.TypeParagraph()
objSelection.TypeText strGiven & " " & strSurname
 
' ########### Tells outlook to use this signature for replys. Signature is called Email Signature. 
 
Set objSelection = objDoc.Range() 
objSignatureEntries.Add "AD_Signature_Reply", objSelection
objSignatureObject.ReplyMessageSignature = "AD_Signature_Reply"
objDoc.Saved = True
  
 'Second Signature With AEO
Set objDoc = objWord.Documents.Add() 
Set objSelection = objWord.Selection 
 
objSelection.Style = "No Spacing" 
Set objEmailOptions = objWord.EmailOptions 
Set objSignatureObject = objEmailOptions.EmailSignature 
Set objSignatureEntries = objSignatureObject.EmailSignatureEntries 
 
' ########### Calls the variables from above section and inserts into word template, also sets initial font typeface, colour etc. 
objSelection.ParagraphFormat.Alignment = AlignParagraphLeft
objSelection.Font.Name = "Arial" 
objSelection.Font.Size = 10 
objselection.Font.Bold = false 
objSelection.Font.Color = RGB (0,0,0)
 
objSelection.TypeParagraph() 
objSelection.TypeParagraph()
objSelection.TypeText strGiven & " " & strSurname
objSelection.TypeParagraph()  
objSelection.TypeText strTitle
objSelection.TypeParagraph()
objSelection.TypeParagraph()
objSelection.TypeText strCompany
objSelection.TypeParagraph()
objSelection.TypeText strAddress
objSelection.TypeParagraph()
'Create Tables
Set objRange = objSelection.Range '-Start table at this point, ignoring all coding above
objDoc.Tables.Add objRange, 2, 2
Set objTable = objDoc.Tables(1)

'** Logo table-Right Column **
'Set objTable = objDoc.Tables(1)
objTable.Columns(2).Width = objWord.CentimetersToPoints(8.00)
'objTable.Cell(1, 1).select
 '"Insert Logo here"    ' Put Logo information here
objTable.Cell(1, 2).Range.InlineShapes.AddPicture("Enter image path")


'** User table **
objTable.Columns(1).Width = objWord.CentimetersToPoints(8.00)
objTable.Cell(1, 1).select
'Put User information here Left column
objSelection.ParagraphFormat.Alignment = AlignParagraphLeft
objSelection.TypeText strCity & " - " &  strCountry 
objSelection.TypeParagraph()
objSelection.TypeParagraph()
objSelection.TypeText "Phone:" & "  " &  strPhone
objSelection.TypeParagraph()
objSelection.TypeText "Direct:" & " " & strExt
objSelection.TypeParagraph()
objSelection.TypeText "Mobile:" & " " & strMobile
objSelection.TypeParagraph()
objSelection.TypeText "Fax:" & "    " & strFax

objSelection.EndKey 6  'Command to end the above tables
'Closing of Table format
objselection.TypeText
Set objLink = objSelection.Hyperlinks.Add(objSelection.Range, "mailto: " & strEmail, , , strEmail) 
  objLink.Range.Font.Name = "Arial" 
  objLink.Range.Font.Size = 10 
  objLink.Range.Font.Bold = false
 
objSelection.TypeParagraph()
objSelection.TypeParagraph()

objSelection.TypeText 
Set objLink = objSelection.Hyperlinks.Add(objSelection.Range, "www.spedaginterfreight.com") 
  objLink.Range.Font.Name = "Arial" 
  objLink.Range.Font.Size = 10 
  objLink.Range.Font.Bold = false 
  objSelection.TypeParagraph()


 
Set objLink = objSelection.Hyperlinks.Add(objSelection.InlineShapes.AddPicture("\\siglogo.jpg"))
 objSelection.TypeParagraph() 
objSelection.TypeText "Enter Disclaimer."

objSelection.TypeParagraph() 
Set objLink = objSelection.Hyperlinks.Add(objSelection.InlineShapes.AddPicture("\\siglogo.jpg"))
 

' ########### Tells outlook to use this signature for new messages. Signature is called Email Signature. 
 
Set objSelection = objDoc.Range() 
objSignatureEntries.Add "AEO_Signature", objSelection
objSignatureObject.NewMessageSignature = ""

' ############ New Line Block Code 
' ########### Sets up word template 
' ########### Sets up Word Templete for reply Emails

 
objDoc.Saved = True 
 
objWord.Quit

