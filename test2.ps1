
﻿foreach ($i in $(1...4)){
    set-disk -Number $i -IsOffline $false
}

foreach ($i in $(1...4)){
    set-disk -Number $i -IsReadonly $false
}

﻿Uninstall-WindowsFeature Print-Services
Get-WindowsFeature *iis*,Windows-Server-Backup,internet-print-cient,gpmc,Print-Services 
iis
Windows-Server-Backup 
internet-print-cient
gpmc
Print-Services
