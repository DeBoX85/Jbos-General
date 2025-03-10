#!/bin/bash
#################################################################################
# project: az-kung-fu
# http://www.build5nines.com/az-kung-fu
# MIT License - https://github.com/Build5Nines/az-kung-fu
# WARNING: These scripts could either cause resume generating events or get you promoted.
# Please, proceed with extreme caution!
#################################################################################
# Script Purpose
# - List your accounts (subscriptions) in azure
# Script Usage
# - Update with your Azure Subscription Name or Id
# - All commands run will be against this subscription
##################################################################################

## List your Azure accounts (subscription) in jsonc
az account --help

## List your Azure accounts (subscription) table
az account list -o table