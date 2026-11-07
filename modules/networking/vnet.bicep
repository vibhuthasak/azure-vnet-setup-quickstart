@export()
@description('A subnet to create inside the virtual network.')
type subnetType = {
  @description('Subnet name, e.g. snet-app.')
  name: string

  @description('Subnet address prefix in CIDR notation. Must fall inside one of the VNet address spaces.')
  prefix: string
}

param vnetName string
param location string

@minLength(1)
param addressSpaces string[]

@minLength(1)
param subnets subnetType[]

@description('Resource ID of the NSG to associate with every subnet.')
param nsgId string

// Subnets are declared inline (not as separate child resources) so that
// redeploying the VNet does not try to remove them.
resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressSpaces
    }
    subnets: [
      for subnet in subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.prefix
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: {
            id: nsgId
          }
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output vnetName string = vnet.name
output subnetIds array = [for (subnet, i) in subnets: vnet.properties.subnets[i].id]
