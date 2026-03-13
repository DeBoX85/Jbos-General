# Azure VM Cost Analyzer

PowerShell script for analyzing Azure Virtual Machine usage and estimating cost optimization opportunities across multiple subscriptions.

It pulls VM inventory, checks recent usage from Azure Activity Logs, fetches live retail pricing, evaluates Savings Plan and Reserved Instance options, and exports the results to CSV and HTML.

## What it does

- Connects to Azure with `Connect-AzAccount`
- Scans all enabled subscriptions in the current tenant
- Collects all VMs with status information
- Estimates VM runtime over the last 30 days from Activity Logs
- Retrieves live VM pricing from the Azure Retail Prices API
- Calculates:
  - 24/7 monthly cost
  - usage-based monthly cost
  - 1-year Savings Plan estimate
  - 3-year Savings Plan estimate
  - 1-year Reserved Instance quote
  - 3-year Reserved Instance quote
- Pulls CPU metrics to suggest basic sizing actions:
  - Scale Down
  - Right-Sized
  - Scale Up
- Generates optimization recommendations per VM
- Exports reports to:
  - `VM-Cost-Analysis-<timestamp>.csv`
  - `VM-Cost-Analysis-<timestamp>.html`

## Key features

- Multi-subscription analysis
- Activity Log based runtime estimation
- Live Azure retail pricing lookup
- Reservation quote lookup with `Get-AzReservationQuote`
- Savings Plan fallback discount logic when API pricing is incomplete
- CPU-based right-sizing hint
- Console summary plus file exports
- Works for interactive use and can be adapted for Azure Automation

## Requirements

- PowerShell 7.2 or later
- Azure PowerShell modules:
  - `Az.Accounts`
  - `Az.Compute`
  - `Az.Monitor`
  - `Az.Reservations`

Install required modules:

```powershell
Install-Module Az.Accounts -Scope CurrentUser
Install-Module Az.Compute -Scope CurrentUser
Install-Module Az.Monitor -Scope CurrentUser
Install-Module Az.Reservations -Scope CurrentUser
