set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

New-LocalGroup teachers
New-LocalUser Jim -Password "Jim2017a2sd"
Add-LocalGroupMember -Group teachers,Administrators -Member Jim

New-LocalGroup students

$list=$srt/"students.txt"

if (!(Test-Path -Path $list )){
    Write-Host "Error couldn't find student List"
    $z = Read-Host -Prompt "Press Any Key to Continue" 
    Exit
}

Get-Content $list
foreach ($s in $list){
  
    New-LocalUser $s -Password “Password123”


}