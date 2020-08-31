#Script separating flat and raw disks by Datastore. Export.vmdk's files for two .csv files with the respective Datastore names _flat or _raw. 

$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “   #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

$DSs= "Datastore1","Datastore2" #...

Foreach($DS in $DSs){ 

Get-HardDisk -VM (Get-VM -Datastore $DS) -DiskType "RawPhysical","RawVirtual" | where {$_.filename -match $DS} | Select Parent,Name,DiskType,Filename |  Export-Csv -Path C:/Scripts/RDM/$DS"_Raw.csv"

Get-HardDisk -VM (Get-VM -Datastore $DS) -DiskType "Flat" | where {$_.filename -match $DS} | Select Parent,Name,DiskType,Filename | Export-Csv -Path C:/Scripts/RDM/$DS"_flat.csv"

}


#Get-VM -Datastore "VPLEX_PRD_VMDATA_L479" | Get-HardDisk -DiskType "RawPhysical","RawVirtual" | Select Parent,Name,DiskType,ScsiCanonicalName,DeviceName | fl
#Get-HardDisk -VM (Get-VM -Datastore "VPLEX_PRD_VMDATA_L479") | where {$_.filename -match "VPLEX_PRD_VMDATA_L479"}
