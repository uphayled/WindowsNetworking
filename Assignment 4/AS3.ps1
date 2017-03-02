﻿set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

$DISKAMOUNT = 3 

<#check and create "disks"
$stu = "\stripe"
foreach ($a in (1..3)){
    while (!(Test-Path -Path $srt$stu$a )){
        out-file -filepath $srt$stu$a
    }
    write-host "$stu$a file exists"
}#>

#$arr# = [io.file]::ReadAllBytes("$srt\macbeth.txt")

#[io.file]::WriteAllBytes("$srt$stu",$arr)

#foreach ($c in @(Get-Content $srt\"MacBeth.txt" -Encoding byte) ){
#    $arr.add($c)
#}
$id=0
$line=3
$read = New-Object System.IO.StreamReader("$srt\macbeth.txt")
$enc = [system.Text.Encoding]::ASCII
measure-command { 
try {
    while($read.Peek() -ge 0){
        $f = [String[]] 
        $b =  $enc.GetBytes($read.ReadLine()) 
        foreach ($a in $b){
             $j =  [convert]::ToString([int32]$a,2)
             
             foreach($h in $j ){
                 $f[$id++ % $DISKAMOUNT] = $h 
                 
             }
        }
        #write-host $f
        
        
        
    }

        
}
finally {
    $reader.Close()
}

$stu = "\stripe"
<#
#READ OUT
$id=0
foreach ($c in $arr){
    $a = (($i ++ )%3) +1
    $j = [convert]::ToString([int32]$c,2)
    out-file -FilePath $srt$stu$a -InputObject $j
}
#>
    
$r = ((get-random)%$DISKAMOUNT) +1
write-host "deleting disk $r"

write-host "" | out-file -FilePath $srt$stu$r



foreach ($i in (1..$DISKAMOUNT)){
    write-host  (get-content $srt$stu$i)
}

<# $dead=-1;
$d1 
$d2
if(!(Test-Path -Path $srt$stu"1" )){
    $d1 = get-content $srt$stu"2"
    $d2 = get-content $srt$stu"3"
    $dead = 1        
}
else{
    if(!(Test-Path -Path $srt$stu"2")){
        $d1 = get-content $srt$stu"1"
        $d2 = get-content $srt$stu"3"
        $dead = 2
    }        
    else{
        $d1 = get-content $srt$stu"1"
        $d2 = get-content $srt$stu"2"
        $dead = 3
    }

}#>

   
}