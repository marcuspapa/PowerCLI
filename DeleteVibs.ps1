####delete VIBs

hosts = Get-Cluster NomeCluster | Get-VMHost
forEach ($vihost in $hosts)
{
$esxcli = get-vmhost $vihost | Get-EsxCli
$esxcli.software.vib.list() | Where { $_.Name -like "*vib-name*"} | Select @{N="VMHost";E={$ESXCLI.VMHost}}, Name, Version
}


$hosts = Get-Cluster YourClusterName | Get-VMHost
forEach ($vihost in $hosts)
{

$esxcli = get-vmhost $vihost | Get-EsxCli
$vib=$esxcli.software.vib.list() | Where { $_.Name -like "*vib-name*"}
$vib | ForEach { $esxcli.software.vib.remove($false,$true,$false,$true,$_.Name)}

}

##Para um único host

$vihost = "nomedohost"


$esxcli = get-vmhost $vihost | Get-EsxCli
$vib=$esxcli.software.vib.list() | Where { $_.Name -like "*vib-name*"}
$vib | ForEach { $esxcli.software.vib.remove($false,$true,$false,$true,$_.Name)}
