Param(
    [bool]$removeuser = $false
)
set-strictmode -version 2.0
 
#root of where script is being run
$srt = $PSScriptRoot

$check = net user Jim  2>&1 | Out-String

if($check.Contains("User name")){    
      Write-Host "OUr boiii jim already exists"
}
else{
    net user Jim Jim2017WN /add >$null 2>&1
    net localgroup administrators Jim /add >$null 2>&1
    net localgroup students /add >$null 2>&1
}

$stu="$srt\students.txt"

if (!(Test-Path -Path $stu )){
    Write-Host "Error couldn't find student list, students.txt"
    $z = Read-Host -Prompt "Press Any Key to Continue" 
    Exit
}
 
$countdel = 0
$countold = 0
$counter = 0
#for every name in the students.txt
foreach ($s in $(Get-Content $stu)){
        #delete option
        if($removeuser){
            net localgroup students "$s" /delete >$null 2>&1
            net user "$s"  /delete >$null 2>&1
            $countdel++
            Write-Host "Deleting user :$countdel : $s"
        }
        else {
            #silently checks if username exists
            $check = net user $s  2>&1 | Out-String
            #check will contain "User name" the account already exists
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

#set all accounts min password age to 0
net accounts /minpwage:0 >$null 2>&1