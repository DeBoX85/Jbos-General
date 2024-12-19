$policy = New-AzureADPolicy -Definition @('{"TokenLifetimePolicy":{"Version":1,"AccessTokenLifetime":"02:00:00"}}') -DisplayName "WebPolicyScenario" -IsOrganizationDefault $false -Type "TokenLifetimePolicy"

# Get ID of the service principal
$sp = Get-AzureADServicePrincipal -Filter "DisplayName eq '<service principal display name>'"

# Assign policy to a service principal
Add-AzureADServicePrincipalPolicy -Id $sp.ObjectId -RefObjectId $policy.Id
