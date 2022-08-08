$vCenter=” “
$vCenterUser=” “
$vCenterUserPassword=” “   #clear text!!!

write-host “Connecting to vCenter Server $vCenter” -foreground green

Connect-viserver $vCenter -user $vCenterUser -password $vCenterUserPassword -WarningAction 0

$ESXis = Get-VMHost

foreach($esx in $ESXis){

$sshUsername = 'root'
$password = 'Pas$w0rd'
$sshPassword = $password | ConvertTo-SecureString -AsPlainText -Force
$sshPassword.MakeReadOnly()
$sshCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $sshUsername, $sshPassword
$sshCredential = Get-Credential -Credential $sshCred
 
$sshSession = New-SSHSession -ComputerName $esx -Credential $sshCredential -AcceptKey:$true

$result = Invoke-SSHCommand -SSHSession $sshSession -Command " net-dvs -l | grep 'vxlan.vmknic' "

## ou $result = Invoke-SSHCommand -SessionId $sshSession.SessionId -Command "hostname"

Write-Host "output do " $esx "eh" $result.Output

Get-SSHSession | Remove-SSHSession

}
