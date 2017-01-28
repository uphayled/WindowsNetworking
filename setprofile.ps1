set-strictmode -version 2.0

#file stored on git
$gitprofile="gitprofile.ps1"

#make sure we have profile from git
if (!(Test-Path -Path $gitprofile)){
    Write-host "Couldnt find Source Profile"
    exit
}

#create profile if it does not exist
if (!(Test-Path -Path $PROFILE )){
    New-Item -Type File -Path $PROFILE -Force 
}



##Get-Content -path $PSScriptRoot\$gitprofile | Add-Content -filepath $PROFILE
$a=(Get-Content -path $PSScriptRoot\$gitprofile) ; Add-Content $PROFILE $a


#echo (Get-Content -path $PSScriptRoot\$gitprofile)
echo (dir $PSScriptRoot)

