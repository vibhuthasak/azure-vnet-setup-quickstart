param location string = resourceGroup().location
param vnetName string = 'myVnet'
param addressSpaces array = []

param nsgName string = 'myNsg'

param subnets array = []

module vnet './modules/vnet.bicep' = {
  name: 'vnetDeployment'
  params: {
    vnetName: vnetName
    location: location
    addressSpaces: addressSpaces
  }
}

module nsg './modules/nsg.bicep' = {
  name: 'nsgDeployment'
  params: {
    nsgName: nsgName
    location: location
  }
}

module subnetModules './modules/subnet.bicep' = [for (subnet, i) in subnets: {
  name: 'subnet-${i+1}-deployment'
  params: {
    subnetName: 'subnet-${i+1}'
    vnetName: vnet.outputs.vnetName
    addressPrefix: subnet.prefix
  }
}]

// module nsgAssociations './modules/nsg-association.bicep' = [for subnet in subnetModules: {
//   name: '${subnet.name}-nsg-association'
//   params: {
//     subnetId: subnet.outputs.subnetId
//     nsgId: nsg.outputs.nsgId
//   }
// }]
