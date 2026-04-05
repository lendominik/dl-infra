targetScope = 'subscription'

@description('The environment for the deployment. Allowed values are: test, dev, prod.')
@allowed(['test', 'dev', 'prod'])
param environment string = 'dev'

@description('The location where the resource group will be created.')
@maxLength(30)
@minLength(1)
param location string = 'westeurope'

@description('The name of the resource group.')
@maxLength(30)
@minLength(1)
param resourceGroupName string

var appName = 'dl'
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
