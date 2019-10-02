

Get-ChildItem “C:\Users\marcus.papa\Desktop\Marcus\Exports\VCD_PRD” | Foreach {

New-VDPortgroup -VDSwitch Unicloud-vDS_PRODUCAO -Name “$($_.BaseName)” -BackupPath $_.FullName

}