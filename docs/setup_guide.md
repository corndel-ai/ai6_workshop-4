# Workshop 4 Setup Guide

## 🖥️ Choose Your Environment

This workshop supports two environments. Choose ONE:

### 🌐 Option 1: Azure Cloud Shell (Browser-Based)
**Best for:** Quick start, no local setup needed
- ✅ Pre-authenticated with Azure
- ✅ No CLI installation required
- ✅ Built-in editor
- ✅ Automatic storage provisioning

👉 **Go to:** [Cloud Shell Setup](#cloud-shell-setup)

### 💻 Option 2: GitHub Codespaces (VS Code)
**Best for:** Full VS Code environment
- ✅ Full VS Code editor with extensions
- ✅ Persistent workspace
- ⚠️ Requires Azure CLI installation
- ⚠️ Requires manual `az login`

👉 **Go to:** [Codespaces Setup](#codespaces-setup)

---

## 🔐 Understanding Azure CLI Authentication

Azure CLI offers **four authentication methods**, each suited for different scenarios:

### 🎓 **What We Use in This Workshop**

1. **🌐 Azure Cloud Shell** (Option 1) - Automatically authenticated
   - Perfect for learning and getting started quickly
   - No manual login required
   - Pre-configured with your Azure credentials

2. **🔑 Interactive Login** (Option 2) - Using `az login`
   - Great for local development and learning
   - Browser-based authentication with your Azure account
   - Provides subscription selector for easy setup

### 🏢 **Production Methods** (Not Used Here)

3. **🤖 Managed Identity** - For applications running in Azure
   - Used when your app needs to access Azure resources securely
   - No secrets to manage - Azure handles authentication automatically
   - Common in production deployments (VMs, App Services, Functions)

4. **⚙️ Service Principal** - For automation and CI/CD pipelines
   - Recommended for scripts, GitHub Actions, Azure DevOps pipelines
   - Provides precise permission control
   - Used in real-world automation scenarios

💡 **Why these choices?** Cloud Shell and interactive login are ideal for **learning and hands-on workshops** because they're fast to set up and don't require managing credentials. In real projects, you'd use managed identities for apps and service principals for automation pipelines.

📖 **Learn more:** [Azure CLI Authentication Methods](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli)

---

## Cloud Shell Setup

### 🎯 Pre-Workshop Checklist

Before starting Activity 1, ensure you have:

- [ ] Access to Pluralsight Sandbox
- [ ] Azure Cloud Shell working
- [ ] Resource group and region variables set

---

### Step 1: Access Pluralsight Sandbox

### Login to Azure Portal

1. Start an Azure Cloud sandbox (just the normal cloud sandbox, not an AI one)
<img width="1067" height="337" alt="S1W4-Cloud_Sandbox" src="https://github.com/user-attachments/assets/9142ce30-e710-4d20-9d31-251b196340c2" />
<img width="1782" height="797" alt="S2W4-Azure_Sandbox" src="https://github.com/user-attachments/assets/7148175f-927e-4214-a8ee-f7e4407cc136" />

2. Ensure you're not signed in to a Microsoft account in your private browsing window already. If you are, close all private browsing windowe before you proceed.

3. Click on the "Start Sandbox" button and wait for the sandbox to be ready to open.
<img width="871" height="612" alt="S3W4-StartSandbox" src="https://github.com/user-attachments/assets/782b934b-ebcd-45dc-946a-2eb04a618140" />

4. Once the sandbox is ready, right click on the "Open Sandbox" button and open in a private window (or equivalent in your browser).
<img width="864" height="618" alt="S4W4-OpenSandbox" src="https://github.com/user-attachments/assets/dc3403eb-5ec4-4340-8782-ba9ebece2d7a" />

5. Login with your Pluralsight sandbox credentials
<img width="1883" height="999" alt="S5W4-LoginUsername" src="https://github.com/user-attachments/assets/7a686c24-d180-4d3e-ac9b-d070122a6637" />
<img width="1877" height="991" alt="S6W4-LoginPassword" src="https://github.com/user-attachments/assets/ece41471-882e-422b-96c1-14a793d8b9c1" />

6. Verify you see the Azure Portal dashboard
<img width="1890" height="968" alt="S7W4-AzureDashboardRunning" src="https://github.com/user-attachments/assets/418d6ead-2497-4a32-a47e-922935a6f77a" />


✅ **Checkpoint:** You can see your resource group name in the top-left hand corner (looks like "1-xxxxxxxx-playground-sandbox"), with "Resource group" beneath it.

---

### Launch Cloud Shell

1. Click the **Cloud Shell icon** (>_) in the top-right toolbar
<img width="1905" height="71" alt="S8W4-CloudShellToolbar" src="https://github.com/user-attachments/assets/8fe7391b-70ba-4ace-b4c4-602622d71f82" />

2. Select **Bash** if prompted
<img width="1156" height="891" alt="S9W4-BashSelection" src="https://github.com/user-attachments/assets/02312934-50aa-4b3b-8902-95a1e061942c" />

3. Select "Mount storage account"
4. Select the one storage account subscription available in the drop-down (will look like "Px-Real Hands-On Labs")
5. Click "Apply"
<img width="780" height="302" alt="S10W4-SubscriptionConfig" src="https://github.com/user-attachments/assets/232184e0-e129-4b54-82ab-dbdb2ba7a2d8" />

6. Select "I want to create a storage account" and click "Next"
<img width="593" height="267" alt="S11W4-MountStorageAccount" src="https://github.com/user-attachments/assets/6cb3d7c2-b1cb-4a4c-8c1e-c05565e0913f" />

7. Select the one available resource group under "Resource group" (which should have the same name as that in the top-left corner of the dashboard)
8. Select the region that matches the "Location" in the dashboard (look in the middle of the screen under "Essentials"), which is often (but not always) "East US". For example, the screenshot shows "West US".
9. Provide a "Storage account name" and "File share". These can be whatever you want, but make them easy to identify e.g. `cloudaccount` and `cloudfiles`, respectively.
10. Click "Create"
<img width="1281" height="767" alt="S12W4-CreateStorageAccount" src="https://github.com/user-attachments/assets/cb45afbe-2082-4f72-b60f-9f58387b5350" />

11. Wait for Cloud Shell to initialise (~30 seconds)
<img width="599" height="268" alt="S13W4-WaitingCloudShellConfig" src="https://github.com/user-attachments/assets/1b9320d2-e829-49ce-9aa5-c6afb0758977" />
<img width="1086" height="227" alt="S14W4-CloudShellInitialised" src="https://github.com/user-attachments/assets/99728895-5df9-46f6-aa8c-c3b7e0c0abc4" />

---

## Step 2: Verify Environment

### Check Resource Group

⌨️ **Run:**

```bash
az group list --output table
```
<img width="478" height="287" alt="S15W4-azgrouplist" src="https://github.com/user-attachments/assets/7cd41517-d3d0-46a0-a0ab-ba30ddad0b09" />

✅ **Checkpoint:** You should see one resource group like `1-e58d5f37-playground-sandbox`

---

### Set Resource Group Variable

⌨️ **Run:**

```bash
export rg=$(az group list --query "[0].name" -o tsv)
echo $rg
```
<img width="547" height="59" alt="S16W4-echoresourcegroup" src="https://github.com/user-attachments/assets/5191aa9a-6589-4a52-86b5-42277afb2eb7" />

✅ **Checkpoint:** You see your resource group name printed

**Add to your shell profile** (so it persists):

```bash
echo "export rg=$(az group list --query "[0].name" -o tsv)" >> ~/.bashrc
```
<img width="685" height="43" alt="S17W4-persist" src="https://github.com/user-attachments/assets/d7cebabe-1a9b-46b2-9244-90862300a0f0" />

---

### Verify Region

⌨️ **Run:**

```bash
az group show --name $rg --query location -o tsv
```
<img width="503" height="39" alt="S18W4-Verifyregion" src="https://github.com/user-attachments/assets/bcc00c71-259d-408a-8ca0-97f161f790be" />

✅ **Checkpoint:** You should see a us region such as `eastus` or `westus`

---

## Step 3: Install/Verify Tools

### Check Azure CLI

⌨️ **Run:**

```bash
az version
```
<img width="284" height="190" alt="S19W4-checkAzureCLI" src="https://github.com/user-attachments/assets/61702546-e15b-4221-8f9e-6084329cb6d7" />

✅ **Checkpoint:** You should see Azure CLI version 2.79+ already installed in Cloud Shell

---

## Codespaces Setup

⚠️ You do **not** need to complete Codespaces Setup if you've already completed the above steps for Cloud Shell. Move on to the [Both Environments: Final Checks](#both-environments-final-checks) section below.

### 🎯 Pre-Workshop Checklist

Before starting Activity 1, ensure you have:

- [ ] GitHub account
- [ ] Access to GitHub Classroom link (provided by your coach)
- [ ] Forked repository via GitHub Classroom
- [ ] Codespace created and running
- [ ] Azure CLI installed in Codespace
- [ ] Authenticated with `az login`
- [ ] Resource group and region variables set

---

### Step 1: Fork Repository via GitHub Classroom

⚠️ **Important:** You'll receive a GitHub Classroom link separately from your coach.

1. Click the GitHub Classroom link provided by your coach
2. Accept the assignment
3. GitHub will automatically fork the repository for you
4. Wait for the repository to be created (~10 seconds)

✅ **Checkpoint:** You have your own forked repository

---

### Step 2: Open in Codespaces

1. Navigate to your forked repository on GitHub
2. Click the green **Code** button
3. Select the **Codespaces** tab
4. Click **Create codespace on main**
5. Wait for Codespace to build (~2-3 minutes on first launch)

✅ **Checkpoint:** VS Code opens in your browser with the workshop files

---

### Step 3: Install Azure CLI

⚠️ **Note:** If Azure CLI installation doesn't work (e.g. if you don't have permission doing this locally) you can fall back to Cloud Shell - that's totally acceptable!

📖 **Reference:** [Microsoft Docs - Install Azure CLI on Linux](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest&pivots=apt#option-1-install-with-one-command)

⌨️ **In the Codespace terminal, run:**

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

⏱️ **This takes 2-3 minutes** - you'll see installation progress

✅ **Checkpoint:** Verify installation:

```bash
az version
```

You should see Azure CLI version 2.30+ installed

---

### Step 4: Authenticate with Azure

⌨️ **Run:**

```bash
az login
```

This will:
1. Open a browser window
2. Ask you to sign in with your Pluralsight sandbox credentials
3. Return authentication confirmation

✅ **Checkpoint:** You should see JSON output listing your subscriptions

---

### Step 5: Set Resource Group Variable

⌨️ **Run:**

```bash
export rg=$(az group list --query "[0].name" -o tsv)
echo $rg
```

✅ **Checkpoint:** You see your resource group name printed (e.g., `1-e58d5f37-playground-sandbox`)

⌨️ **Set region variable:**

```bash
export LOCATION=$(az group show --name $rg --query location -o tsv)
echo "Region: $LOCATION"
```

✅ **Checkpoint:** You see your region (commonly `eastus` or `southcentralus`)

---

### Step 6: Verify Working Directory

⚠️ **Important:** Make sure you're in the correct folder for workshop activities.

⌨️ **Check current directory:**

```bash
pwd
```

✅ **Expected:** Should show `/workspaces/ai6_workshop-4` (or similar)

If not, navigate to the workshop root:

```bash
cd /workspaces/ai6_workshop-4
```

---

## Both Environments: Final Checks

Regardless of which environment you chose, verify these work:

### Check Bicep CLI

⌨️ **Run:**

```bash
az bicep install
```

Then check it's installed successfully with:

```bash
az bicep version
```
<img width="636" height="116" alt="S20W4-FinalEnvironmentChecks" src="https://github.com/user-attachments/assets/82fae775-76c3-489b-a243-50a60ef44e07" />

✅ **Checkpoint:** You see Bicep CLI version (0.20.0 or newer)

---

### Final Confirmation

⌨️ **Run:**

```bash
echo "Resource Group: $rg"
echo "Ready for workshop!"
```
<img width="377" height="74" alt="S21W4-ReadyEchos" src="https://github.com/user-attachments/assets/059fb812-c973-4d03-b5d7-61be9a8f1fb5" />

✅ **Checkpoint:** You see your resource group name

---

## 🎉 You're Ready!

You've successfully set up your environment. You can now start with [Activity 1](../activities/activity-1/activity-1_start.md).

---

## Additional Resources

- [Azure Cloud Shell Documentation](https://learn.microsoft.com/en-us/azure/cloud-shell/overview)
- [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/)
- [Bicep Documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
