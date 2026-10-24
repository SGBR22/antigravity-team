# ⚡ Antigravity Multi-Agent Ecosystem Setup & Terminal Guide (v2.7.0)

<div align="center">

**English Guide** • **[Русская версия](SETUP_GUIDE_RU.md)** • **[Main README](README.md)**

</div>

---

## 🚀 1. Cross-Platform Terminal Installation

### 🐧 Option A: Linux & macOS Terminal (Recommended)

#### Method 1: Remote 1-Liner (curl / wget)
Run this command in any terminal (Bash, Zsh):
```bash
curl -fsSL https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.sh | bash
```
Or with `wget`:
```bash
wget -qO- https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.sh | bash
```

#### Method 2: Local Installation (Git Clone or ZIP)
```bash
git clone https://github.com/SGBR22/antigravity-team.git
cd antigravity-team
chmod +x install-team.sh
./install-team.sh
```

*What the Linux installer does automatically:*
1. Installs plugin files to `~/.gemini/config/plugins/antigravity-team`.
2. Registers and enables `"antigravity-team": true` in `~/.gemini/antigravity/config.json` (using a 3-tier Python $\to$ jq $\to$ bash fallback).
3. Verifies Python 3 and prompts to install cross-platform dependencies (`pytest`, `mypy`, `pydantic`, `numpy`, `scipy`, `sympy`, `matplotlib`, `trimesh`, `pint`, `uncertainties`, `MPh`).
4. Avoids Windows-only libraries like `pywin32`.

---

### 🪟 Option B: Windows PowerShell

#### Method 1: Remote 1-Liner
Open PowerShell and run:
```powershell
irm https://raw.githubusercontent.com/SGBR22/antigravity-team/main/install.ps1 | iex
```

#### Method 2: Local Installation
```powershell
git clone https://github.com/SGBR22/antigravity-team.git
cd antigravity-team
powershell -ExecutionPolicy Bypass -File .\install-team.ps1
```
*(Or double-click `install.bat`)*

---

## 📦 2. Terminal Prerequisites & Toolchains

### Python 3 & Virtual Environments (Linux)
It is recommended to run engineering workloads with Python 3.10+:
```bash
# Ubuntu / Debian
sudo apt update && sudo apt install -y python3 python3-pip python3-venv git unzip

# Fedora / RHEL
sudo dnf install -y python3 python3-pip git unzip

# Arch Linux
sudo pacman -S python python-pip git unzip
```

If you prefer a dedicated virtual environment for Antigravity tools:
```bash
python3 -m venv ~/.venv/antigravity
source ~/.venv/antigravity/bin/activate
pip install --upgrade pytest mypy pydantic numpy scipy sympy matplotlib trimesh pint uncertainties MPh
```

### Typst (For Technical & Scientific Reports)
The `typst-reporter` subagent compiles publication-ready PDF documents via Typst:
- **Precompiled Binary** (fastest):
  ```bash
  curl -fsSL https://github.com/typst/typst/releases/latest/download/typst-x86_64-unknown-linux-musl.tar.xz | tar -xJ --strip-components=1 -C /usr/local/bin typst-x86_64-unknown-linux-musl/typst
  ```
- **Cargo**:
  ```bash
  cargo install --locked typst-cli
  ```
- **Arch Linux**:
  ```bash
  sudo pacman -S typst
  ```

---

## 🔍 3. Verification in Terminal

After running the installer, verify that the plugin is properly registered:

### On Linux:
```bash
# 1. Verify plugin directory exists:
ls -la ~/.gemini/config/plugins/antigravity-team

# 2. Check plugin activation in config.json:
grep -A 5 "antigravity-team" ~/.gemini/antigravity/config.json
```
Expected output:
```json
"plugins": {
  "enabled": {
    "antigravity-team": true
  }
}
```

### On Windows:
```powershell
Test-Path "$HOME\.gemini\config\plugins\antigravity-team"
Get-Content "$HOME\.gemini\antigravity\config.json"
```

Restart your Google Antigravity application or terminal session. All 10 subagents and 15 skills are now immediately accessible.

---

## 🚨 4. Mandatory Auto-Dispatch Protocol

You do not need to manually summon subagents. The orchestrator routes your intent automatically:

