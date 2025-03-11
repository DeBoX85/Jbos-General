<# 
In short, this PowerShell script checks the TLS (Transport Layer Security) version of a specified Azure Function App 
and updates it to version 1.3 latest version if it's currently set to an older version. It performs the following key actions:

Installs the necessary Azure PowerShell module.
Logs into your Azure account.
It fetches and parses the official Microsoft Azure documentation page for App Service TLS support to identify the newest supported TLS version dynamically.
Sets the active subscription to work with.
Retrieves the current TLS version of the specified Function App.
Updates the TLS version to latest version if it's not already set to that version.

If it cannot fetch the version, it safely defaults to TLS 1.3 and provides a warning.
It compares your current TLS version with the official latest and updates only if needed.
#>



# Ensure Az module is installed
Install-Module -Name Az -AllowClobber -Scope CurrentUser

# Variables
$subscriptionId      = "your-subscription-id"
$resourceGroupName   = "your-resource-group"
$functionAppName     = "your-function-app"

# Connect to Azure with your credentials
Connect-AzAccount
Set-AzContext -Subscription $subscriptionId

# Function to retrieve the latest TLS version from Azure Docs
function Get-LatestAzureTlsVersion {
    try {
        $tlsDocUrl = "https://learn.microsoft.com/en-us/azure/app-service/overview-tls"
        $tlsPageContent = Invoke-WebRequest -Uri $tlsDocUrl -UseBasicParsing

        # Extract the latest TLS version mentioned (e.g., TLS 1.3)
        $matches = [regex]::Matches($tlsPageContent.Content, 'TLS (\d\.\d)')
        $tlsVersions = $matches | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Descending -Unique

        return $tlsVersions[0] # Highest version found
    }
    catch {
        Write-Warning "Unable to fetch latest TLS version, defaulting to 1.2"
        return "1.2"
    }
}

# Retrieve latest officially supported TLS version
$latestTlsVersion = Get-LatestAzureTlsVersion
Write-Host "Latest official TLS Version: $latestTlsVersion"

# Get current TLS configuration of your Function App
$config = Get-AzResource -ResourceGroupName $resourceGroupName `
                         -ResourceType "Microsoft.Web/sites/config" `
                         -ResourceName "$functionAppName/web" `
                         -ApiVersion "2022-03-01"

$currentTlsVersion = $config.Properties.minTlsVersion
Write-Host "Current TLS Version of Function App '$functionAppName': $currentTlsVersion"

# Check if update is needed
if ($currentTlsVersion -ne $latestTlsVersion) {
    Write-Host "Updating TLS version from $currentTlsVersion to $latestTlsVersion..."
    
    $config.Properties.minTlsVersion = $latestTlsVersion

    # Apply the TLS update
    Set-AzResource -ResourceId $config.ResourceId `
                   -Properties $config.Properties `
                   -ApiVersion "2022-03-01" `
                   -Force

    Write-Host "TLS version successfully updated to $latestTlsVersion for Function App: $functionAppName"
}
else {
    Write-Host "Function App '$functionAppName' already uses the latest TLS version ($latestTlsVersion)."
}
