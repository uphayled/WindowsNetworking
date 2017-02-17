Param(
    [int]$id = 2
)
switch ($id) 
{ 
    1 {Uninstall-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell} 
    2 {Install-WindowsFeature Server-Gui-Mgmt-Infra,Server-Gui-Shell} 
   
}