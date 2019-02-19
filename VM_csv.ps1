$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “

$template = “Win-2k12“   # name of template

$ds = “FC_DS02“			 # Datastore where VM ll be created

$Cluster = “ “			# Cluster where VM ll be created

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

foreach ($Row in (import-csv C:\Users\Desktop\Marcus\teste.csv)) {
 
$Name = $Row.Name  ##coluna name

$ESXi=Get-Cluster $Cluster | Get-VMHost -state connected | Get-Random			#choose random host 

write-host “Creation of VM $Name initiated” -foreground green

New-VM -Name $Name -Template $template -VMHost $ESXi -Datastore $ds -DiskStorageFormat Thick -Location Parte4

}



