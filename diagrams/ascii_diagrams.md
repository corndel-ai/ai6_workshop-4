# Workshop 4 ASCII Diagrams

This file contains all ASCII art diagrams used throughout the workshop. Copy-paste them into your notes or activity materials as needed.

---

## 1. The Legacy Architecture (Flawed Diagram)

**Usage:** Activity 1 (vulnerability spotting)

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

---

## 2. The Two-Lane Teaching Model

**Usage:** Activity 3 (introduce explicitly) and Activity 4 (reinforce)

```ascii
╔═══════════════════════════════════════════════════════════════════╗
║             The "Two-Lane" Teaching Model                         ║
╠═══════════════════════════════════════════════════════════════════╣
║                                                                   ║
║  Stage 1: Morning – "The Audit" (Reactive & Insecure)            ║
║  ┌───────────────────────────────────────────────────────────┐   ║
║  │                                                           │   ║
║  │  ☁️  Messy Manual     Introspection     Discovery        │   ║
║  │  Cloud Environment  ──────(SSH)────────> (Messy JSON)    │   ║
║  │                                                           │   ║
║  │  🔓 Public Access   🔓 SAS Keys        🔍 "What's wrong?"│   ║
║  └───────────────────────────────────────────────────────────┘   ║
║                           │                                       ║
║                           ▼                                       ║
║  Stage 2: Afternoon – "The Refactor" (Proactive & Standards)     ║
║  ┌───────────────────────────────────────────────────────────┐   ║
║  │                                                           │   ║
║  │   Refactor          Secure        ✅ Promote &    Golden  │   ║
║  │   (K13)          ───Baseline────> ✅ Govern    ──> Template│   ║
║  │   Clean Code        (Clean IaC)   (S16, B4)    Secure,   │   ║
║  │                                                 Governed,  │   ║
║  │                                                 Prod-ready │   ║
║  └───────────────────────────────────────────────────────────┘   ║
║                                                                   ║
║                      Workshop Focus                               ║
║                           │                                       ║
║         ┌─────────────────┴────────────────────┐                 ║
║         ▼                                      ▼                 ║
║  Lane 1: Patch Export           Lane 2: Refactor to Standard     ║
║  ┌──────────────────┐            ┌──────────────────────┐        ║
║  │ Quick Fix        │            │ Sustainable Fix      │        ║
║  │ ─────────        │            │ ───────────────      │        ║
║  │ • Export JSON    │            │ • Study export       │        ║
║  │ • Fix bad bits   │            │ • Build clean        │        ║
║  │ • Redeploy       │            │   baseline           │        ║
║  │                  │            │ • Parameterise       │        ║
║  │ ✅ Fast           │            │ • Validate (what-if) │        ║
║  │ ❌ Brittle        │            │ • Deploy             │        ║
║  │ ❌ Metadata noise │            │                      │        ║
║  │ ❌ Not repeatable │            │ ✅ Repeatable         │        ║
║  │                  │            │ ✅ Reviewable         │        ║
║  │ Use when:        │            │ ✅ Standards-based    │        ║
║  │ • Emergency      │            │                      │        ║
║  │ • Prod is down   │            │ Use when:            │        ║
║  │ • Then fix       │            │ • Always (default)   │        ║
║  │   properly later │            │ • Promotion to live  │        ║
║  └──────────────────┘            └──────────────────────┘        ║
║                                                                   ║
║  🚗 This workshop teaches Lane 2 (with Lane 1 awareness)          ║
╚═══════════════════════════════════════════════════════════════════╝
```

---

## 3. Secure Data Flow (Target Architecture)

**Usage:** Activity 5 (sketch checkpoint) and Activity 9 (HANDOFF.md)

