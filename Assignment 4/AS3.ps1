set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

$DISKAMOUNT = 3 

#check and create "disks"
$stu = "\stripe"

$file1 = New-Object System.IO.StreamWriter("$srt$stu$q")
$file2 = New-Object System.IO.StreamWriter("$srt$stu$w")
$file3 = New-Object System.IO.StreamWriter("$srt$stu$e")
$id=1
$line=3
$read = New-Object System.IO.StreamReader("$srt\macbeth.txt")
$l = 1
$enc = [system.Text.Encoding]::ASCII
measure-command { 
try {
    while($read.Peek() -ge 0){
        $f = "","",""
        
        $b =  $enc.GetBytes($read.ReadLine()) 
        foreach ($a in $b){
             $j = [string] [convert]::ToString([int32]$a,2).PadLeft(8,'0')

             $i = $j.Split("") 
             foreach ($z in $i.ToCharArray()){
                $f[($id++ % $DISKAMOUNT )] += $z -bxor ($l/$id)
             }
        }
        $l++
        $file1.Write($f[0])
        $file2.Write($f[1])
        $file3.Write($f[2])
        
        
        
        
    }

        
}
finally {
    $file1.Close()
    $file2.Close()
    $file3.Close()
    $read.Close()
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
 
}