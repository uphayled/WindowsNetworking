set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

$DISKAMOUNT = 3 

#check and create "disks"
$stu = "\stripe"

$file1 = New-Object System.IO.StreamWriter("$srt$stu"+"1")
$file2 = New-Object System.IO.StreamWriter("$srt$stu"+"2")
$file3 = New-Object System.IO.StreamWriter("$srt$stu"+"3")
$FILE_TO_READ = "test.txt"
$read = New-Object System.IO.StreamReader("$srt\$FILE_TO_READ")
Write-Host ""
Write-host "-------------------------------------------------"
Write-Host "           Readin in :" $FILE_TO_READ
Write-host "-------------------------------------------------"
Write-Host ""
$id=0
$par=2
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
                 $temp=""
                 foreach ($z in $i.ToCharArray()){
                    $temp += $z
                    $id++
                    write-host $id
                    if($id%3 -eq 2){
                        $temp = $temp.Split("")
                        $f[$id%3] += [string]  $temp[0] -bxor $temp[1]
                        $f[$id+1%3] += [string]  $temp[0] 
                        $f[$id+1%3] += [string]  $temp[1]
                        $temp=""
                    }
                    $par++
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
    #Remove-Item $srt$stu$r 
    
    $alive = 1,2,3
    #setting 
    foreach ($ccc in (1..$DISKAMOUNT)){
        if(!(Test-Path $srt$stu$ccc)){
            
            $temp=$alive[$ccc-1]
            $alive[$ccc-1]=$DISKAMOUNT
            $alive[$DISKAMOUNT-1]=$temp
        }
    }

    $a = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[0])",[System.IO.FileMode]::Open));
    $b = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[1])",[System.IO.FileMode]::Open));
    
    New-Item $srt$stu$($alive[2])".rebuilt" -type file -Force
    $todo = New-Object System.IO.StreamWriter("$srt$stu$($alive[2])")
    
    try { 
        #cannot reproduce data if one of the disks doesn thave data,
        #so we only need to check for one
        #while(($a.BaseStream.Position -ne  $a.BaseStream.Length) -and ($cc = $a.ReadChar() -bxor  $b.ReadChar())){        
        Write-Host "#-----------------#"
        write-host " rebuilding disk $($alive[2])" 
        Write-Host "#-----------------#"
        while(($a.BaseStream.Position -eq $a.BaseStream.Length) -and ($cc = $a.ReadChar() -bxor  $b.ReadChar())){       
            $todo.Write($cc)
        }
    } 
    catch{
        
    }   
    finally{
        $a.Close()
        $b.Close()
        $todo.Close()
    }

   
}

###TESTING SECTION
<#write-Host
$a = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[0])",[System.IO.FileMode]::Open));
$b = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[1])",[System.IO.FileMode]::Open));
$c = New-Object System.IO.BinaryReader([System.IO.File]::Open("$srt$stu$($alive[2])",[System.IO.FileMode]::Open));
   
$towrite = ""
$count=1
try { 
    #cannot reproduce data if one of the disks doesn thave data,
    #so we only need to check for one
    $l=1
    while(($a.BaseStream.Position -eq $a.BaseStream.Length) ){
               
        $aa[0] = $a.ReadChar()
        $aa[1] = $b.ReadChar()
        $aa[2] = $c.ReadChar()
        foreach($ks in $(1..3)){
            if($l%3 -ne 0){
                $vv=$aa[$ks % 3]
            }
        }
       
        
        $count ++
        if(!($count%8)){

        }

    }
}
finally{
    
}
$a.Close()
$b.Close()
$c.Close()

New-Item $srt"\rebuilt" -type file -Force
$d = New-Object System.IO.StreamWriter("$srt\rebuilt")


$d.close()
   #>
    
