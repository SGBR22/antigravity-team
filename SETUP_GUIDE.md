# ⚡ Antigravity Multi-Agent Ecosystem Setup & Usage Guide (v2.5)

<div align="center">

**English Guide** • **[Русская версия](SETUP_GUIDE_RU.md)**

</div>

---

## 🚀 3-Step Installation & Activation

### Step 1. Clone the Repository
Open PowerShell and run:
```bash
git clone https://github.com/SGBR22/antigravity-team.git
cd antigravity-team
```

### Step 2. Run the 1-Click Installer
```powershell
powershell -ExecutionPolicy Bypass -File .\install-team.ps1
```
*The installer automatically:*
1. Copies all plugin files to the global directory: `~/.gemini/config/plugins/antigravity-team`.
2. Registers and activates the plugin in `~/.gemini/antigravity/config.json`.
3. Verifies Python and prompts to install dependencies: `MPh`, `pytest`, `pint`, `uncertainties`, `pywin32`, `numpy`, `scipy`.

### Step 3. Restart Google Antigravity
Restart the Google Antigravity application. All 10 subagents and 14 progressive skills are now globally available across all your workspaces.

---

## 🚨 Mandatory Auto-Dispatch Protocol

You no longer need to remember exact subagent names or manually summon them. The orchestrator automatically routes tasks:
- **Code implementation / bug fixes** $\to$ `senior-dev`
- **Security audit / code review** $\to$ `code-reviewer`
- **Autonomous research / library benchmarks** $\to$ `researcher`
- **System architecture / modular contracts** $\to$ `system-architect`
- **COMSOL / FEMM / metrology** $\to$ `science-compute`
- **Kompas-3D / Blender / 3D printing** $\to$ `cad-specialist`
- **Formal reports (GOST 7.32 / Typst)** $\to$ `typst-reporter`
- **Visual diagrams & dashboards** $\to$ `visual-designer`

---

## 👥 Subagents Reference (10 Roles)

| Subagent | Primary Capabilities |
| :--- | :--- |
| **`coordinator`** | Task decomposition, dependency tracking, multi-agent synthesis. |
| **`senior-dev`** | Clean, idiomatic, pragmatic code, unit testing, TDD. |
| **`code-reviewer`** | Adversarial 6-point QA audit (logic, leaks, edge cases). |
| **`researcher`** | Autonomous Karpathy & Hermes empirical research with headless probes. |
| **`system-architect`** | ECC modular system design, prompt hygiene, interface contracts, ADRs. |
| **`science-compute`** | COMSOL Multiphysics MPh, FEMM, HV bushing design, GUM metrology. |
| **`cad-specialist`** | Kompas-3D pywin32 API 5/7, Blender bpy procedural modeling, 3D printing. |
| **`typst-reporter`** | Scientific documentation via Typst, GOST 7.32, CeTZ vector graphics. |
| **`visual-designer`** | Reactive Generative UI widgets, Mermaid architectural diagrams. |
| **`web-surfer`** | Precision search for official standards, docs, and schemas. |

---

## 🛠️ Progressive Skills Reference (14 Skills)

1. **`autoresearch`**: Autonomous empirical loop (Hypothesis $\to$ Probe $\to$ Metrics $\to$ Synthesis).
2. **`system-architecture`**: Modular boundaries and ECC Architectural Decision Records (ADR).
3. **`token-budget-optimizer`**: Context optimization and "Think in Code" token governance.
4. **`test-driven-development`**: Test-driven development across Python, TypeScript, Rust, and C++.
5. **`systematic-debugging`**: Scientific root-cause debugging with the Halt-at-2 rule.
6. **`code-refactoring-and-architecture`**: Practical Clean Code and dead-code elimination.
7. **`git-workflow-and-commits`**: Conventional Commits 1.0 specification and branch hygiene.
8. **`hv-bushing-calc`**: Electrophysical calculation for bushings in COMSOL and FEMM.
9. **`metrology-lab-data`**: Statistical experimental data processing per GOST 8.207.
10. **`uncertainty-and-units`**: Physical unit tracking and GUM uncertainty propagation.
11. **`kompas-3d-automation`**: Kompas-3D automation via pywin32 API 5/7.
12. **`blender-bpy-modeling`**: Headless procedural geometry scripting in Blender (`bpy`).
13. **`three-d-printing-preflight`**: Mesh inspection and mechanical fit tolerances for 3D printing.
14. **`typst-report`**: Formal report authoring in Typst with native CeTZ figures.
