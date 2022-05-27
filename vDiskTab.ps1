##Script creates vDisk Tab of RVTools 

$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “   #clear text!!!


write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

#OU se desejar preencher o user e password
## Connect-viserver $vCenter


$vcenterName = $global:defaultviserver.Name


Get-HardDisk -VM (Get-VM) | Select DiskType,CapacityGB,Filename,
@{N='VM';E={$_.Parent}},
@{N='Disk';E={$_.Name}},
@{N='Datastore';E={($_.Filename -replace '\[(.*)\].*$' , '$1') }},
@{N='Naa';E={ (Get-Datastore ($_.Filename -replace '\[(.*)\].*$' , '$1')).ExtensionData.Info.Vmfs.Extent[0].DiskName }},
@{N='Cluster';E={Get-VM -Name $_.Parent | Get-Cluster }},
@{N='Power State';E={(Get-VM -Name $_.Parent).ExtensionData.Guest.GuestState }},
@{N='OS';E={(Get-VM -Name $_.Parent).ExtensionData.Guest.GuestFullName }},
@{N='vCenter';E={ $vCenterName }} | Export-csv -Path C:/$vCenterName".csv"

Disconnect-viserver -server * -confirm:$false

# Measure-Command { } 
