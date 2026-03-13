# Azure VM Power Management

PowerShell runbook for scheduled Azure VM start and stop operations across multiple subscriptions, controlled by VM tags.

This repository includes:

- `VM-Powermanagement.ps1` - the Azure Automation runbook script
- `deploy.json` - an ARM template that imports the runbook into an existing Automation Account and attaches an hourly schedule

The script is built for Azure Automation with Managed Identity authentication and is intended to run once per hour.

## What it does

- Authenticates to Azure using Managed Identity
- Enumerates available subscriptions
- Switches context into each subscription
- Finds VMs tagged with `AutoShutdown`
- Determines whether each tagged VM should start, stop, or be skipped for the current hour
- Applies exclusion logic using tags for time zone, dates, and weekdays
- Starts or stops VMs only when the current power state matches the intended action
- Logs a summary of processed, started, stopped, skipped, and failed VMs

## How scheduling works

The main scheduling tag is:

- `AutoShutdown`: `"<StartHour>-<EndHour>"`

Example:

```text
AutoShutdown = 8-18
