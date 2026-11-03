// LEGACY INGESTION CONFIGURATION (SIMULATION)
// This file deliberately contains insecure defaults to simulate
// inheriting a legacy system built via ClickOps.
//
// ⚠️ DO NOT use this pattern in real projects!

resource legacyStorage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  // Unique name to avoid conflicts
  name: 'legacy${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  
  // StorageV2 is required for deployment in the current Azure environment.
  // The insecure properties below intentionally simulate the inherited
  // configuration of a legacy system.
  kind: 'StorageV2'

  properties: {
    // ❌ VULNERABILITY 1: Public access enabled
    allowBlobPublicAccess: true

    // ❌ VULNERABILITY 2: Weak TLS version
    minimumTlsVersion: 'TLS1_0'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: legacyStorage
  name: 'default'
}

resource insecureContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: blobService
  name: 'raw-insecure'
  properties: {
    // ❌ VULNERABILITY 3: Public blob access
    publicAccess: 'Blob'
  }
}

/*
❌ VULNERABILITY 4: HARDCODED SAS TOKEN (simulation)
In the real legacy system, this token was embedded in scripts:
?sv=2021-06-08&ss=b&srt=sco&sp=racwdli&se=2099-12-31T23:59:59Z...

This represents a token with:
- Broad permissions (read, add, create, write, delete, list, immutable)
- Far-future expiry (2099)
- Cannot be easily rotated

In this workshop, we don't actually generate this token, but we acknowledge
it existed in the legacy setup.
*/
