#Script para retirar sufixo dos nomes de máquinas virtuais
#ex: vm.gov -> vm

$vms = Get-VM *.producao1.datacenter1

foreach($vm in $vms){ 

[String]$rename = $vm -Split ".gov"

Set-VM -VM $vm -Name $rename -Confirm:$false
}


