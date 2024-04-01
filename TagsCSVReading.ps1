#CCSV Reading and creating Tags

## CSV with 3 collumns (Name, Category and Description)


foreach ($Row in (import-csv C:\Users\Admin\Desktop\....caminho_paraCSV...\testetag2.csv)) {
 
$Name = $Row.Name  ##coluna Name

write-host $Name

$Category = $Row.Category ##coluna Category

write-host $Category

$Description = $Row.Description ##Coluna Description

write-host $Description

Get-TagCategory -Name $Category | New-Tag -Name $Name -Description $Description

write-host "Criando a tag" $Name "na categoria" $Category

}
