param aciName string
param location string = resourceGroup().location
param containerImage string
param containerPort int
param subnetId string

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
        name: 'aciSubtnet'
      }
    ]
  }
}

output subnetName string = containerGroup.properties.subnetIds[0].name
