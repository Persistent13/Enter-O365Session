WHO:
	Dakota Clark <dclark@team-sos.com>
WHAT:
	Single command to connect to Office 365 via PowerShell.
HOW:
	Using the Enter-PSSession and tip from the Oulook.com
	website from PS session management.
	http://help.outlook.com/en-us/140/cc952755.aspx
ACTIONS:
	The script requests a username in the format of
	user@example.com and then connects to the O365 cloud
	if the credentials given are correct. It will print the
	system error if the connection was a failure.
REQUIREMENTS:
	Powershell v2
	Office 365 account
