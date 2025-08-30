param subnetName string
param vnetName string
param addressPrefix string
param nsgId string

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' existing = {
  name: vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: subnetName
  parent: vnet
  properties: {
    addressPrefix: addressPrefix
    privateEndpointNetworkPolicies: 'Disabled'
    networkSecurityGroup: {
      id: nsgId
    }
  }
}

output subnetId string = subnet.id
