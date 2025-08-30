param nsgName string
param location string

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  properties: {}
}

output nsgId string = nsg.id
