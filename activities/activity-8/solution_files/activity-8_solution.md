# Activity 8: Secure Deployment - SOLUTION

---

## ✅ Complete Deployment Commands

```bash
# Deploy secure template
az deployment group create \
  --resource-group $rg \
  --template-file main_secure.bicep \
  --parameters env=dev \
  --name secure-deployment
```

**Expected success output:**
```json
{
  ...
  "provisioningState": "Succeeded",
  "outputs": {
    "storageAccountName": {
      "type": "String",
      "value": "safedevg4k7m9x2pq3s"
    },
    "containerName": {
      "type": "String",
      "value": "raw-dev"
    },
    "environment": {
      "type": "String",
      "value": "dev"
    }
  }
}
```

---

## ✅ Verification Commands

### Compare Legacy vs Secure

```bash
# Legacy (insecure)
az storage account show \
  --name $(az storage account list -g $rg --query "[?starts_with(name, 'legacy')].name" -o tsv) \
  --resource-group $rg \
  --query "{TLS:minimumTlsVersion, PublicAccess:allowBlobPublicAccess}" \
  --output table

# Output:
# TLS     PublicAccess
# ------  --------------
# TLS1_0  True           ❌ INSECURE

# Secure (fixed)
az storage account show \
  --name $(az storage account list -g $rg --query "[?starts_with(name, 'safe')].name" -o tsv) \
  --resource-group $rg \
  --query "{TLS:minimumTlsVersion, PublicAccess:allowBlobPublicAccess}" \
  --output table

# Output:
# TLS     PublicAccess
# ------  --------------
# TLS1_2  False          ✅ SECURE
```

---

## 📊 Before and After

| Property | Legacy | Secure |
|----------|--------|--------|
| **allowBlobPublicAccess** | true ❌ | false ✅ |
| **minimumTlsVersion** | TLS1_0 ❌ | TLS1_2 ✅ |
| **Container publicAccess** | Blob ❌ | None ✅ |
| **Tags** | None | 3 governance tags ✅ |

---

## 🤔 Reflection

**Think about:**
- Why did we deploy the NEW secure storage before removing the OLD insecure one?
- **Answer:** Fix-forward pattern - minimise downtime, ensure new system works before removing old

---


## 🔗 Next Activity

Move to [Activity 9: Governance Handoff](../activity-9/activity-9_start.md)
