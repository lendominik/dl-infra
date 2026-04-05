@description('The name of the App Service to create. For example: "myappservice"')
param appServiceName string = 'dlappservice'

@description('The location where the App Service Plan and App Service will be deployed. For example: "eastus", "westus2", etc.')
param location string = 'westeurope'

@description('The SKU to use for the App Service Plan. For example: "B1", "S1", "P1v2", etc.')
param sku string = 'B1'

@description('The Linux FX version to use for the App Service. For example: "NODE|14-lts" or "DOTNETCORE|3.1"')
param linuxFxVersion string = 'DOTNETCORE|3.1'

@description('The URL of the Git repository containing the application code.')
param repositoryUrl string = 'https://github.com/Azure-Samples/dotnetcore-docs-hello-world'

@description('The branch of the Git repository to use for deployment. For example: "main", "dev", etc.')
param branch string = 'main'

@description('The name of the App Service Plan to create. For example: "myappservice-plan"')
var appServicePlanName string = '${appServiceName}-plan'

resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

resource appService 'Microsoft.Web/sites@2025-03-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}

resource sourceControls 'Microsoft.Web/sites/sourcecontrols@2025-03-01' = {
  parent: appService
  name: 'web'
  properties: {
    repoUrl: repositoryUrl
    branch: branch
    isManualIntegration: true
  }
}
