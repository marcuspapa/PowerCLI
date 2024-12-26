
# PowerCLI Script to Run iperf inside a VM

# Connect to your vCenter server
Connect-VIServer -Server Your-vCenter-Server -User Your-Username -Password Your-Password

# Specify the VM name
$VMName = "Your-VM-Name"

# Specify the iperf server details
$ServerAddress = "your_server_ip"
$ServerPort = "your_server_port"

# Specify the duration of the test in seconds
$TestDuration = 10

# Build the iperf command
$iperfCommand = "C:\Path\To\iperf3.exe -c $ServerAddress -p $ServerPort -t $TestDuration"

# Run iperf inside the VM
Invoke-VMScript -VM $VMName -ScriptText $iperfCommand -GuestUser Your-VM-Username -GuestPassword Your-VM-Password

# Disconnect from the vCenter server
Disconnect-VIServer -Confirm:$false
