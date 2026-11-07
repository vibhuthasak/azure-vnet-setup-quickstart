targetScope = 'subscription'

import { subnetType } from './modules/networking/vnet.bicep'

@description('Azure region for all resources. Defaults to the --location given to the deployment.')
param location string = deployment().location

@description('Resource group the network resources are deployed into. Created if it does not exist.')
param networkRGName string = 'rg-network'

param vnetName string = 'myVnet'

@minLength(1)
param addressSpaces string[]

@minLength(1)
param subnets subnetType[]

param nsgName string = 'myNsg'

@description('Your public IP in CIDR form (e.g. 203.0.113.10/32) to allow SSH from. Leave empty for no SSH rule.')
param sshSourceIp string = ''

resource networkRG 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: networkRGName
  location: location
}

module nsgModule './modules/networking/nsg.bicep' = {
  name: 'nsg-${uniqueString(deployment().name)}'
  scope: networkRG
  params: {
    nsgName: nsgName
    location: location
    sshSourceIp: sshSourceIp
  }
}

module vnetModule './modules/networking/vnet.bicep' = {
  name: 'vnet-${uniqueString(deployment().name)}'
  scope: networkRG
  params: {
    vnetName: vnetName
    location: location
    addressSpaces: addressSpaces
    subnets: subnets
    nsgId: nsgModule.outputs.nsgId
  }
}

output networkRGName string = networkRG.name
output vnetId string = vnetModule.outputs.vnetId
output subnetIds array = vnetModule.outputs.subnetIds
output nsgId string = nsgModule.outputs.nsgId
