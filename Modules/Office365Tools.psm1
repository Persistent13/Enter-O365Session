function Enter-Office365Session{
<#
    .SYNOPSIS
    Connects you to the Office 365 cloud.
    .DESCRIPTION
    Connects you to the Office 365 cloud via a PSSession for
    indepth hosted Exchange administration. Can accept credentials
    via parameters but this is not recommened.
    .EXAMPLE
    Enter-Office365Session

    Enter the command with out parameters and you'll be prompted for credentials in a secure manner.


    C:\PS>Enter-Office365Session


    Please enter the username. "foo@example.com": jsmith@contoso.net
    Please enter the password: *******
    .EXAMPLE
    Enter-Office365Session -User jsmith@contoso.net -Passowrd thebest

    C:\PS>Enter-Office365Session -User jsmith@contoso.net
    Please enter the password: *******


    C:\PS>Enter-Office365Session -Passowrd thebest
    Please enter the username. "foo@example.com": jsmith@contoso.net

    !WARNING! This entry style is not secure and has only been
    introduced for the use of a script that needs an automted 
    connection to the Office 365 cloud. Use only if you undestand
    the impact of this method!

    Enter the command with either the User and Password parameters
    or enter a single parammeter to pass all or a portion of your
    credentials. The script will prompt as normal for any missing
    information.
    .PARAMETER User
    The username to use when connecting to the cloud.
    .PARAMETER Password
    !WARNING! This parameter is not secure and when passed your
    password will be held in plain text for a duration in memory.
    It is recommened to not use this parameter unless the impact
    id this method is fully understude.

    The password to use when connecting to the cloud.
#>
    param(
        [Parameter(Mandatory=$false)]
        [ValidatePattern("\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b")]
        $User,
        [Parameter(Mandatory=$false)]
        $Password
    )
    $ErrorActionPreference = "Stop"
    if(!$User){
        do{
            try{
                $secureStringOk = $true
                $User = Read-Host 'Please enter the username. "foo@example.com"'
            }
            catch{
                $secureStringOk = $false
            }
        }
        until(($User -match "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b") -and $secureStringOk)
    }
    if($Password.Length -gt 0){
        $Password = $Password | ConvertTo-SecureString -AsPlainText -Force
    }
    if(!$Password){
        $Password = Read-Host -AsSecureString "Please enter the password"
    }
    $liveCredential = New-Object -Typename System.Management.Automation.PSCredential -ArgumentList $User,$Password
    try{
        $liveSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $liveCredential -Authentication Basic -AllowRedirection
        Import-PSSession -AllowClobber $liveSession
        Write-Host "
        "
        Write-Output "Exit with command Remove-PSSession $((Get-PSSession).Id)"

    }
    catch [Exception]{
        Write-Output "$($_.Exception.Message)"
    }
}