function Get-FreeScsiLun {
 
<#  
.SYNOPSIS  Find free SCSI LUNs  
.DESCRIPTION The function will find the free SCSI LUNs
  on an ESXi server
.NOTES  Author:  Luc Dekens  
.PARAMETER VMHost
    The VMHost where to look for the free SCSI LUNs  
.EXAMPLE
   PS> Get-FreeScsiLun -VMHost $esx
.EXAMPLE
   PS> Get-VMHost | Get-FreeScsiLun
#>
 
  param (
  [parameter(ValueFromPipeline = $true,Position=1)]
  [ValidateNotNullOrEmpty()]
  [VMware.VimAutomation.Client20.VMHostImpl]
  $VMHost
  )
 
  process{
    $storMgr = Get-View $VMHost.ExtensionData.ConfigManager.DatastoreSystem
 
    $storMgr.QueryAvailableDisksForVmfs($null) | %{
      New-Object PSObject -Property @{
        VMHost = $VMHost.Name
        CanonicalName = $_.CanonicalName
        Uuid = $_.Uuid
        CapacityGB = [Math]::Round($_.Capacity.Block * $_.Capacity.BlockSize / 1GB,2)

        DisplayName = $_.DisplayName
        DevicePath = $_.DevicePath
        LocalDisk = $_.LocalDisk
        Vendor = $_.Vendor

      }
    }
  }
}

$vCenter=”papavcsa.papalab.local“
$vCenterUser=”administrator@vsphere.local“
$vCenterUserPassword=""  #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

$clusters = Get-Cluster

#Write-Output $clusters.Name

foreach($cluster in $clusters){

Write-Output "Estamos no: " $cluster.Name

#Get-Cluster | Get-VMHost | Get-FreeScsiLun | Format-List | Export-Csv -Path C:\Users\Admin\Desktop\Marcus\$vcenter"_FreeVMFS.csv"

Get-Cluster | Get-VMHost | where{$_.ConnectionState -eq 'Connected'} | Get-FreeScsiLun | Select VMhost,CanonicalName,Uuid,CapacityGB,DisplayName,DevicePath,LocalDisk,Vendor | Export-Csv -Path C:\Users\Admin\Desktop\Marcus\$vcenter"_FreeVMFS.csv"

}

Disconnect-viserver -server * -confirm:$false


#Extrair de um host específico
## (get-view ( get-vmhost -name 192.168.231.130 | Get-View ).ConfigManager.DatastoreSystem).QueryAvailableDisksForVmfs($null)
