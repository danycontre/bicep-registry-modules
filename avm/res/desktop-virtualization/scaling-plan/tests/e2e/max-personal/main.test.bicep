targetScope = 'subscription'

metadata name = 'Using large parameter set'
metadata description = 'This instance deploys the module with most of its features enabled.'

@description('Optional. The name of the resource group to deploy for testing purposes.')
@maxLength(90)
param resourceGroupName string = 'dep-${namePrefix}-desktopvirtualization.scalingplans-${serviceShort}-rg'

@description('Optional. The location to deploy resources to.')
param resourceLocation string = deployment().location

@description('Optional. A short identifier for the kind of deployment. Should be kept short to not run into resource-name length-constraints.')
param serviceShort string = 'dvspmax'

@description('Optional. A token to inject into the name of each resource. This value can be automatically injected by the CI.')
param namePrefix string = '#_namePrefix_#'

// ============ //
// Dependencies //
// ============ //

// General resources
// =================

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceLocation
}

module nestedDependencies 'dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-nestedDependencies'
  params: {
    location: resourceLocation
    managedIdentityName: 'dep-${namePrefix}-msi-${serviceShort}'
  }
}

// Diagnostics
// ===========

module diagnosticDependencies '../../../../../../utilities/e2e-template-assets/templates/diagnostic.dependencies.bicep' = {
  scope: resourceGroup
  name: '${uniqueString(deployment().name, resourceLocation)}-diagnosticDependencies'
  params: {
    storageAccountName: 'dep${namePrefix}diasa${serviceShort}03'
    logAnalyticsWorkspaceName: 'dep-${namePrefix}-law-${serviceShort}'
    eventHubNamespaceEventHubName: 'dep-${namePrefix}-evh-${serviceShort}01'
    eventHubNamespaceName: 'dep-${namePrefix}-evhns-${serviceShort}01'
    location: resourceLocation
  }
}

// ============== //
// Test Execution //
// ============== //

