targetScope = 'subscription'

@description('The environment for the deployment. Allowed values are: test, dev, prod.')
@allowed(['test', 'dev', 'prod'])
param environment string = 'dev'

@description('The location where the resource group will be created.')
@minLength(1)
@maxLength(30)
param location string = 'westeurope'

@description('The name of the resource group.')
@minLength(1)
@maxLength(30)
param resourceGroupName string

@description('The name of the application. For example: "myapp".')
@minLength(1)
@maxLength(20)
param appName string

var prefix = '${environment}-${appName}'

var appServiceName = '${prefix}-appservice'

var tags = {
    Environment: environment
    CreatedBy: 'Bicep'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module appServiceModule 'modules/app-service.bicep' = {
  name: 'appServiceDeployment'
  scope: resourceGroup
  params: {
    appServiceName: appServiceName
  }
}
