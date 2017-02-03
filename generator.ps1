Param(
    #do it with powershell
    [bool]$removeuser = $false
)
set-strictmode -version 2.0
 
#root of where script is being run
$srt = $PSScriptRoot

net user Jim Jim2017WN /add >$null 2>&1
net localgroup administrators Jim /add >$null 2>&1
net localgroup students /add >$null 2>&1

$stu="$srt\students.txt"

if (!(Test-Path -Path $stu )){
    Write-Host "Error couldn't find student List"
    $z = Read-Host -Prompt "Press Any Key to Continue" 
    Exit
}
 
#Get-Content $stu
$countdel = 0
$countold = 0
$counter = 0
foreach ($s in $(Get-Content $stu)){

         

        if($removeuser){
            
            net localgroup students "$s" /delete >$null 2>&1
            net user "$s"  /delete >$null 2>&1
            $countdel++
            Write-Host "Deleting user :$countdel : $s"
        }
        else {
            $check = net user $s  2>&1 | Out-String
            if($check.Contains("User name")){            
                $countold++
                Write-Host "$countold : $s : Error Account already exists"
            }
            else{
                net user "$s" Password123 /add  >$null 2>&1
                net localgroup students "$s" /add  >$null 2>&1
                $counter++
                Write-Host "$counter : $s : Account created"
            }
        }
}
Write-Host "----------------------------------"
Write-Host "$counter :Accounts created"
Write-Host "$countdel :Accounts Deleted"
Write-Host "$countold :Account already existed"
net accounts /minpwage:0 >$null 2>&1