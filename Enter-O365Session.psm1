function Enter-O365Session{
param(
    [Parameter(Mandatory=$false)]
    [Alias("u")]
    [String]$liveUser,
    [Parameter(Mandatory=$false)]
    [Alias("p")]
    [Security.SecureString]$livePassword
)
$ErrorActionPreference = "Stop"
        if(($liveUser -contains $null) -and $liveCredential -notmatch "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b"){
            do{
                try{
                    $secureStringOk = $true
                    $liveUser = Read-Host 'Please enter the username. "foo@example.com"'
                }
                catch{
                    $secureStringOk = $false
                }
            }
            until(($liveCredential -match "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b") -and $secureStringOk)
        }
        if($livePassword -contains $null){
            $livePassword = Read-Host -AsSecureString "Please enter the password."
        }
    try{
        $liveSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $liveCredential -Authentication Basic -AllowRedirection
        Import-PSSession $liveSession
        Write-Output " "
        Write-Output "Connected!" -ForegroundColor Green
        Write-Output "Type the command"
        Write-Output "    Remove-PSSession $((Get-PSSession).Id)" -ForegroundColor Yellow
        Write-Output "to exit the session."
    }
    catch [Exception]{
        Write-Output "$($_.Exception.Message) Be sure you entered your credentials correctly." -ForegroundColor Red
    }
}