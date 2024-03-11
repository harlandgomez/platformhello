// Inside vnet.bicep

param vnetName string
param location string = resourceGroup().location
param addressSpace string
param subnets array

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressSpace
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        delegations: [
          {
            name: 'aciDelegation'
            properties: {
              serviceName: 'Microsoft.ContainerInstance/containerGroups'
            }
          }
        ]
      }
    }]
  }
}

output vnetId string = virtualNetwork.id
