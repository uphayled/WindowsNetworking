set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

$DISKAMOUNT = 3 

#check and create "disks"
$stu = "\stripe"

$file1 = New-Object System.IO.StreamWriter("$srt$stu"+"1")
$file2 = New-Object System.IO.StreamWriter("$srt$stu"+"2")
$file3 = New-Object System.IO.StreamWriter("$srt$stu"+"3")
$FILE_TO_READ = "macbeth.txt"
$read = New-Object System.IO.StreamReader("$srt\$FILE_TO_READ")
Write-Host ""
Write-host "-------------------------------------------------"
Write-Host "           Readin in :" $FILE_TO_READ
Write-host "-------------------------------------------------"
Write-Host ""
$parity=0
$enc = [system.Text.Encoding]::ASCII
measure-command { 
    try {
        while($read.Peek() -ge 0){
            $f = "","",""
            $b =  $enc.GetBytes($read.ReadLine()) 
            foreach ($a in $b){
                 $j = [string] [convert]::ToString([int32]$a,2).PadLeft(8,'0')
                 
                 $i = $j.Split("") 
                 $towrite = [char],[char]
                 $id=0
                 foreach ($z in $i.ToCharArray()){
                    
                    $towrite[$id++] = $z
                    
                    if($id%3 -eq 2){
                        $f[$parity++%3] +=   $towrite[0] -bxor $towrite[1]
                        
                        $f[$parity++%3] +=   $towrite[0] 
                       
                        $f[$parity++%3] +=   $towrite[1]
                        $towrite=[char],[char]
                        $id=0
                        $parity++
                    }

                 }
            }
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
    Write-Host "#-------------------------------------------------#"
    write-host " deleting disk $r -- backedup in directory deleted"
    Write-Host "#-------------------------------------------------#"

    New-Item $srt\"deleted" -type directory -Force
    Copy-item -Path $srt$stu$r -Destination $srt\"deleted"\$stu$r -Force    
    Remove-Item $srt$stu$r 
    
    $alive = 1,2,3
    #setting 
    foreach ($ccc in (1..$DISKAMOUNT)){
        if(!(Test-Path $srt$stu$ccc)){
            $temp=$alive[$ccc-1]
            $alive[$ccc-1]=$DISKAMOUNT
            $alive[$DISKAMOUNT-1]=$temp
        }
    }

    $aa = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[0])",[System.IO.FileMode]::Open));
    $bb = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[1])",[System.IO.FileMode]::Open));
    
    New-Item $srt$stu$($alive[2])".rebuilt" -type file -Force
    $todo = New-Object System.IO.StreamWriter("$srt$stu$($alive[2]).rebuilt")
    
    try { 
        #cannot reproduce data if one of the disks doesn thave data,
         Write-Host "#-----------------#"
        write-host " rebuilding disk $($alive[2])" 
        Write-Host "#-----------------#"
        while($aa.PeekChar()){  
            $todo.Write( $aa.ReadChar() -bxor $bb.ReadChar())  
        }
    }  
    finally{
        $aa.Close()
        $bb.Close()
        $todo.Close()
    }

   
}

###TESTING SECTION
write-Host "testing section"
$a = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[0])",[System.IO.FileMode]::Open));
$b = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[1])",[System.IO.FileMode]::Open));
$c = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[2]).rebuilt",[System.IO.FileMode]::Open));
 
New-Item $srt"\rebuilt" -type file -Force
$d = New-Object System.IO.StreamWriter("$srt\rebuilt")
  
$towrite = ""
try { 
    #cannot reproduce data if one of the disks doesn thave data,
    #so we only need to check for one
    $l=0

    while($a.PeekChar()){
        $temp = [char],[char],[char]       
        $temp[0] = $a.ReadChar()
        $temp[1] = $b.ReadChar()
        $temp[2] = $c.ReadChar()

        foreach($ks in $(0..2)){
            if($ks -ne $l){
                $towrite += [string] $temp[$ks]
                $temp = [char],[char],[char]       
            }

        }
        $l++
        
        if($towrite.Length -eq 8){
           
            write-host $([System.Text.Encoding]::UTF8.GetString([System.Convert]::ToInt32($towrite,2)))
            $d.Write(  [System.Text.Encoding]::UTF8.GetString([System.Convert]::ToInt32($towrite,2))) 
        }
        
        
        

    }
}
finally{
    
}
$a.Close()
$b.Close()
$c.Close()



$d.close()
  
   
