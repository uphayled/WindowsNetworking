set-strictmode -version 2.0


function showServices{

    
    $z = Read-Host -Prompt "Press Any Key to Continue" 
}
function shoeProcess{

    $z = Read-Host -Prompt "Press Any Key to Continue" 
}
function showSysInfo{

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
        "A" {
            Write-Host "Show Services" 
            showServices  
            }
        "B" {
            Write-Host "Show Processes" 
            ShoeProcess 
            }
        "C" {
            Write-Host "Show System Information" 
            ShowSysInfo 
            }
        "X" {
            Write-Host "Existing"
            Read-Host -Prompt "Press Any Key to Continue" 
            exit
         }
        default {"Please Enter One of the Accepted Choices"}

    }
}