```ascii
┌─────────────────────────────────────────────────────────────────┐
│               Secure Data Flow (Target Architecture)            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓   │
│  ┃            Identity Boundary                            ┃   │
│  ┃        (Azure AD + RBAC Enforced)                       ┃   │
│  ┃                                                          ┃   │
│  ┃  ┌──────────────┐         ╔════════════════════╗        ┃   │
│  ┃  │  External    │         ║  Secure Raw Zone   ║        ┃   │
│  ┃  │  Data Source │ ───────>║  (Storage Account) ║ ─────> ┃   │
│  ┃  │              │  Upload ║                    ║ Read   ┃   │
│  ┃  │ Producers:   │  via    ║  Container:        ║ via    ┃   │
│  ┃  │ • Vendors    │  Azure  ║  raw-<env>         ║ Azure  ┃   │
│  ┃  │ • Partners   │   AD/   ║  (e.g. raw-dev)    ║  AD/   ┃   │
│  ┃  │ • Upstream   │  RBAC   ║                    ║ RBAC   ┃   │
│  ┃  │   Systems    │         ║  Properties:       ║        ┃   │
│  ┃  └──────────────┘         ║  ─────────────     ║  ┌───────┐ ┃
│  ┃                           ║  ✅ TLS 1.2 Only    ║  │Down-  │ ┃
│  ┃  Request access via:      ║  ✅ No Public       ║  │stream │ ┃
│  ┃  • Platform team          ║     Access         ║  │       │ ┃
│  ┃  • RBAC role assigned     ║  ✅ RBAC Only       ║  │Consume│ ┃
│  ┃  • No tokens shared       ║  ✅ Tagged          ║  │• Data │ ┃
│  ┃                           ║     (env, owner,   ║  │  Sci  │ ┃
│  ┃                           ║      costCentre)   ║  │• ETL  │ ┃
│  ┃                           ╚════════════════════╝  │• ML   │ ┃
│  ┃                                                   └───────┘ ┃
│  ┃                                                              ┃
│  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
│                                                                 │
│  Key Security Properties:                                      │
│  ────────────────────────                                      │
│  🔐 Access controlled by Azure AD + RBAC (not tokens/keys)     │
│  🔐 Public access disabled at account and container level      │
│  🔐 TLS 1.2 enforced for all connections                       │
│  🔐 All access auditable via Azure logs                        │
│  🔐 Credentials managed centrally (can be revoked instantly)   │
│                                                                 │
│  Deployment Pattern:                                           │
│  ──────────────────                                            │
│  • IaC template (main_secure.bicep)                            │
│  • Parameterised for dev/test/live                             │
│  • what-if validation before changes                           │
│  • Governance via tags and RBAC roles                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## 4. Wrong Example (For Comparison in Activity 5)

**Usage:** Activity 5 (show as anti-pattern)

```ascii
┌──────────────────────────────────────────────────────────────────┐
│           ❌ WRONG: Insecure Data Flow (Don't Do This!)           │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐                                               │
│  │  External    │  Public URL + SAS Token                       │
│  │  Data Source │ ────────────────────┐                         │
│  └──────────────┘                     ▼                         │
│                            ┌──────────────────┐                 │
│  ❌ MISTAKE #1:             │  Raw Zone        │                 │
│  Public endpoint           │  (Storage)       │                 │
│  Anyone with URL           │                  │  SAS Token      │
│  can access                │  ❌ Public Access │ ────────┐       │
│                            │  ❌ TLS 1.0       │         ▼       │
│  ❌ MISTAKE #2:             │  ❌ SAS Tokens    │  ┌──────────┐  │
│  No identity               └──────────────────┘  │Consumer  │  │
│  boundary                                        │          │  │
│                                                  └──────────┘  │
│  ❌ MISTAKE #3:                                                  │
│  Hardcoded                                                     │
│  credentials                                                   │
│  in scripts                                                    │
│                                                                  │
│  Why this is wrong:                                            │
│  • No audit trail                                              │
│  • Can't revoke access easily                                 │
│  • Tokens in git history forever                              │
│  • Public data exposure risk                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 5. Parameterisation Concept (for Activity 6)

**Usage:** Activity 6 (introduce parameterisation concept)

```ascii
┌────────────────────────────────────────────────────────────────┐
│         Why Parameterise? (One Template → All Environments)    │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  ❌ BAD: Copy-Paste Approach                                   │
│  ────────────────────────                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐        │
│  │ main_dev.bic │  │ main_test.bi │  │ main_live.bi │        │
│  │              │  │              │  │              │        │
│  │ name: safe   │  │ name: safe   │  │ name: safe   │        │
│  │   dev...     │  │   test...    │  │   live...    │        │
│  │              │  │              │  │              │        │
│  │ TLS: 1.2     │  │ TLS: 1.2     │  │ TLS: 1.0     │← Oops! │
│  └──────────────┘  └──────────────┘  └──────────────┘        │
│                                                 ↑              │
│                                         Copy-paste error!      │
│                                                                │
│  ✅ GOOD: Parameterised Approach                               │
│  ───────────────────────────                                   │
│  ┌────────────────────────────────────┐                       │
│  │     main_secure.bicep              │                       │
│  │                                    │                       │
│  │  param env string = 'dev'          │← Parameter            │
│  │                                    │                       │
│  │  name: 'safe${env}...'             │← Uses parameter       │
│  │  TLS: '1.2'                        │← Locked (no param)    │
│  └────────────────────────────────────┘                       │
│              │           │           │                        │
│              ▼           ▼           ▼                        │
│         Deploy       Deploy      Deploy                      │
│      --param env=dev  env=test  env=live                     │
│              │           │           │                        │
│              ▼           ▼           ▼                        │
│      safedev...    safetest...  safelive...                  │
│      (TLS 1.2)     (TLS 1.2)    (TLS 1.2)  ← ✅ All secure!  │
│                                                                │
│  Benefits:                                                     │
│  • One file to maintain ✅                                      │
│  • Security fix once, applies everywhere ✅                     │
│  • No copy-paste errors ✅                                      │
│  • Reviewable and auditable ✅                                  │
└────────────────────────────────────────────────────────────────┘
```

---

## 6. what-if as a Safety Gate (for Activity 7)

**Usage:** Activity 7 (explain what-if concept)

```ascii
┌──────────────────────────────────────────────────────────────────┐
│       what-if: The Safety Gate Before Production                │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Standard Deployment (Without what-if):                         │
│  ─────────────────────────────────────                          │
│  Developer                                                       │
│      │                                                           │
│      │ Makes change to template                                 │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────┐                                                     │
│  │ Deploy  │                                                     │
│  │ Command │ ──────────────────> ❌ Oops! Deleted production DB  │
│  └─────────┘                     Too late to undo!              │
│                                                                  │
│                                                                  │
│  Safe Deployment (With what-if):                                │
│  ────────────────────────────                                   │
│  Developer                                                       │
│      │                                                           │
│      │ Makes change to template                                 │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────┐                                                     │
│  │ what-if │ ──────> Preview:                                   │
│  │ Command │         ─────────                                  │
│  └─────────┘         + Create safedev...                        │
│      │               ~ Modify TLS: 1.0 → 1.2                    │
│      │               - Delete productionDB  ← ⚠️ Wait, what?    │
│      │                                                           │
│      │ ❌ STOP! That delete is wrong!                            │
│      │                                                           │
│      ▼                                                           │
│  Fix template, re-run what-if                                   │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────┐                                                     │
│  │ what-if │ ──────> Preview:                                   │
│  │ Command │         ─────────                                  │
│  └─────────┘         + Create safedev...                        │
│      │               ~ Modify TLS: 1.0 → 1.2                    │
│      │               ✅ No unexpected deletes                     │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────┐                                                     │
│  │ Deploy  │ ──────> ✅ Safe deployment                          │
│  │ Command │                                                     │
│  └─────────┘                                                     │
│                                                                  │
│  Key Point: what-if is a "dry run" - shows changes without      │
│  actually making them. Like git diff before git push.           │
└──────────────────────────────────────────────────────────────────┘
```

---

## 7. Fix-Forward Pattern (for Activity 8)

**Usage:** Activity 8 (explain deployment pattern)

```ascii
┌──────────────────────────────────────────────────────────────────┐
│             Fix-Forward vs Patch-In-Place                        │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ❌ RISKY: Patch-In-Place                                        │
│  ────────────────────────                                        │
│  ┌─────────────┐                                                │
│  │  Legacy     │  Modify properties                             │
│  │  Storage    │ ──────────────> ⚠️ What if it fails halfway?   │
│  │  (insecure) │                  ⚠️ Production is DOWN          │
│  └─────────────┘                                                │
│       │                                                          │
│       │ (If successful)                                         │
│       ▼                                                          │
│  ┌─────────────┐                                                │
│  │  Legacy     │                                                │
│  │  Storage    │  Now secure (maybe)                            │
│  │  (secure?)  │                                                │
│  └─────────────┘                                                │
│                                                                  │
│                                                                  │
│  ✅ SAFE: Fix-Forward                                             │
│  ────────────────────                                            │
│  ┌─────────────┐                                                │
│  │  Legacy     │                                                │
│  │  Storage    │  Still serving traffic                         │
│  │  (insecure) │                                                │
│  └─────────────┘                                                │
│       │                                                          │
│       │ (Still works while we build new)                        │
│       │                                                          │
│  ┌────┴────┐                                                    │
│  │  Deploy │                                                    │
│  │   New   │  ──────────────> ┌─────────────┐                  │
│  │ Secure  │                  │   NEW       │                  │
│  │Template │                  │  Secure     │  ✅ Verified      │
│  └─────────┘                  │  Storage    │  ✅ Tested        │
│                               └─────────────┘                  │
│                                      │                          │
│                                      │ (Once verified...)       │
│                                      ▼                          │
│                            ┌──────────────────┐                │
│                            │ Remove insecure  │                │
│                            │ container from   │                │
│                            │ legacy storage   │                │
│                            └──────────────────┘                │
│                                      │                          │
│                                      ▼                          │
│  ┌─────────────┐              ┌─────────────┐                  │
│  │  Legacy     │              │   NEW       │                  │
│  │  Storage    │              │  Secure     │                  │
│  │ (cleaned)   │              │  Storage    │ ← Production     │
│  └─────────────┘              └─────────────┘    traffic here  │
│                                                                  │
│  Key Principle: Build new, verify it works, THEN remove old     │
│  "New bridge built before old bridge closed"                    │
└──────────────────────────────────────────────────────────────────┘
```

---

**End of ASCII Diagrams File**

These diagrams are designed to work in monospace fonts and should render correctly in:
- Markdown viewers
- Code editors (VS Code, Cloud Shell Editor)
- Terminal windows
- GitHub README files

If a diagram doesn't render correctly, check that your viewer is using a monospace font and has sufficient width (at least 80 characters).
