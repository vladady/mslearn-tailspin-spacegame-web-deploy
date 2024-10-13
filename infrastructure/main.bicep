// Parameters
param location string
param appServicePlanName string
param webAppName string

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
