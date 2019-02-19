
#add cpu from a list of VMs in a csv file

$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “   #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

foreach ($Row in (import-csv path/wher3/is/the/.csv)) {
 
$Name = $Row.Name   #Row Name

write-host “Aumentando CPU da VM $Name” -foreground green

Set-VM -VM $Name -NumCpu 8 -confirm:$false

}
