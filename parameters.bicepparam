using './main.bicep'

param networkRGName = 'rg-network-prod'

param vnetName = 'prod-vnet-1'

param addressSpaces = [
  '172.30.0.0/24'
  '192.168.1.0/24'
]

param subnets = [
  {
    name: 'subnet-1'
    prefix: '172.30.0.0/25'
  }
  {
    name: 'subnet-2'
    prefix: '172.30.0.128/25'
  }
  {
    name: 'subnet-3'
    prefix: '192.168.1.0/25'
  }
  {
    name: 'subnet-4'
    prefix: '192.168.1.128/25'
  }
]

param nsgName = 'prod-nsg-1'

// Set to your public IP (e.g. '203.0.113.10/32') to open SSH from it only.
param sshSourceIp = ''
