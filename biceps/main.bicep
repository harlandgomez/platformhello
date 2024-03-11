@description('Location for resources.')
param location string = resourceGroup().location

module vnet 'modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: 'platformsre-vnet-01'
    location: location
    addressSpace: '10.0.0.0/16'
    subnets: [
      {
        name: 'default'
        addressPrefix: '10.0.0.0/24'
      }
    ]
  }
}

module acr 'modules/acr.bicep' = {
  name: 'acrDeployment'
  params: {
    location: location
    acrName: 'platformsreacr'
  }
}

module aci 'modules/aci.bicep' = {
  name: 'aciDeployment'
  params: {
    aciName: 'sampleweb-ci'
    location: location
    subnetId: '${vnet.outputs.vnetId}/subnets/default'
    subnetName: 'aciSubtnet'
    containerImage: 'samplewebimage:latest'
    containerPort: 8080
  }
}

module agw 'modules/agw.bicep' = {
  name: 'agwDeployment'
  params: {
    location: location
    vnetName: 'platformsre-vnet-01'
    gatewaySubnetName: 'platformsre-subnetgw'
    applicationGatewayName: 'platformsre-agw'
    publicIpName: 'platformsre-publicip'
    backendPoolName: 'aciBackendPool'
  }
}
