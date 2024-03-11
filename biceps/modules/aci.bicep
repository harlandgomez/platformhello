param aciName string
param location string = resourceGroup().location
param containerImage string = 'mcr.microsoft.com/azuredocs/aci-helloworld'
param containerPort int
param subnetId string
param subnetName string

resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: aciName
  location: location
  properties: {
    containers: [
      {
        name: aciName
        properties: {
          image: containerImage
          ports: [
            {
              port: containerPort
            }
          ]
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
        }
      }
    ]
    osType: 'Linux'
    subnetIds: [
      {
        id: subnetId
        name: subnetName
      }
    ]
  }
}
