foreach ($Row in (import-csv C:\Users\Admin\...\testetag2.csv)) {
 
$Name = $Row.Name  ##coluna Name

write-host $Name

$VLAN = $Row.VLAN ##coluna VLAN

write-host $VLAN

$myReferncePortroup = Get-VDPortgroup -Name "DPortGroup"

Get-VDSwitch -Name "DSwitchTeste" | New-VDPortgroup -Name $Name -ReferencePortgroup $myReferncePortroup 
Get-VDPortgroup -Name $Name | Set-VDPortgroup -VlanId $VLAN

write-host "Criando o PG" $Name "com VLAN" $VLAN

}


##Ver https://developer.vmware.com/docs/powercli/latest/vmware.vimautomation.vds/commands/set-vdvlanconfiguration/#VDPort
