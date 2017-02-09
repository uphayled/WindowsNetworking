switch ($id) 
        { 
            "1" {Uninstall-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell} 
            "2" {Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell} 
            "3" { 
                    Import-Module Dism 
                    Enable-WindowsOptionalFeature -online -Featurename ServerCore-FullServer,Server-Gui-Shell,Server-Gui-Mgmt 
                } 
        }