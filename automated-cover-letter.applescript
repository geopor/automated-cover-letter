-- 1. Change this to your name
set myName to "My Name"
-- 2. Change this to the body text of your cover letter (i.e. your work experience & skills that make you suited for the job)
set bodyText to "Some of my work experience and skills ..." & linefeed & linefeed

-- Popup a dialog box to retrieve Company and Job Title
set a to text returned of (display dialog "Please enter 1) Company & 2) Job Title, separating them with a comma:" default answer "")
set astid to AppleScript's text item delimiters
set AppleScript's text item delimiters to ","
set {jobCompany, jobTitle} to {(a's text item 1), (a's text item 2)}
-- check for space in front of jobTitle and remove if found
if (jobTitle begins with space) then
	set jobTitle to text 2 thru -1 of jobTitle
end if
-- reset AppleScript's text delimiters
set AppleScript's text item delimiters to astid

set today to current date
set printDate to today's month & " " & today's day & ", " & today's year & linefeed & linefeed as string
set dearText to "Dear HR Manager," & linefeed & linefeed
set introText to "I would like to express my interest in the " & jobTitle & " position at " & jobCompany & "." & linefeed & linefeed
set closingText to "I would appreciate an opportunity to discuss the role and what I could bring to " & jobCompany & " as a " & jobTitle & "." & linefeed & linefeed & "Yours Sincerely," & linefeed & linefeed & myName

set defaultText to printDate & dearText & introText & bodyText & closingText

-- This popup text is editable to add any custom text to your cover letter to better suit a particular job
set enteredText to (display dialog "What is your text?" default answer defaultText with title "Enter Cover Letter")
set enteredText to text returned of enteredText
property exportFileExtension : "pdf"
-- THE DESTINATION FOLDER. I use the Mac's Desktop folder but you can change this to documents or pictures etc.
set the defaultDestinationFolder to (path to desktop folder)
-- DERIVE NAME AND FILE PATH FOR NEW EXPORT FILE
-- Replace space with hyphen. This creates a cover letter filename that includes your actual name and doesn't have any spaces
set myHyphenName to do shell script "echo " & quoted form of myName & " | tr \" \" \"_\""
set documentName to "Cover_Letter-" & jobCompany & "-" & myHyphenName 
tell application "Finder"
	set exportItemFileName to documentName & "." & exportFileExtension
end tell
-- DERIVE NAME AND FILE PATH FOR NEW EXPORT FILE
set documentName to "Cover_Letter-" & jobCompany & "-GeorgeP"
set the targetFileHFSPath to (defaultDestinationFolder as string) & exportItemFileName
tell application "Pages" --telling Pages to create a new document, as opposed to "active document"
	activate
	make new document
	delay 1
	tell the front document
		tell the body text
			set first paragraph to enteredText
		end tell
	end tell
	-- EXPORT THE DOCUMENT
	export front document to file targetFileHFSPath as PDF
end tell
-- SHOW THE NEW PDF FILE
tell application "Finder"
	activate
	reveal document file targetFileHFSPath
end tell
