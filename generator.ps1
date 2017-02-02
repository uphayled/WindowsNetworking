Param(
    #do it with powershell
    [bool]$p = $false
)

set-strictmode -version 2.0
 
#root of where script is being run
$srt = $PSScriptRoot

if($p){
    ###
    #  With PowerShell Cmd-let
    ###
    New-LocalGroup teachers
    $Password = ConvertTo-SecureString -String "Jim2017WN" -asplaintext -force
    New-LocalUser Jim -Password $Password
    Add-LocalGroupMember -Group teachers,Administrators -Member Jim
    New-LocalGroup students
}
else{
    ###
    #  With cmd commands
    ###
    cmd /c $("net user /add Jim Jim2017WN")
    cmd /c $("net localgroup administrators Jim /add")
    cmd /c $("net localgroup students /add")
}

$list=$srt/"students.txt"

if (!(Test-Path -Path $list )){
    Write-Host "Error couldn't find student List"
    $z = Read-Host -Prompt "Press Any Key to Continue" 
    Exit
}
 
Get-Content $list
foreach ($s in $list){
    if($p){
        ###
        #  With PowerShell Cmd-let
        ###
        $student_password = ConvertTo-SecureString -String "Password123"  -asplaintext -force
        New-LocalUser $s -Password $student_password
    }
    else{
        ###
        #  With cmd commands
        ###
        cmd /c $("net user /add $s Password123")
        cmd /c $("net accounts /minpwage:0")
    }

}