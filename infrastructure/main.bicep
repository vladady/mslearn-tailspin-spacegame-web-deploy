// Parameters
param location string
param appServicePlanName string
param webAppName string

// Check if the web app already exists
resource existingWebApp 'Microsoft.Web/sites@2022-03-01' existing = {
  name: webAppName
}

// Create App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = if (existingWebApp.name == null) {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'  // You can change this to the desired pricing tier
    tier: 'Free'
    capacity: 1
  }
}

// Create Web App
resource webApp 'Microsoft.Web/sites@2022-03-01' = if (existingWebApp.name == null) {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id  // Linking the Web App to the App Service Plan
  }
}

// Output the web app URL
output webAppUrl string = existingWebApp.name != null ? existingWebApp.properties.defaultHostName : webApp.properties.defaultHostName
