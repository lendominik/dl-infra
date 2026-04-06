import * as shared from './shared.bicep'

targetScope = 'subscription'

@description('Required. Name of the environment to deploy.')
param environment shared.Environment = 'dev'

@description('Required. The name of the resource group.')
@minLength(1)
@maxLength(30)
param resourceGroupName string

@description('Optional. Location of all resources.')
@minLength(1)
@maxLength(30)  
param location string = 'westeurope'

var prefix = '${shared.sharedPrefix}-${environment}'

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

output appServiceId string = appServiceModule.outputs.appServiceId
output appServicePlanId string = appServiceModule.outputs.appServicePlanId
