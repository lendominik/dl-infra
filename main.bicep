targetScope = 'subscription'

@allowed(['Dev', 'Test', 'Prod'])
param environment string = 'Dev'

@maxLength(30)
@minLength(1)
param location string = 'westeurope'

@maxLength(30)
@minLength(1)
param resourceGroupName string = 'rg-dl'

var tags = {
    Environment: environment
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}
