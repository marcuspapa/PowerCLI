$vCenter=” “

#$vCenterUser=” “
#$vCenterUserPassword=” “   #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

#Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

Connect-viserver $vCenter

$tags =

"bkp-auditoria:sim",
"bkp-auditoria:nao",
"bkp-critico:sim",
"bkp-critico:nao",
"bkp-retencao:default",
"bkp-retencao:01ano",
"bkp-retencao:03anos",
"bkp-retencao:05anos",
"bkp-retencao:07anos",
"bkp-retencao:10anos",
"bkp-retencao:20anos",
"bkp-retencao:outros",
"bkp-horario:default",
"bkp-horario:18hs",
"bkp-horario:20hs",
"bkp-horario:22hs",
"bkp-horario:00hs",
"bkp-horario:02hs",
"bkp-horario:04hs",
"bkp-horario:06hs",
"bkp-so:windows",
"bkp-so:linux",
"bkp-so:unix"


##No notepad, coloque o cursor na primeira linha, alt+shift+down até o final e coloca " em todas as linhas. Faz o mesmo no final
##No notepad também (Ctrl+h), coloca $ em Localizar e ", em sustituir por, marcando a opção expressões regulares

#Essa linha cria um Tag Category, mas recomendo criar manualmente
#New-TagCategory -Name 'Backup' -Cardinality Multiple -Description "Tag de Backup"

foreach($tag in $tags){

#New-Tag -Name $tag -Category 'Backup' ## Funciona na 6.7 e 7 as vezes dá problemas na 6.5

Get-TagCategory -Name "Backup" | New-Tag -Name $tag


}
