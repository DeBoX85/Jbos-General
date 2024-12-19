Login-AzureRmAccount
Get-AzureRmResource | Select-Object Name ,ResourceGroupName ,ResourceType ,SubscriptionId  | Export-Csv -Path "C:\temp\azure-resources.csv"


# First, Connect with Azure Account, and select the necessary subscription
#Connect-AzureRmAccount
#If you have multiple subscription, set the context to a specific subscription
#Set-AzureRmContext -SubscriptionId 4e3b720e-12X3-4XXXc-a35a-bXYXYXXXXbYYX
#Once the subscription is set, execute the following command
#Get-AzureRmResource | Export-Csv -Path "D:\azureinventory.csv"
#
#Get-AzureRMResource cmdlet returns following
#
#Get-AzureRmResource
#   [[-Name] <String>]
#   [-ResourceType <String>]
#   [-ODataQuery <String>]
#   [-ResourceGroupName <String>]
#   [-TagName <String>]
#   [-TagValue <String>]
#   [-ExpandProperties]
#   [-ApiVersion <String>]
#   [-Pre]
#   [-DefaultProfile <IAzureContextContainer>]
#   [<CommonParameters>]
# You may not be looking for all these details to be exported. In that case, you can export only the fields by mentioning them as Select-Object.
# Get-AzureRmResource | Select-Object Name, ResourceGroupName | Export-Csv -Path "D:\ azureinventory.csv"