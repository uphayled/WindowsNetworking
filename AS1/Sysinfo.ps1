﻿<#  
Generate a informative page about Laptop/desktop hardware and software information and give output in html 
 
http://newdelhipowershellusergroup.blogspot.com/2011/10/generate-system-information-reports.html 
 
www.amandhally.net/blog 
 
#>


#### HTML Output Formatting #######

$a = "<style>"
$a = $a + "BODY{background-color:Lavender ;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:thistle}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:PaleGoldenrod}"
$a = $a + "</style>"

################################################################################################

###### Global variables ####

$vUserName = (Get-Item env:\username).Value 			## This will get username using environment variable
$vComputerName = (Get-Item env:\Computername).Value     ## this is computer name using environment variable
$filepath = (Get-ChildItem env:\userprofile).value		## this is user profile  using environment variable



ConvertTo-Html -Title "System Information for $vComputerName" -Body "<h1> Computer Name : $vComputerName </h1>" >  "$filepath\$vComputerName.html" 

################################################
#  Hardware Information
#################################################

ConvertTo-Html -Body "<H1>HARDWARE INFORMATION </H1>" >> "$filepath\$vComputerName.html"


Get-WmiObject win32_bios -ComputerName $vComputerName | select Status,Version,PrimaryBIOS,Manufacturer,ReleaseDate,SerialNumber `
                                          | ConvertTo-html -Body "<H2> BIOS Information</H2>" >>  "$filepath\$vComputerName.html"
										  
Get-WmiObject win32_DiskDrive -ComputerName $vComputerName | Select Model,SerialNumber,Description,MediaType,FirmwareRevision |ConvertTo-html -Body "<H2> Physical DISK Drives </H2>" >>  "$filepath\$vComputerName.html"

get-WmiObject win32_networkadapter -ComputerName $vComputerName | Select Name,Manufacturer,Description ,AdapterType,Speed,MACAddress,NetConnectionID `
                                          | ConvertTo-html -Body "<H2> Network Adapters</H2>" >>  "$filepath\$vComputerName.html"
										  

################################################
#  OS Information
#################################################

ConvertTo-Html -Body "<H1>OS INFORMATION </H1>" >> "$filepath\$name.html" 

get-WmiObject win32_operatingsystem -ComputerName $vComputerName | select Caption,Organization,InstallDate,OSArchitecture,Version,SerialNumber,BootDevice,WindowsDirectory,CountryCode `
                                          | ConvertTo-html -Body "<H2> Operating System Information</H2>" >>  "$filepath\$vComputerName.html"
										  
Get-WmiObject win32_logicalDisk -ComputerName $vComputerName | select DeviceID,VolumeName,@{Expression={$_.Size /1Gb -as [int]};Label="Total Size(GB)"},@{Expression={$_.Freespace / 1Gb -as [int]};Label="Free Size (GB)"} `
                                         | ConvertTo-html -Body "<H2> Logical DISK Drives </H2>" >>  "$filepath\$vComputerName.html"
										 
Get-WmiObject Win32_NetworkAdapterConfiguration -ComputerName $vComputerName |
    Select-Object Description, DHCPServer, 
        @{Name='IpAddress';Expression={$_.IpAddress -join '; '}}, 
        @{Name='IpSubnet';Expression={$_.IpSubnet -join '; '}}, 
        @{Name='DefaultIPgateway';Expression={$_.DefaultIPgateway -join '; '}}, 
        @{Name='DNSServerSearchOrder';Expression={$_.DNSServerSearchOrder -join '; '}}, 
        WinsPrimaryServer, WINSSecondaryServer| ConvertTo-html -Body "<H2>IP Address </H2>" >>  "$filepath\$vComputerName.html" 										 



################################################
#  OS Information
#################################################

ConvertTo-Html -Body "<H1>SOFTWARE INFORMATION </H1>" >> "$filepath\$vComputerName.html"

Get-WmiObject win32_startupCommand -ComputerName $vComputerName | select Name,Location,Command,User,caption `
                                          | ConvertTo-html  -Body "<H2>Startup Softwares</H2>" >>  "$filepath\$vComputerName.html"
Get-WmiObject win32_process -ComputerName $vComputerName | select Caption,ProcessId,@{Expression={$_.Vm /1mb -as [Int]};Label="VM (MB)"},@{Expression={$_.Ws /1Mb -as [Int]};Label="WS (MB)"} |sort "Vm (MB)" -Descending `
                                         | ConvertTo-html  -Head $a -Body "<H2> Running Processes</H2>" >>  "$filepath\$vComputerName.html"
										 

Get-WmiObject win32_Service  | where {$_.StartMode -eq "Auto" -and $_.State -eq "stopped"} |  Select Name,StartMode,State | ConvertTo-html  -Head $a -Body "<H2> Services </H2>" >>  "$filepath\$vComputerName.html"										 
										 
$Report = "The Report is generated On  $(get-date) by $((Get-Item env:\username).Value) on computer $((Get-Item env:\Computername).Value)"
$Report  >> "$filepath\$vComputerName.html" 


invoke-Expression "$filepath\$vComputerName.html"  


#################### END of SCRIPT ####################################











