param aciName string
param location string = resourceGroup().location
param containerImage string = 'platformsreacr.azurecr.io/sampleweb:latest'
param containerPort int
param subnetId string
param subnetName string
param acrLoginServer string = 'platformsreacr.azurecr.io'
param acrUsername string = 'fbf448d4-e1c4-46c6-88ac-8d740cf857ad'
@secure()
param acrPassword string

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
    imageRegistryCredentials: [
      {
        server: acrLoginServer
        username: acrUsername
        password: acrPassword
      }
    ]
    subnetIds: [
      {
        id: subnetId
        name: subnetName
      }
    ]
  }
}
