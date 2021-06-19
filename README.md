# automated-cover-letter
Generates a cover letter using Applescript (Mac) after prompting for &lt;Company> &amp; &lt;Job Title>. 

The job application process proceeds rather smoothly on sites like Glassdoor or Lever.co. One-click will autofill your details from LinkedIn, and you can attach your standard resume without any further customizations. The one issue I found slowing me down was including a cover letter for the position. Not only did this have to be customized, but a separate file had to be created for it and exported to PDF before it could be uploaded. This proved to be both time-wasting and energy-sapping when sending out 10+ applications a day. The automated-cover-letter.applescript is an attempt to elegantly speed through this issue using AppleScript on the Mac. Upon execution, it will:
1) Prompt for the name of the company and the job title. 
2) Generate a preliminary cover letter in a popup and allow you to edit it further.
3) Generate the PDF export of the cover letter.
4) Open the Finder where the cover letter is saved to allow you to quickly select it for upload.

## Explanation of the Script
The top section of the script contains two variables to edit, your name & the custom body of your cover letter.
```applescript
-- 1. Change this to your name
set myName to "My Name" as string
-- 2. Change this to the body text of your cover letter (i.e. your work experience & skills that make you suited for the job)
set bodyText to "Some of my work experience and skills ... "
```
The next two variables the script needs will be retrieved via a popup dialog when you run the script. Here is the part of the AppleScript requesting these two variables:

```applescript
-- Popup a dialog box to retrieve Company and Job Title
set a to text returned of (display dialog "Please enter 1) Company & 2) Job Title, separating them with a comma:" default answer "")
```
<p align="center">
  <img src="https://github.com/geopor/automated-cover-letter/blob/main/enter-company-and-job.png">
</p>

I was sometimes adding a space after the comma which messed up the formatting of the final cover letter so I added a check to remove the leading space on the 2nd variable entered (Job Title) just in case:
```applescript
-- check for space in front of jobTitle and remove if found
if (jobTitle begins with space) then
	set jobTitle to text 2 thru -1 of jobTitle
end if
```
The intent of the script is to produce a quick cover letter but what if you wanted to add a few things to make it more targeted towards the role you're applying for? The script actually has a pre-flight dialog to let you look over the generated cover letter. The dialog box is editable so you can make any necessary tweaks before exporting to PDF:

<p align="center">
  <img src="https://github.com/geopor/automated-cover-letter/blob/main/enter-cover-letter.png">
</p>

The resulting PDF export is done through Pages, a free word processing app that comes with most Macs. The filename is constructed to not include any spaces and to also append both the company name and your name to the end of it:

```applescript
set myHyphenName to do shell script "echo " & quoted form of myName & " | tr \" \" \"_\""
set documentName to "Cover_Letter-" & jobCompany & "-" & myHyphenName
```

## How to Launch the Script
You can save a compiled version (.scpt) of the script to your Scripts folder and it will be available in your Script Editor menu bar from any application once you've enabled that menu option. You can also leave a version of the script up in the Script Editor app and run it whenever necessary.

I recommend assigning a keyboard shortcut to the script with Keyboard Maestro ($) and firing it by pushing a hardware button on something like El Gato's Stream Deck ($). Both these tools are well worth the cost if you have any interest in automating your Mac and accessing your various automations using a visual hardware grid like the Stream Deck.
