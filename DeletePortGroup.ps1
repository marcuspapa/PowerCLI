
$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “   #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

$PGs = "Port Group1", "Port_Group2" ## ... 


##No notepad, coloque o cursor na primeira linha, alt+shift+down até o final e coloca " em todas as linhas. Faz o memso no final
##No notepad também (Ctrl+h), coloca $ em Localizar e ", em sustituir por, marcando a opção expressões regulares

foreach($PG in $PGs){

Get-VDPortgroup -Name $PG | Remove-VDPortGroup -Confirm:$false

}







