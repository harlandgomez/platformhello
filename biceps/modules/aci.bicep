param aciName string
param location string = resourceGroup().location
param containerImage string
param containerPort int
param subnetId string // This will be passed from the main Bicep file

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
    ipAddress: {
      type: 'Public'
      dnsNameLabel: '${aciName}-dns' // Provides a DNS name to access the container publicly
      ports: [
        {
          protocol: 'TCP'
          port: containerPort
        }
      ]
    }
    subnetIds: [ subnetId ]
  }
}

// Output the FQDN for accessing the ACI
output fqdn string = containerGroup.properties.ipAddress.fqdn
