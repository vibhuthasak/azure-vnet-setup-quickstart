param subnetName string
param vnetName string
param addressPrefix string

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${vnetName}/${subnetName}'
  properties: {
    addressPrefix: addressPrefix
  }
}

output subnetId string = subnet.id
