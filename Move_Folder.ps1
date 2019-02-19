
##working with vSphere 6.7

$vms =  

foreach($vm in $vms){

move-vm -vm (get-vm -name $vm) -Destination (get-vm -name $vm).vmhost -InventoryLocation (Get-Folder -type vm -name Parte2)

}

