set-strictmode -version 2.0

#root of where script is being run
$srt = $PSScriptRoot

function showServices{    
    <#
        .Synopsis         
        Shows all services then exports to a csv file         
    #>
    
    Write-Host "Show Services"
    $services=get-service | sort-object status,name 
    echo $services
    echo $services | Export-csv -Path $srt/allservices.csv -Delimiter ","
    $z = Read-Host -Prompt "Press Any Key to Continue" 
}
function shoeProcess{ 
    <# .Synopsis         
       Shows all processes then exports to a csv file #>   
    Write-Host "Show Processes" 
    Get-process | Select-Object Name,WorkingSet,VirtualMemorySize| Sort-Object VirtualMemorySize -descending | ConvertTo-HTML | Out-File $srt\runningprocesses.htm
    Invoke-Expression $srt\runningprocesses.htm
    $z = Read-Host -Prompt "Press Any Key to Continue" 
}
function showSysInfo{   
    <# .Synopsis         
       Runs a script to display system info #>   
    Write-Host "Show System Information"     
    & $srt/"Sysinfo.ps1"    
    $z = Read-Host -Prompt "Press Any Key to Continue"
}
function showDoor{
    <# .Synopsis         
       Exits script #> 
    Write-Host "Existing"
    Read-Host -Prompt "Press Any Key to Continue" 
    exit
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
        "B" {shoeProcess}
        "C" {showSysInfo}
        "X" {shoeDoor}
        default {
            Write-Host "Please Enter One of the Accepted Choices" 
            Read-Host -Prompt "Press Any Key to Continue" 
            }

    }
}

