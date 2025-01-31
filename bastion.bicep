@description('is deploy resources')
param deployResources bool = true

@description('Subnet resource id')
param subnetResourceId string = '/subscriptions/57965064-8041-486f-80e8-2763ac0adbd9/resourceGroups/dckloud-network-rg/providers/Microsoft.Network/virtualNetworks/vnet/subnets/AzureBastionSubnet'


resource publicIp 'Microsoft.Network/publicIPAddresses@2022-01-01' = if(deployResources) {
  name: 'bastionPublicIp'
  location: 'australiaeast'
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}


resource bastion 'Microsoft.Network/bastionHosts@2021-08-01' = if(deployResources){
  name: 'dckloud-bastion'
  location: 'australiaeast'
  tags: {}
  sku: {
    name: 'Basic'
  }
  properties: {
    scaleUnits: 2
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: subnetResourceId
          }
        }
      }
    ]
  }
}
