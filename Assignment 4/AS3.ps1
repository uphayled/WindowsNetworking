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
                 #write-host $j
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

    $r = ((get-random)%$DISKAMOUNT) +1

    write-host "deleting disk $r"

    Remove-Item $srt$stu$r 

    
    $alive = 1,2,3
    #setting 
    foreach ($ccc in (1..$DISKAMOUNT)){
        if(!(Test-Path $srt$stu$ccc)){
            write-host $srt$stu$ccc
            $temp=$alive[$ccc-1]
            $alive[$ccc-1]=$DISKAMOUNT
            $alive[$DISKAMOUNT-1]=$temp
        }
    }

    $a = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[0])",[System.IO.FileMode]::Open));
    $b = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[1])",[System.IO.FileMode]::Open));
    New-Item $srt$stu$($alive[2])".rebuilt" -type file -Force
    $todo = New-Object System.IO.StreamWriter("$srt$stu$($alive[2]).rebuilt")
    
    try { 
        #cannot reproduce data if one of the disks doesn thave data,
        #so we only need to check for one
        while(($a.BaseStream.Position -ne  $a.BaseStream.Length) -and ($aa = $a.ReadChar()) -and ($bb = $b.ReadChar())){        
            $towrite = $aa -bxor $bb
            $todo.Write($towrite)
        }
    }
    finally{
        $a.Close()
        $b.Close()
        $todo.Close()
    }

    ##
    ## testin 

    
    
    
   
}

   
    
