set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

function showServices{
Write-Host "Show Services"
    $services=get-service | sort-object status,name 

    echo $services

    echo $services | Export-csv -Path $srt/allservices.csv -Delimiter ","

    $z = Read-Host -Prompt "Press Any Key to Continue" 
}
function shoeProcess{
Write-Host "Show Processes" 

    Get-process | Sort-Object Status, Name, DisplayName | ConvertTo-HTML | Out-File $srt\Test.htm

    Invoke-Expression $srt\Test.htm

    $z = Read-Host -Prompt "Press Any Key to Continue" 
}
function showSysInfo{
    Write-Host "Show System Information" 
    & $srt/"Sysinfo.ps1"
    $z = Read-Host -Prompt "Press Any Key to Continue" 
}



cls
$userinput = ""
while ($userinput -ne "X" ){
    Write-Host "420-536: System Utilities"

    Write-Host "A - Show Services"

    Write-Host "B - Shoe Processes"

    Write-Host "C - Show System Information"

    Write-Host ""

    Write-Host "X - Exist"

    $userinput = Read-Host -Prompt "Your choice" 
    cls
    switch ($userinput){
        "A" {showServices}
        "B" {ShoeProcess}
        "C" {ShowSysInfo}
        "X" {
            Write-Host "Existing"
            Read-Host -Prompt "Press Any Key to Continue" 
            exit
            }
        default {
            Write-Host "Please Enter One of the Accepted Choices" 
            Read-Host -Prompt "Press Any Key to Continue" 
            }

    }
}

