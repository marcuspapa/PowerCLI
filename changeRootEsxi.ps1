
##Change root passwd ESXi using esxcli


$esx_hosts = Get-VMHost my_host

foreach ($esx_host in $esx_hosts) {
  $esxcli = Get-EsxCli -VMhost $esx_host -V2
  $arguments = $esxcli.system.account.set.CreateArgs()
  $arguments.id = ‘root’
  $arguments.password = ‘Password123’
  $arguments.passwordconfirmation = ‘Password123’
  $arguments

  $esxcli.system.account.set.Invoke($arguments)
}
