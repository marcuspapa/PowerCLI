##Script creates vDisk Tab of RVTools using %Free on Datastores

$vCenter=”“
$vCenterUser=”“
$vCenterUserPassword=”“   #clear text!!!


write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

#OU se desejar preencher o user e password
#Connect-viserver $vCenter


$vcenterName = $global:defaultviserver.Name

#Faz uma lista de VMs em datastores com % livre menor que o valor após lt
$vm = Get-Datastore | where { [math]::Round( ( ($_.freespacegb/$_.capacitygb) ) * 100) -lt 50 } | Get-VM

Get-HardDisk -VM $vm | Select DiskType, StorageFormat, CapacityGB,Filename,
@{N='VM';E={$_.Parent}},
@{N='Disk';E={$_.Name}},
@{N='Datastore';E={($_.Filename -replace '\[(.*)\].*$' , '$1') }},
@{N='Naa';E={ (Get-Datastore ($_.Filename -replace '\[(.*)\].*$' , '$1')).ExtensionData.Info.Vmfs.Extent[0].DiskName }},
@{N='Cluster';E={Get-VM -Name $_.Parent | Get-Cluster }},
@{N='Power State';E={(Get-VM -Name $_.Parent).ExtensionData.Guest.GuestState }},
@{N='OS';E={(Get-VM -Name $_.Parent).ExtensionData.Guest.GuestFullName }},
@{N='vCenter';E={ $vCenterName }},
@{N='Capacity Datastore';E={(Get-Datastore ($_.Filename -replace '\[(.*)\].*$' , '$1')).CapacityGB }},
@{N='Free Space GB';E={(Get-Datastore ($_.Filename -replace '\[(.*)\].*$' , '$1')).FreeSpaceGB }},
@{N='%Free';E={(Get-Datastore ($_.Filename -replace '\[(.*)\].*$' , '$1')) | Select @{name="%";Expression={[math]::Round(($_.freespacegb / $_.capacitygb * 100),2)} }}} | Export-csv testao.csv -NoTypeInformation -UseCulture


#fazer uma separada de Datastore ou colocar tudo junto? 
#A linha a seguir é para conferir os resultados do DS
#Get-Datastore | Select-Object name, @{name="CapacityGB";Expression={[math]::Round($_.capacitygb,2)}}, @{name="FreeSpaceGB";Expression={[math]::Round($_.freespacegb,2)}}, @{name="PercentFree";Expression={[math]::Round(($_.freespacegb / $_.capacitygb * 100),2)}}


Disconnect-viserver -server * -confirm:$false

# Measure-Command { } 
