targetScope = 'subscription'

@allowed(['test', 'dev', 'prod'])
param environment string = 'dev'

@maxLength(30)
@minLength(1)
param location string = 'westeurope'

@maxLength(30)
@minLength(1)
param resourceGroupName string

var tags = {
    Environment: environment
    CreatedBy: 'Bicep'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}
