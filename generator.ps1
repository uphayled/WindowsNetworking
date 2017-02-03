Param(
    #do it with powershell
    [bool]$p = $false
)
set-strictmode -version 2.0
 
#root of where script is being run
$srt = $PSScriptRoot

if($p){
    New-LocalGroup teachers
    $Password = ConvertTo-SecureString -String "Jim2017WN" -asplaintext -force  
    New-LocalUser Jim -Password $Password
    Add-LocalGroupMember -Group teachers,Administrators -Member Jim
    New-LocalGroup students
}
else{
    net user Jim Jim2017WN /add
    net localgroup administrators Jim /add
    net localgroup students /add
}
$stu="$srt\students.txt"

if (!(Test-Path -Path $stu )){
    Write-Host "Error couldn't find student List"
    $z = Read-Host -Prompt "Press Any Key to Continue" 
    Exit
}
 
#Get-Content $stu
foreach ($s in $(Get-Content $stu)){
    echo $s
    if($p){
        $student_password = ConvertTo-SecureString -String "Password123"  -asplaintext -force
        New-LocalUser $s -Password $student_password
    }
    else{
        net user "$s" Password123 /add
        net localgroup students "$s" /add
        net accounts /minpwage:0
    }

}