```text
User Request
     │
     ▼
[system-architect] ──▶ Designs DAG, Data Contracts & DoD
     │
     ▼
[coordinator]      ──▶ Concurrent Fan-Out (Speculative Pipelining)
     │
     ├──▶ [senior-dev]       (Backend Code & TDD)
     ├──▶ [visual-designer]  (Visuals, SVGs & UI)
     ├──▶ [science-compute]  (COMSOL, FEMM, Metrology)
     ├──▶ [cad-specialist]   (Blender bpy & 3D Print)
     ├──▶ [typst-reporter]   (Publication PDF)
     └──▶ [researcher]       (Empirical Research Loop)
     │
     ▼ Zero-Lag Join
[code-reviewer]    ──▶ Adversarial QA & DoD Verification
     │
     ▼
Final User Deliverable
```

---

## 👥 5. Subagents Reference (10 Roles)

| Subagent | Role | Primary Capabilities |
| :--- | :--- | :--- |
| **`coordinator`** | Central Dispatcher | Task DAG decomposition, multi-agent synchronization, zero-lag join. |
| **`senior-dev`** | Systems Engineer | Python/TypeScript/Rust backends, CLI tools, Clean Code, automated TDD. |
| **`code-reviewer`** | QA Gate & Verifier | 6-point code audit, memory leak checks, verification against DoD. |
| **`researcher`** | Autonomous Researcher | Karpathy autoresearch loop, headless probe scripts, metric extraction. |
| **`system-architect`** | Lead Architect | Everything Claude Code (ECC) architecture, modular contracts, ADRs. |
| **`science-compute`** | Math & Physics | High-voltage bushing simulations, COMSOL MPh, FEMM, GUM metrology. |
| **`cad-specialist`** | CAD & 3D Specialist | Blender `bpy` scripting, Kompas-3D pywin32 (Win), FDM/SLA slicer checks. |
| **`typst-reporter`** | Document Authority | Typst typesetting, GOST 7.32 papers, CeTZ vector graphics. |
| **`visual-designer`** | Visual Design & UI | Craft UI modern aesthetic, vector SVGs, dashboards, component styling. |
| **`web-surfer`** | Web Researcher | Live standard lookup (GOST, IEC, ISO), official API documentation. |

---

## 🛠️ 6. Progressive Skills Reference (15 Skills)

1. **`autoresearch`**: Autonomous empirical loop (Hypothesis $\to$ Headless Probe $\to$ Metrics).
2. **`system-architecture`**: Modular boundaries and ECC Architectural Decision Records (ADR).
3. **`token-budget-optimizer`**: Active Token Shield and Karpathy "Think in Code" context governance.
4. **`test-driven-development`**: Test-driven development lifecycle (Red-Green-Refactor).
5. **`systematic-debugging`**: Scientific root-cause debugging with the Halt-at-2 rule.
6. **`code-refactoring-and-architecture`**: Cognitive complexity reduction and dead-code elimination.
7. **`craft-ui-engineering`**: Anti-AI modern design systems, fluid layouts, and zero-lag data contracts.
8. **`git-workflow-and-commits`**: Conventional Commits 1.0 specification and atomic branch hygiene.
9. **`hv-bushing-calc`**: Electrophysical calculation for bushings in COMSOL and FEMM.
10. **`metrology-lab-data`**: Statistical experimental data processing per GOST 8.207.
11. **`uncertainty-and-units`**: Physical unit tracking and GUM uncertainty propagation.
12. **`kompas-3d-automation`**: Kompas-3D automation via pywin32 API 5/7 (Windows).
13. **`blender-bpy-modeling`**: Headless procedural geometry scripting in Blender (`bpy`).
14. **`three-d-printing-preflight`**: Mesh inspection and mechanical fit tolerances for 3D printing.
15. **`typst-report`**: Formal report authoring in Typst with native CeTZ figures.

---

## ❓ 7. Troubleshooting & FAQ

### Q: Does `install.sh` require root/sudo?
**A:** No. `install.sh` operates entirely in your user directory (`$HOME/.gemini`). Only optional system package installations (`apt`, `pacman`) require `sudo`.

### Q: How do I package the plugin on Linux to send to a friend?
**A:** Run `bash export-team.sh`. It automatically creates `antigravity-team-portable.zip` in your current directory.
