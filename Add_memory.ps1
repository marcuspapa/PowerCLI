$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “	#clear text!!!

#------------------------------------------------
  
##Set the servers u want with 4, 8, 10, 16 ... GBs of memory

$servers4 =  " "

$servers8 =   " "

$servers10 =   " "

$servers16 =   " "


Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0


foreach ($server in $servers4){

    Set-VM -VM $server | Set-VM -MemoryGB 4 -Confirm:$false
}

foreach ($server in $servers8){

    Set-VM -VM $server | Set-VM -MemoryGB 8 -Confirm:$false
}

foreach ($server in $servers10){

    Set-VM -VM $server | Set-VM -MemoryGB 10 -Confirm:$false
}

foreach ($server in $servers16){

    Set-VM -VM $server | Set-VM -MemoryGB 16 -Confirm:$false
}





