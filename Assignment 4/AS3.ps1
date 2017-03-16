set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

$DISKAMOUNT = 3 

#check and create "disks"
$stu = "\stripe"

$file1 = New-Object System.IO.StreamWriter("$srt$stu"+"1")
$file2 = New-Object System.IO.StreamWriter("$srt$stu"+"2")
$file3 = New-Object System.IO.StreamWriter("$srt$stu"+"3")
$id=1
$line=3
$read = New-Object System.IO.StreamReader("$srt\test.txt")
$l = 1
$enc = [system.Text.Encoding]::ASCII
measure-command { 
    try {
        while($read.Peek() -ge 0){
            $f = "","",""
            $b =  $enc.GetBytes($read.ReadLine()) 
            foreach ($a in $b){
                 $j = [string] [convert]::ToString([int32]$a,2).PadLeft(8,'0')
                 write-host $j
                 $i = $j.Split("") 
                 foreach ($z in $i.ToCharArray()){
                    $f[($id++ % $DISKAMOUNT )] +=[string] $z -bxor ($l/$id)
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
    #disk number not index
    $r = 1#((get-random)%$DISKAMOUNT) +1

    write-host "deleting disk $r"

    Remove-Item $srt$stu$r
    $rebuild
    $todo
     
    foreach ($z in (1..$DISKAMOUNT)){
        $drives=0
        if(Test-Path "$srt$stu$z"){
            $rebuild[$drives++] = New-Object System.IO.StreamReader("$srt$stu$z")

        }
        else{
            $todo = New-Object System.IO.StreamWriter("$srt$stu"+$z)
        }
    }
    write-host $rebuild[0]
    write-host $rebuild[1]
    try {
        $count=0
        
        while($true){
           $sum1 = 0
           $sum2 = 0
           $rebuild[0].Read($sum1,$count++,$count)
           $rebuild[1].Read($sum2,$count++,$count)
           $t=$sum1+$sum2
           $todo.Write($t)

        }

    }
    finally {
        $todo.Close()
    }
    
    foreach ($z in $rebuild){
        
       # $rebuild[$todo] += $z
        
    }
}

   
    