@batchSize(1)
module testDeployment '../../../main.bicep' = [
  for iteration in ['init', 'idem']: {
    scope: resourceGroup
    name: '${uniqueString(deployment().name, resourceLocation)}-test-per-${serviceShort}-${iteration}'
    params: {
      name: '${namePrefix}${serviceShort}003'
      location: resourceLocation
      friendlyName: 'friendlyName'
      description: 'myDescription'
      schedules: [
        {
          daysOfWeek: [
            'Monday'
            'Wednesday'
            'Thursday'
            'Friday'
          ]
          name: 'WeekdaySchedule'
          offPeakStartTime: {
            hour: 20
            minute: 0
          }
          offPeakStartVMOnConnect: 'Enable'
          offPeakMinutesToWaitOnDisconnect: 30
          offPeakActionOnDisconnect: 'Hibernate'
          offPeakMinutesToWaitOnLogoff: 0
          offPeakActionOnLogoff: 'Deallocate'
          peakStartTime: {
            hour: 9
            minute: 0
          }
          peakStartVMOnConnect: 'Enable'
          peakMinutesToWaitOnDisconnect: 30
          peakActionOnDisconnect: 'Hibernate'
          peakMinutesToWaitOnLogoff: 0
          peakActionOnLogoff: 'Deallocate'
          rampDownStartTime: {
            hour: 18
            minute: 0
          }
          rampDownStartVMOnConnect: 'Enable'
          rampDownMinutesToWaitOnDisconnect: 30
          rampDownActionOnDisconnect: 'Hibernate'
          rampDownMinutesToWaitOnLogoff: 0
          rampDownActionOnLogoff: 'Deallocate'
          rampUpStartTime: {
            hour: 7
            minute: 0
          }
          rampUpAutoStartHosts: 'WithAssignedUser'
          rampUpStartVMOnConnect: 'Enable'
          rampUpMinutesToWaitOnDisconnect: 30
          rampUpActionOnDisconnect: 'Hibernate'
          rampUpMinutesToWaitOnLogoff: 0
          rampUpActionOnLogoff: 'Deallocate'
        }
        {
          daysOfWeek: [
            'Tuesday'
          ]
          name: 'weekdaysSchedule-agent-updates'
          offPeakStartTime: {
            hour: 20
            minute: 0
          }
          offPeakStartVMOnConnect: 'Enable'
          offPeakMinutesToWaitOnDisconnect: 30
          offPeakActionOnDisconnect: 'Hibernate'
          offPeakMinutesToWaitOnLogoff: 0
          offPeakActionOnLogoff: 'Deallocate'
          peakStartTime: {
            hour: 9
            minute: 0
          }
          peakStartVMOnConnect: 'Enable'
          peakMinutesToWaitOnDisconnect: 30
          peakActionOnDisconnect: 'Hibernate'
          peakMinutesToWaitOnLogoff: 0
          peakActionOnLogoff: 'Deallocate'
          rampDownStartTime: {
            hour: 18
            minute: 0
          }
          rampDownStartVMOnConnect: 'Enable'
          rampDownMinutesToWaitOnDisconnect: 30
          rampDownActionOnDisconnect: 'Hibernate'
          rampDownMinutesToWaitOnLogoff: 0
          rampDownActionOnLogoff: 'Deallocate'
          rampUpStartTime: {
            hour: 7
            minute: 0
          }
          rampUpAutoStartHosts: 'WithAssignedUser'
          rampUpStartVMOnConnect: 'Enable'
          rampUpMinutesToWaitOnDisconnect: 30
          rampUpActionOnDisconnect: 'Hibernate'
          rampUpMinutesToWaitOnLogoff: 0
          rampUpActionOnLogoff: 'Deallocate'
        }
        {
          daysOfWeek: [
            'Saturday'
            'Sunday'
          ]
          name: 'WeekendSchedule'
          offPeakStartTime: {
            hour: 18
            minute: 0
          }
          offPeakStartVMOnConnect: 'Enable'
          offPeakMinutesToWaitOnDisconnect: 30
          offPeakActionOnDisconnect: 'Hibernate'
          offPeakMinutesToWaitOnLogoff: 0
          offPeakActionOnLogoff: 'Deallocate'
          peakStartTime: {
            hour: 10
            minute: 0
          }
          peakStartVMOnConnect: 'Enable'
          peakMinutesToWaitOnDisconnect: 30
          peakActionOnDisconnect: 'Hibernate'
          peakMinutesToWaitOnLogoff: 0
          peakActionOnLogoff: 'Deallocate'
          rampDownStartTime: {
            hour: 16
            minute: 0
          }
          rampDownStartVMOnConnect: 'Enable'
          rampDownMinutesToWaitOnDisconnect: 30
          rampDownActionOnDisconnect: 'Hibernate'
          rampDownMinutesToWaitOnLogoff: 0
          rampDownActionOnLogoff: 'Deallocate'
          rampUpStartTime: {
            hour: 9
            minute: 0
          }
          rampUpAutoStartHosts: 'None'
          rampUpStartVMOnConnect: 'Enable'
          rampUpMinutesToWaitOnDisconnect: 30
          rampUpActionOnDisconnect: 'Hibernate'
          rampUpMinutesToWaitOnLogoff: 0
          rampUpActionOnLogoff: 'Deallocate'
        }
      ]
      hostPoolReferences: [
        {
          hostPoolArmPath: nestedDependencies.outputs.hostPoolId
          scalingPlanEnabled: true
        }
      ]
      diagnosticSettings: [
        {
          name: 'customSetting'
          logCategoriesAndGroups: [
            {
              categoryGroup: 'allLogs'
            }
          ]
          eventHubName: diagnosticDependencies.outputs.eventHubNamespaceEventHubName
          eventHubAuthorizationRuleResourceId: diagnosticDependencies.outputs.eventHubAuthorizationRuleId
          storageAccountResourceId: diagnosticDependencies.outputs.storageAccountResourceId
          workspaceResourceId: diagnosticDependencies.outputs.logAnalyticsWorkspaceResourceId
        }
      ]
      lock: {
        kind: 'CanNotDelete'
        name: 'myCustomLockName'
      }
      roleAssignments: [
        {
          roleDefinitionIdOrName: 'Owner'
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
        {
          roleDefinitionIdOrName: 'b24988ac-6180-42a0-ab88-20f7382dd24c'
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
        {
          roleDefinitionIdOrName: subscriptionResourceId(
            'Microsoft.Authorization/roleDefinitions',
            'acdd72a7-3385-48ef-bd42-f606fba81ae7'
          )
          principalId: nestedDependencies.outputs.managedIdentityPrincipalId
          principalType: 'ServicePrincipal'
        }
      ]
      tags: {
        'hidden-title': 'This is visible in the resource name'
        Environment: 'Non-Prod'
        Role: 'DeploymentValidation'
      }
    }
  }
]
