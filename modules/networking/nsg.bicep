param nsgName string
param location string

@description('Public IP (CIDR, e.g. 203.0.113.10/32) allowed to SSH in. Leave empty to create no SSH rule.')
param sshSourceIp string = ''

// Rules are declared inline (not as separate child resources) so that
// redeploying the NSG does not remove them.
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: empty(sshSourceIp)
      ? []
      : [
          {
            name: 'allowSSHInbound'
            properties: {
              access: 'Allow'
              direction: 'Inbound'
              priority: 100
              protocol: 'Tcp'
              destinationPortRange: '22'
              destinationAddressPrefix: '*'
              sourceAddressPrefix: sshSourceIp
              sourcePortRange: '*'
            }
          }
        ]
  }
}

output nsgId string = nsg.id
