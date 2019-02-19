#Script para retirar sufixo dos nomes de máquinas virtuais
 
#ex: vm.gov -> vm

$vms = Get-VM *.suffix

foreach($vm in $vms){ 

[String]$rename = $vm -Split ".suffix"

Set-VM -VM $vm -Name $rename -Confirm:$false
}


