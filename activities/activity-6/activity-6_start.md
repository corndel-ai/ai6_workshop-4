# Activity 6: Adding Parameters

**Primary KSB:** S16 (Transition prototypes into the live environment)

---

## 🎯 Learning Objective

Parameterise the secure template to enable deployment across dev/test/live environments

---

## 📖 Why Parameterise?

Right now, your `main_secure.bicep` has hard-coded values. This works for ONE environment, but what about dev → test → live?

📖 Learn more about enviroments in the Microsoft Azure Cloud Adption Framework: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/considerations/environments

**Problem with hard-coding:**
```bicep
name: 'secure${uniqueString(resourceGroup().id)}'  // Same name everywhere!
```

**Better approach:**
```bicep
@allowed(['dev', 'test', 'live', 'prod'])
param env string = 'dev'
name: 'safe${env}${uniqueString(resourceGroup().id)}'  // safedev..., safetest..., safelive...
```

📊 **See the concept:** [Parameterisation Diagram](../../diagrams/ascii_diagrams.md#5-parameterisation-concept-for-activity-6)

💡 **Why `@allowed()`?** Azure storage account names must be 3-24 characters. The `@allowed()` decorator restricts env to short values (dev/test/live/prod) so the name stays under the limit - and it's self-documenting!

---

## 🔐 Security Invariants vs. Environment Variables

**NEVER parameterise security properties:**
- 🔐 `allowBlobPublicAccess: false` - Security invariant (always false!)
- 🔐 `minimumTlsVersion: 'TLS1_2'` - Security invariant (always TLS1_2!)

**DO parameterise environment-specific values:**
- ✅ `env` (dev/test/live)
- ✅ `location` (eastus/westus)
- ✅ `owner` (team name)

---

## 📝 Task 1: Add Parameters

### Step 1: Open Your Template

⌨️ **Run:**

```bash
code main_secure.bicep
```

---

### Step 2: Add Parameters at the Top

At the **very top** of the file, add:

```bicep
// Parameters for environment-specific values
@allowed(['dev', 'test', 'live', 'prod'])
param env string = 'dev'
param location string = resourceGroup().location
param owner string = 'ml-engineering-team'
```

---

### Step 3: Update Storage Account Name

Change:
```bicep
name: 'secure${uniqueString(resourceGroup().id)}'
```

To:
```bicep
name: 'safe${env}${uniqueString(resourceGroup().id)}'
```

📖 **Note:** `${expr}` inside a quoted string denotes **string interpolation** and evaluates `expr`, injecting its value at that position. Commonly used with parameters, variables, functions, and resource properties to build names, tags, or other string fields.

String interpolation is used *twice* in the code above. Can you spot the expressions that are being evaluated?


---

### Step 4: Use the location Parameter

Change:
```bicep
location: resourceGroup().location
```

To:
```bicep
location: location
```

---

### Step 5: Add Governance Tags

After `kind: 'StorageV2'`, add:

```bicep
tags: {
  environment: env
  owner: owner
  costCentre: 'ml-eng'
  managedBy: 'IaC'
}
```

---

### Step 6: Update Container Name

Change:
```bicep
name: 'raw-secure'
```

To:
```bicep
name: 'raw-${env}'
```

Now you have environment-aware containers: `raw-dev`, `raw-test`, `raw-live`

---

### Step 7: Add Outputs

At the **bottom** of the file, add:

```bicep
output storageAccountName string = secureStorage.name
output containerName string = rawSecure.name
output environment string = env
```

Outputs help verify what was deployed.

---

### Step 8: Save the File

✅ **Save**: Ctrl+S (Cmd+S on Mac)


---

## ✅ Checkpoint: Your Parameterised Template

Your complete template should now look like:

```bicep
@allowed(['dev', 'test', 'live', 'prod'])
param env string = 'dev'
param location string = resourceGroup().location
param owner string = 'ml-engineering-team'

resource secureStorage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'safe${env}${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  tags: {
    environment: env
    owner: owner
    costCentre: 'ml-eng'
    managedBy: 'IaC'
  }

  properties: {
    allowBlobPublicAccess: false      // 🔐 Never parameterise!
    minimumTlsVersion: 'TLS1_2'       // 🔐 Never parameterise!
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: secureStorage
  name: 'default'
}

resource rawSecure 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: blobService
  name: 'raw-${env}'
  properties: {
    publicAccess: 'None'              // 🔐 Never parameterise!
  }
}

output storageAccountName string = secureStorage.name
output containerName string = rawSecure.name
output environment string = env
```

---

## 🤔 Reflection

**Why not parameterise security properties?**

If you made `allowBlobPublicAccess` a parameter, someone could deploy:

```bash
az deployment group create --template-file main_secure.bicep --parameters allowBlobPublicAccess=true
```

And you're back to insecure! Security properties should be **locked** in code.

---

## 🔗 Next Steps

Now your template can deploy to any environment with different names, but always secure!

Move to [Activity 7: Staging Gate (what-if)](../activity-7/activity-7_start.md) to validate before deploying.
