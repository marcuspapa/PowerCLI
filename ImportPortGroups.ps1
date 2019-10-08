

$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “   #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

#########################################################################################################################################

$vDS = "vDS_PRODUCAO" ###vDS Name

Get-ChildItem “C:\Users\path_where_are_the_port_groups_imported” | Foreach {

New-VDPortgroup -VDSwitch $vDS -Name “$($_.BaseName)” -BackupPath $_.FullName

}
