targetScope = 'subscription'

@description('The location of the resource group.')
param location string = 'australiaeast'


@description('is deploy resources')
param deployResources bool = true

//location shortname
@description('location shortname')
param nestedLocationShortName string = 'aus'

@description('environment shortname')
param nestedEnvironmentShortName string = 'prod'

@description('company shortname')
param nestedCompanyShortName string = 'dckloud'

@description('Sample app setting value')
param tempValue string = 'testingValue'

var workloadShortName = 'wkl'

var resourceGroupName  = '${nestedCompanyShortName}-${nestedEnvironmentShortName}-${nestedLocationShortName}-${workloadShortName}-rg'
var appSeviceName = '${nestedCompanyShortName}-${nestedEnvironmentShortName}-${nestedLocationShortName}-${workloadShortName}-as'
var appSevicePlanName = '${nestedCompanyShortName}-${nestedEnvironmentShortName}-${nestedLocationShortName}-${workloadShortName}-asp'
var keyvaultName = '${nestedCompanyShortName}-${nestedEnvironmentShortName}-${nestedLocationShortName}-${workloadShortName}-kv'
var storageAccountName = '${nestedCompanyShortName}${nestedEnvironmentShortName}${nestedLocationShortName}${workloadShortName}sa'


//deploying Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: location
}

module keyvault 'br/public:avm/res/key-vault/vault:0.12.1' = {
  scope: rg
  name:'deploying_keyvault'
  params: {
    name: keyvaultName
    location: location
  }
}

module storage 'br/public:avm/res/storage/storage-account:0.19.0' = {
  scope: rg
  name:'deploying_storage'
  params: {
    name: storageAccountName
    location:location
     accessTier: 'Hot'
    kind: 'StorageV2'
  }
}

module appServicePlan 'module/web/app-service-plan/app-service-plan.bicep' = if((deployResources)) {
  scope: rg
  name : 'deploying_app_service_plan'
  params: {
    appKind: 'windows'
    appPlanName: appSevicePlanName
    skuCapacity: 1
    skuName: 'P1'
  }
}

module appService 'module/web/app/app-windows.bicep' =if((deployResources))  {
  scope: rg
  name: 'deploying_app_service'
  params: {
    tempValue: tempValue
    appName: appSeviceName
    serverFarmId: appServicePlan.outputs.appServiceID
  }
}
