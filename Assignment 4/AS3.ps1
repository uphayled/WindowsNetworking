set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

measure-command { 


$stu = "\stripe"
foreach ($a in (1..3)){
    while (!(Test-Path -Path $srt$stu$a )){
        out-file -filepath $srt$stu$a
    }
    write-host "$stu$a file exists"
}
 
$chunksize=1024
$arr = New-Object System.Collections.ArrayList
$arr = [io.file]::ReadAllBytes("$srt\MacBeth.txt")
[io.file]::WriteAllBytes('c:\scripts\test2.jpg',$file)

#foreach ($c in @(Get-Content $srt\"MacBeth.txt" -Encoding byte) ){
#    $arr.add($c)
#}
$id=0
foreach ($c in $arr){
    $a = (($i ++ )%3) +1
    out-file -FilePath $srt$stu$a -InputObject $c
}

    
    $r = ((get-random)%3) +1
    write-host "deleting disk $r"

    write-host "" | out-file -FilePath $srt$stu$r






    if(!(Test-Path -Path $srt$stu"1" )){
        get-content $srt$stu
    }
    else
        if(!(Test-Path -Path $srt$stu$a)


    
}