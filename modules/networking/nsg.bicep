param nsgName string
param location string
param myIp string

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  properties: {}
}

// resource nsgRules 'Microsoft.Network/networkSecurityGroups/securityRules@2024-07-01' = {
//   name: 'allowSSHInbound'
//   parent: nsg
//   properties: {
//     access: 'Allow'
//     direction: 'Inbound' 
//     priority: 100
//     protocol: 'Tcp'
//     destinationPortRange: '22'
//     destinationAddressPrefix: '*'
//     sourceAddressPrefix: myIp
//     sourcePortRange: '*'
//   }
// }


output nsgId string = nsg.id
