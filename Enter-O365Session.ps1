$ErrorActionPreference = "Stop"
do{
    try{
        $strOk = $true
        $LiveCred = Read-Host 'Please enter the username "user@example.com".'
    }
    catch{
        $strOk = $false
    }
}
until(($LiveCred -match "\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b") -and $strOk)
try{
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell/ -Credential $LiveCred -Authentication Basic -AllowRedirection
    Import-PSSession $Session
}
catch [Exception]{
    Write-Host "$($_.Exception.Message) Be sure you entered your credentials correctly." -ForegroundColor Red
}
