# Connect to Azure
Connect-AzAccount

# Get a list of all subscriptions in the tenant
$subscriptions = Get-AzSubscription

# Initialize an empty array to store the results
$results = @()

# Loop through each subscription
foreach ($subscription in $subscriptions)
{
    # Set the context to the current subscription
    Select-AzSubscription -SubscriptionId $subscription.Id

    # Get a list of all users with owner permissions in the subscription
    $owners = Get-AzRoleAssignment | where RoleDefinitionName -eq "Owner"

    # Loop through each owner and add a new object to the results array
    foreach ($owner in $owners)
    {
        $results += [PSCustomObject]@{
            Subscription = $subscription.Name
            User = $owner.DisplayName
        }
    }
}

# Display the results as a table
$results | Format-Table -Property Subscription, User -AutoSize

# Write the results to a file
$results | ConvertTo-Csv -NoTypeInformation | Out-File -FilePath "C:\OutputFile3.csv"