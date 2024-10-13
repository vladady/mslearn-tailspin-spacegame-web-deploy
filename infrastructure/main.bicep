// Parameters
param location string
param rgName string
param appServicePlanName string
param webAppName string

// Check if resource group exists (no direct Bicep support for RG existence check, this is implied)
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

// Create App Service Plan (Free tier as default)
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = if (rg.properties.provisioningState == 'Succeeded') {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    capacity: 1
  }
}

// Create Web App
resource webApp 'Microsoft.Web/sites@2022-03-01' = if (rg.properties.provisioningState == 'Succeeded') {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

// Output the App Service URL
output webAppUrl string = webApp.properties.defaultHostName
