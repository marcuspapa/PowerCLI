$vCenters = @(

)

$FolderName = "Discovered VMs"
$ADGroup    = "Domain\GroupName"
$RoleName   = "VirtualMachinePowerUser"

$Credential = Get-Credential

foreach ($vCenter in $vCenters) {

    Write-Host "`nConectando ao $vCenter..." -ForegroundColor Cyan

    try {
        $Connection = Connect-VIServer `
            -Server $vCenter `
            -Credential $Credential `
            -ErrorAction Stop

        # Localiza a folder
        $Folder = Get-Folder `
            -Name $FolderName `
            -Type VM `
            -Server $Connection `
            -ErrorAction Stop

        # Verifica se o grupo já possui permissão na folder
        $ExistingPermission = Get-VIPermission `
            -Entity $Folder `
            -Server $Connection |
            Where-Object {
                $_.Principal -eq $ADGroup
            }

        if ($ExistingPermission) {

            Write-Host "O grupo '$ADGroup' já possui permissão na folder '$FolderName' em $vCenter." `
                -ForegroundColor Yellow
        }
        else {

            # Cria a permissão
            New-VIPermission `
                -Entity $Folder `
                -Principal $ADGroup `
                -Role $RoleName `
                -Propagate:$true `
                -Server $Connection `
                -ErrorAction Stop | Out-Null

            Write-Host "Permissão '$RoleName' atribuída ao grupo '$ADGroup' na folder '$FolderName' em $vCenter." `
                -ForegroundColor Green
        }
    }
    catch {
        Write-Host "Erro ao configurar ${vCenter}: $($_.Exception.Message)" `
            -ForegroundColor Red
    }
    finally {
        Disconnect-VIServer `
            -Server $vCenter `
            -Confirm:$false `
            -ErrorAction SilentlyContinue
    }
}


