using './main.bicep'

param vnetName = 'prod-vnet-1'

param addressSpaces = [
  '172.30.0.0/24'
  '192.168.1.0/24'
]

param nsgName = 'prod-nsg-1'

param subnets = [
  {
    prefix: '172.30.0.0/25'
  }
  {
    prefix: '172.30.0.128/25'
  }
  {
    prefix: '192.168.1.0/25'
  }
  {
    prefix: '192.168.1.128/25'
  }
]

param networkRGName = 'rg-network-prod'
