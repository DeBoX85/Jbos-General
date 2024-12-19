# Authenticate to your Azure account
#Connect-AzAccount


#****Choose**** :

# Get the user object for the user based on mail
#$user = Get-AzADUser -UserPrincipalName 'adm-debo@rc-n.no'

# Get the user object for the user based in display name
#$user = Get-AzADUser -SearchString "displayName eq 'Denis Bogunic'"


# Initialize an array to store the results
$results = @()

# Get a list of all subscriptions in the tenant
$subscriptions = Get-AzSubscription

# Iterate through each subscription
foreach ($subscription in $subscriptions)
{
    # Set the current subscription context
    Select-AzSubscription -SubscriptionId $subscription.Id

    # Check if the user has any role assignments in the subscription
    $roleAssignments = Get-AzRoleAssignment 
    if ($roleAssignments)
    {
        # The user has role assignments in the subscription
        foreach ($roleAssignment in $roleAssignments)
        {
            # Add a result for each role assignment
            $results += [pscustomobject]@{
                SubscriptionName = $subscription.Name
                Permission = $roleAssignment.RoleDefinitionName
            }
        }
    }
    else
    {
        # The user does not have any role assignments in the subscription
        $results += [pscustomobject]@{
            SubscriptionName = $subscription.Name
            Permission = "None"
        }
    }
}

# Sort the results by subscription name
$results = $results | Sort-Object -Property SubscriptionName

# Display the results
$results | Select-Object @{ Label = 'Subscription Name'; Expression = { $_.SubscriptionName } }, Permission | Format-Table

# Create the output file path
$filePath = "C:\subscription-permissions.csv"

# Export the results to a CSV file
$results | Select-Object @{ Label = 'Subscription Name'; Expression = { $_.SubscriptionName } }, @{ Label = 'Permission'; Expression = { $_.Permission } } | Export-Csv -Path $filePath -NoTypeInformation

# Display a message indicating the output file has been created
Write-Output "Output file '$filePath' has been created."