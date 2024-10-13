// Parameters
param location string
param appServicePlanName string
param webAppName string

// Create App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'  // You can change this to the desired pricing tier
    tier: 'Free'
    capacity: 1
  }
}

// Create Web App
resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id  // Linking the Web App to the App Service Plan
  }
}

// Output the App Service URL
output webAppUrl string = webApp.properties.defaultHostName
