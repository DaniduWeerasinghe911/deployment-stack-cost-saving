resource bastion 'Microsoft.Network/bastionHosts@2021-08-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
  }
  properties: {
    disableCopyPaste: disableCopyPaste
    dnsName: dnsName
    enableFileCopy: enableFileCopy
    enableIpConnect: enableIpConnect
    enableShareableLink: enableShareableLink
    enableTunneling: enableTunneling
    scaleUnits: scaleUnits
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
