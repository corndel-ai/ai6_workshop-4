# Activity 4: Secure Rewrite (Phase 1)

**Primary KSBs:** K13 (Data and information security standards, ethical practices, policies and procedures relevant to data management activities such as data lineage, data retention and metadata management), S8 (Assess system vulnerabilities and mitigate the threats or risks to assets, data and cyber security), S16 (setup)

---

## 🎯 Learning Objective

Create a clean, secure Bicep template that addresses all identified vulnerabilities

---

## 🚗 Lane 2: Building a Clean Baseline

**What we've done so far:**
- ✅ Identified vulnerabilities (Activity 1)
- ✅ Deployed the insecure system (Activity 2)
- ✅ Exported and inspected it (Activity 3)

**What we're doing now:**
Building a *new*, clean template that represents how this *should* be configured.

**Why not just edit `current_state.bicep`?**
Exported templates are full of Azure's internal metadata - provisioning states, endpoints, timestamps. It's like trying to edit a compiled binary instead of source code.

**Lane 2 approach:** Write the source code (template) that produces the secure result.

**Phase 1 focus:** Security only (no parameters yet - that's Activity 6)

📊 **Review the two-lane diagram:** [Two-Lane Teaching Model](../../diagrams/ascii_diagrams.md#2-the-two-lane-teaching-model)

---

## 📖 The Secure Template Structure

A secure storage template needs **three resources**:

1. **Storage Account** - The main resource
   - Security properties: `allowBlobPublicAccess: false`, `minimumTlsVersion: 'TLS1_2'`
   - Modern type: `kind: 'StorageV2'`

2. **Blob Service** - Container hosting service (child of storage account)
   - Usually just uses defaults

3. **Container** - Where files are stored (child of blob service)
   - Security property: `publicAccess: 'None'`

---

## 📝 Task 1: Create Your Secure Template

You'll use a starter template with TODOs that guide you through building the secure version.

### Step 1: Copy the text in the Starter Template

⌨️ **Copy the text from here in the workshop repo:**

[main_secure_starter.bicep](../../templates/main_secure_starter.bicep)

---

### Step 2: Open the File

⌨️ **Run:**

```bash
code main_secure.bicep
```

Paste in the template with its TODOs and hints.

---

### Step 3: Complete the TODOs

Follow the TODOs in the file. The key fixes are:

#### TODO #6: Block Public Access

Replace the comment:
```bicep
// allowBlobPublicAccess: false
```

With:
```bicep
allowBlobPublicAccess: false
```

#### TODO #7: Enforce TLS 1.2

Replace the comment:
```bicep
// minimumTlsVersion: 'TLS1_2'
```

With:
```bicep
minimumTlsVersion: 'TLS1_2'
```

---

#### TODO #8: Uncomment Blob Service

Uncomment this entire block:
```bicep
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: secureStorage
  name: 'default'
}
```

---

#### TODO #9-10: Uncomment Secure Container

Uncomment this entire block:
```bicep
resource rawSecure 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: blobService
  name: 'raw-secure'
  properties: {
    publicAccess: 'None'
  }
}
```

---

### Step 4: Save the File

✅ **Save**: Ctrl+S (Cmd+S on Mac)

---

## 📝 Task 2: Compare Against Legacy

Let's see exactly what changed.

⌨️ **View your files:**

```bash
code legacy.bicep
code main_secure.bicep
```

### Key Differences

| Property | Legacy ❌ | Secure ✅ |
|----------|----------|----------|
| **allowBlobPublicAccess** | true | false |
| **minimumTlsVersion** | 'TLS1_0' | 'TLS1_2' |
| **Container publicAccess** | 'Blob' | 'None' |

---

## ✅ Checkpoint: Verify Your Template

Before moving on, make sure your `main_secure.bicep` contains:

```bicep
resource secureStorage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'secure${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'

  properties: {
    allowBlobPublicAccess: false   // ✅ FIX #1
    minimumTlsVersion: 'TLS1_2'    // ✅ FIX #2
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: secureStorage
  name: 'default'
}

resource rawSecure 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: blobService
  name: 'raw-secure'
  properties: {
    publicAccess: 'None'  // ✅ FIX #3
  }
}
```

⚠️ **Don't deploy yet!** We'll add parameters in Activity 6 and validate with `what-if` in Activity 7.

---

## 🤔 Reflection

**Think about:**
- How many lines is your secure template? (~30-40 lines)
- How many lines was the exported `current_state.bicep`? (~500+ lines)
- Which is easier to understand and review?

**Answer:** Clean templates are **10x more maintainable** than exported ones!

---

## ✅ What You've Accomplished

- [ ] Created `main_secure.bicep` with three resources
- [ ] Applied all three security fixes
- [ ] Used modern `StorageV2` type
- [ ] Understood the difference between Lane 1 (patch) and Lane 2 (refactor)

---

## 🔗 Next Steps

🎓 **Well done!** You've built a secure baseline template.

Before deploying, let's do a quick design checkpoint.

Move to [Activity 5: Pipeline Sketch](../activity-5/activity-5_start.md)

---

## 🚀 Extension Challenge (Optional)

Try adding comments explaining WHY each security property matters:

```bicep
properties: {
  // Blocks anonymous public access - forces authentication
  allowBlobPublicAccess: false

  // TLS 1.2 protects against BEAST, POODLE attacks (TLS 1.0 is deprecated)
  minimumTlsVersion: 'TLS1_2'
}
```
