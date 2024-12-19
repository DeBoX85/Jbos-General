$rg = Get-AzResourceGroup -Name rg-iac-shared-1
Get-AzResource -ResourceGroupName $rg.ResourceGroupName | Remove-AzResource -Force