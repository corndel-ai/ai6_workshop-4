# Activity 1: Legacy Audit

**Primary KSB:** S8 (Assess system vulnerabilities and mitigate the threats or risks to assets, data and cyber security)

---

## 🎯 Learning Objective

Identify at least three specific security vulnerabilities in a legacy cloud storage configuration

---

## 📖 The Scenario

Welcome to your first day as an ML engineer! You've been asked to audit the "raw data landing zone" - the cloud storage where external vendors drop data files before they enter your ML pipeline.

The previous developer, Sam, left three weeks ago. Sam built this using "ClickOps" (clicking through the Azure Portal) and left behind:
- A working storage account
- A script for data scientists to access files
- No documentation
- A note: "It works, don't touch it!"

Your manager needs you to identify security vulnerabilities before this system handles sensitive data.

👉 **First, read the full scenario:** [Project Legacy](../../user_brief.md)

---

## 📊 The Legacy Architecture

Below is a diagram showing what Sam built. Your task is to spot the security problems (they are quite well flagged!).

```ascii
╔════════════════════════════════════════════════════════════════════╗
║      The "Legacy" Architecture (Flawed Diagram)                    ║
╠════════════════════════════════════════════════════════════════════╣
║                                                                    ║
║   ┌─────────────┐                                                 ║
║   │   Internet  │  HTTPS (TLS 1.0)                                 ║
║   │  External   │ ─────────────────┐                              ║
║   │   Vendor    │                  │                              ║
║   └─────────────┘                  ▼                              ║
║                           ┌─────────────────┐                     ║
║                           │  Public Storage │                     ║
║                           │   Container     │                     ║
║  ╔═══════════════════════╗│                 │                     ║
║  ║ Vulnerability #1:     ║│  📁 raw-insecure│                     ║
║  ║ Public Access Enabled ║│                 │                     ║
║  ║ Anyone with the URL   ║└─────────────────┘                     ║
║  ║ can read files        ║         │                              ║
║  ╚═══════════════════════╝         │                              ║
║                                    ▼                              ║
║  ╔═══════════════════════╗  ┌─────────────┐                      ║
║  ║ Vulnerability #3:     ║  │   Script    │                      ║
║  ║ Weak Encryption       ║  │  (contains  │                      ║
║  ║ TLS 1.0 Deprecated    ║  │  hardcoded  │                      ║
║  ║ Susceptible to attack ║  │ SAS token)  │                      ║
║  ╚═══════════════════════╝  └─────────────┘                      ║
║                                    │                              ║
║  ╔═══════════════════════╗         │                              ║
║  ║ Vulnerability #2:     ║         ▼                              ║
║  ║ Hardcoded "God Mode"  ║  ┌─────────────┐                      ║
║  ║ Token                 ║  │ Downstream  │                      ║
║  ║ Broad permissions:    ║  │  Consumer   │                      ║
║  ║ read, add, create,    ║  │ (Data Sci,  │                      ║
║  ║ write, delete, list,  ║  │   ML, ETL)  │                      ║
║  ║ immutable             ║  └─────────────┘                      ║
║  ║ Expires: 2099         ║                                        ║
║  ╚═══════════════════════╝                                        ║
║                                                                    ║
║  ⚠️  Result: Anyone with the script has admin-level access         ║
║  ⚠️  No audit trail of who accessed what                           ║
║  ⚠️  Token can't be rotated without updating all scripts           ║
╚════════════════════════════════════════════════════════════════════╝
```

💡 **Tip:** You can find all workshop diagrams in [diagrams/ascii_diagrams.md](../../diagrams/ascii_diagrams.md)

---

## 📝 Task 1: Guided Vulnerability Discovery

Study the diagram above and answer these three questions. Write your answers in your notes or in a new draft file called `SECURITY_AUDIT.md`.

### 🔍 Question 1: Data Exposure
**Where do you see possible data exposure in this architecture?**

---

### 🔍 Question 2: Access Controls
**What tells you this might be publicly accessible?**

---

### 🔍 Question 3: Credential Management
**What looks risky in the way access is granted?**

---

## 📝 Task 2: Document Your Findings

Format your draft `SECURITY_AUDIT.md` using the template below and fill it out:

```markdown
# Security Audit: Raw Data Landing Zone

## High-Level Context
[Write 1-2 sentences about what this system does]

## Vulnerabilities Identified

### Vulnerability 1: [Title]
**Location:** [Where in the architecture]
**Risk:** [What could go wrong]
**Severity:** [High/Medium/Low]

### Vulnerability 2: [Title]
**Location:** [Where in the architecture]
**Risk:** [What could go wrong]
**Severity:** [High/Medium/Low]

### Vulnerability 3: [Title]
**Location:** [Where in the architecture]
**Risk:** [What could go wrong]
**Severity:** [High/Medium/Low]

## Recommendations
[What should be done to fix these issues]
```

⚠️ **Focus on the landing zone only** - don't worry about the full ML pipeline downstream. This is an optional going further activity at the end of the workshop. We're auditing the storage layer.

---

## ✅ Checkpoint

Before moving to Activity 2, make sure you have:

- [ ] Identified **at least 3 vulnerabilities** from the diagram
- [ ] Written specific locations for each vulnerability (not vague statements)
- [ ] Explained the **risk** of each vulnerability (what could go wrong)
- [ ] Created a `SECURITY_AUDIT.md` file with your findings

**Remember:** This activity is about **identifying** vulnerabilities. In [Activity 2](../activity-2/activity-2_start.md), you'll deploy them (to understand what you're fixing), and in Activity 4, you'll fix them properly.
