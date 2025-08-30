param location string = resourceGroup().location
param vnetName string = 'myVnet'
param addressSpaces array = []

param nsgName string = 'myNsg'
param myIp string = '0.0.0.0/0'

param subnets array = []

param networkRGName string = 'rg-network'
// param computeRGName string = 'rg-compute-prod'

module vnetModule './modules/networking/vnet.bicep' = {
  name: 'vnetDeployment'
  scope: resourceGroup(networkRGName)
  params: {
    vnetName: vnetName
    location: location
    addressSpaces: addressSpaces
  }
}

module nsgModule './modules/networking/nsg.bicep' = {
  name: 'nsgDeployment'
  scope: resourceGroup(networkRGName)
  params: {
    nsgName: nsgName
    location: location
    myIp: myIp
  }
}
@batchSize(1)
module subnetModules './modules/networking/subnet.bicep' = [
  for (subnet, i) in subnets: {
    name: 'subnet-${i+1}-deployment'
    scope: resourceGroup(networkRGName)
    params: {
      subnetName: 'subnet-${i+1}'
      vnetName: vnetModule.outputs.vnetName
      addressPrefix: subnet.prefix
      nsgId: nsgModule.outputs.nsgId
    }
    dependsOn: [
      vnetModule
      nsgModule
    ]
  }
]

// module nsgAssociations './modules/nsg-association.bicep' = [for subnet in subnetModules: {
//   name: '${subnet.name}-nsg-association'
//   params: {
//     subnetId: subnet.outputs.subnetId
//     nsgId: nsg.outputs.nsgId
//   }
// }]
