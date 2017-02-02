Clear
cls

ipconfig

cls

Get-Service

cls

get-Service * |where {$_.Status -eq "Stopped"}


cls
      
get-Service * |Sort-Object -property ServiceType | format-Table name, ServiceType, status, CanStop, -auto

cls

#This script is a bit longer
$strComputer = "."
$colItems = get-wmiobject -class "Win32_NetworkAdapterConfiguration" `
-computername $strComputer | Where{$_.IpEnabled -Match "True"}
foreach ($objItem in $colItems) {
   write-host "MAC Address : " $objItem.MACAddress
   write-host "IPAddress : " $objItem.IPAddress
   write-host "IPAddress : " $objItem.IPEnabled 
   write-host ""
}
Write-Host "---------------------------------------------"
Write-Host ""
#######This script is a bit longer
$strComputer = "."
$colItems = get-wmiobject -class "Win32_NetworkAdapterConfiguration" `
-computername $strComputer | Where{$_.IpEnabled -Match "True"}
foreach ($objItem in $colItems) {
   write-host "MAC Address : " $objItem.MACAddress
   write-host "IPAddress : " $objItem.IPAddress
   write-host "IPAddress : " $objItem.IPEnabled 
   write-host "DNS Servers : " $objItem.DNSServerSearchOrder
   write-host "Subnet : " $objItem.IPSubnet
   write-host ""
}


cls
# PowerShell script to list processes and group by company
get-Process | sort company | format-Table ProcessName -groupby company


##[System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

Get-Process | Get-Member

Set-executionpolicy unrestricted