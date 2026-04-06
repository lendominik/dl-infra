@description('Required. The name of the App Service to create.')
param appServiceName string

@description('Optional. The location where the App Service Plan and App Service will be deployed. For example: "eastus", "westus2", etc.')
param location string = 'westeurope'

@description('Optional. The SKU to use for the App Service Plan. For example: "B1", "S1", "P1v2", etc.')
param sku string = 'B1'

@description('Optional. The Linux FX version to use for the App Service. For example: "NODE|14-lts" or "DOTNETCORE|3.1"')
param linuxFxVersion string = 'DOTNETCORE|8.0'

@description('Optional. Optional. The URL of the Git repository containing the application code.')
param repositoryUrl string = 'https://github.com/Azure-Samples/dotnetcore-docs-hello-world'

@description('Optional. The branch of the Git repository to use for deployment. For example: "main", "dev", etc.')
param branch string = 'main'

@description('Optional. The name of the App Service Plan to create. For example: "myappservice-plan"')
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

// it will be updated in the future to use deployment slots and deployment pipelines, but for now we will use manual integration with GitHub repository
resource sourceControls 'Microsoft.Web/sites/sourcecontrols@2025-03-01' = {
  parent: appService
  name: 'web'
  properties: {
    repoUrl: repositoryUrl
    branch: branch
    isManualIntegration: true
  }
}

output appServiceId string = appService.id
output appServicePlanId string = appServicePlan.id
