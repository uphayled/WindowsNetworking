set-strictmode -version 2.0

cls
$userinput = ""
while (not $userinput -eq "X" ){
    Write-Host "420-536: System Utilities"

    Write-Host "A - Show Services"

    Write-Host "B - Shoe Processes"

    Write-Host "C - Show System Information"

    Write-Host ""

    Write-Host "X - Exist"

    $userinput = Read-Host -Prompt "Your choice:_"
    $output=""
    switch ($userinput){
        "A" {$output="Show Services"}
        "B" {$output="Show Processes"}
        "C" {$output="Show System Information"}
        "X" {$output="Existing"}
        default {"Please Enter One of the Accepted Choices"}

    }
}