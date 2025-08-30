param vnetName string
param location string
param addressSpaces array

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressSpaces
    }
  }
}

output vnetName string = vnet.name
