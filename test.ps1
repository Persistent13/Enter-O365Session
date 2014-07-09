function Enter-O365Session{
    $ErrorActionPreference = "Stop"
    if(($liveUser -contains $null) -and $liveCredential -notmatch "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b"){
        do{
            try{
                $strOk = $true
                $liveUser = Read-Host 'Please enter the username "foo@example.com"'
            }
            catch{
                $strOk = $false
            }
        }
    until(($liveUser -match "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b") -and $strOk)
    }
    $livePassword = Read-Host -AsSecureString "Please enter the password"
    $liveCredential = New-Object -Typename System.Management.Automation.PSCredential -ArgumentList $liveUser,$livePassword
    try{
        $liveSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $liveCredential -Authentication Basic -AllowRedirection
        Import-PSSession $liveSession
        Write-Host "
        "
        Write-Output "Exit with command Remove-PSSession $((Get-PSSession).Id)"

    }
    catch [Exception]{
        Write-Output -ErrorAction "$($_.Exception.Message)"
    }
}