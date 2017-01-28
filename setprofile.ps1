set-strictmode -version 2.0

$gitprofile="gitprofile.ps1"

if (Test-Path -Path $gitprofile){
    Write-host "hehe"
    exit
}


if (!(Test-Path -Path $PROFILE )){
    New-Item -Type File -Path $PROFILE -Force 
}



Get-Content -path $PSScriptRoot\$gitprofile | Out-File -filepath $PROFILE
echo (Get-Content -path $PSScriptRoot\$gitprofile)

