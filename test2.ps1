function Enter-O365Session{
    param(
        [Parameter(Mandatory=$false)]
        [ValidatePattern("\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b")]
        [String]$User,
        [Parameter(Mandatory=$false)]
        [Security.SecureString]$Password
    )
    $ErrorActionPreference = "Stop"
    if($User -contains $null){
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
    if($Password -contains $null){
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