

$PGs = "ATZ (1)",
"PG  VLAN 2005 1535561172343 (1)",
"PG_CNI_DMZ_VLAN226 (1)" # ...

foreach($PG in $PGs){

$path = "C:\Users\User\path_to_save_PortGroups\$PG.zip" ##.zip is created with the port group name

Get-VDPortgroup -Name $PG | Export-VDPortGroup -Destination "$path"

}
