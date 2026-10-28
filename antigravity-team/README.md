# ⚡ Antigravity Multi-Agent Ecosystem (`antigravity-team` v2.9.0)

A modular, production-grade multi-agent ecosystem and token-saving engine designed specifically for Google Antigravity. Incorporates cutting-edge paradigms from **Andrej Karpathy's autoresearch workflows**, **OpenSpec Spec-Driven Development (SDD)**, **ECC (Everything Claude Code)** modular architecture, **Craft UI Engineering**, and **NousResearch Hermes agent scratchpads**.

---

## 👥 15 Specialized Subagents

| Subagent | File | Model | Primary Capabilities |
| :--- | :--- | :--- | :--- |
| **`coordinator`** | `agents/coordinator.md` | `inherit` | Request decomposition, work graphs, execution plans, parallel agent dispatching. |
| **`senior-dev`** | `agents/senior-dev.md` | `inherit` | Server-side & systems engineering, backend APIs, CLI tools, algorithm implementations. |
| **`frontend-dev`** | `agents/frontend-dev.md` | `inherit` | Client-side logic, React/Vue/Next.js, state management (Zustand/Query), API integration, forms. |
| **`test-engineer`** | `agents/test-engineer.md` | `inherit` | Automated QA engineering, TDD Red-phase test suites (Pytest/Vitest), mocks, property-based testing. |
| **`database-engineer`** | `agents/database-engineer.md` | `inherit` | DB schema normalization, zero-downtime migrations (Alembic/Prisma), query profiling (EXPLAIN ANALYZE). |
| **`sysadmin`** | `agents/sysadmin.md` | `inherit` | Cross-platform administration: Windows (PowerShell/Services/WSL) & Linux (systemd/networks), Docker. |
| **`github-specialist`** | `agents/github-specialist.md` | `inherit` | GitHub ecosystem: `gh` CLI, PRs, Issues, Releases, GitHub Actions CI/CD workflows, repo governance. |
| **`code-reviewer`** | `agents/code-reviewer.md` | `inherit` | Adversarial code review, QA audit, resource/memory leak detection, OpenSpec DoD verification. |
| **`researcher`** | `agents/researcher.md` | `inherit` | Karpathy & Hermes empirical research, headless benchmark probes, rapid exploration. |
| **`system-architect`** | `agents/system-architect.md` | `inherit` | ECC-style modular architecture, OpenSpec proposals & specs, prompt hygiene, ADRs. |
| **`science-compute`** | `agents/science-compute.md` | `inherit` | COMSOL Multiphysics via MPh, FEMM, HV bushing electrophysics, GUM metrology. |
| **`cad-specialist`** | `agents/cad-specialist.md` | `inherit` | Kompas-3D pywin32 API 5/7, Blender bpy procedural modeling, 3D printing preflight. |
| **`typst-reporter`** | `agents/typst-reporter.md` | `inherit` | Publication-ready scientific/technical reports via Typst & `modern-g7-32` (ГОСТ 7.32). |
| **`visual-designer`** | `agents/visual-designer.md` | `inherit` | Exclusive visual styling & UI authority: adaptive non-AI modern design, showcases, UI/UX, Mermaid diagrams. |
| **`web-surfer`** | `agents/web-surfer.md` | `inherit` | Targeted web search, official documentation scraping, source attribution. |

---

## 🚨 Mandatory Auto-Dispatch Protocol

In accordance with `rules/AGENTS.md`, the primary Antigravity orchestrator must automatically delegate domain tasks to subagents via `invoke_subagent`:
- **Backend implementation & algorithms** $\to$ `senior-dev`
- **Frontend application & client state** $\to$ `frontend-dev`
- **Automated test suites & TDD** $\to$ `test-engineer`
- **Database schemas & migrations** $\to$ `database-engineer`
- **Windows / Linux / Docker administration** $\to$ `sysadmin`
- **GitHub CLI / Actions CI/CD / PRs / Releases** $\to$ `github-specialist`
- **Security / code review & DoD audit** $\to$ `code-reviewer`
- **System architecture & OpenSpec proposals** $\to$ `system-architect`
- **Empirical research & exploration** $\to$ `researcher`
- **Physical modeling & metrology** $\to$ `science-compute`
- **CAD & 3D printing** $\to$ `cad-specialist`
- **Formal reports (GOST / Typst)** $\to$ `typst-reporter`
- **Visual styling / UI / Showcases / Diagrams** $\to$ `visual-designer`

---

## 📋 OpenSpec Spec-Driven Development (SDD)

The ecosystem is standardized around **Fission-AI/OpenSpec** via the `openspec-sdd` skill:
1. `explore` $\to$ 2. `propose` (`proposal.md`, `specs/`, `design.md`, `tasks.md`) $\to$ 3. `apply` (parallel coding lanes) $\to$ 4. `verify` (automated testing against scenarios) $\to$ 5. `archive` (sync delta specs into living system specs).

---

## 🛠️ 16 Progressive Skills

| Skill | Description | Key Standards / Tools |
| :--- | :--- | :--- |
| **`autoresearch`** | Autonomous empirical research loop | Karpathy & Hermes scratchpads, headless probes |
| **`system-architecture`** | Modular system design & ADR authoring | ECC Standard, interface contracts, DoD |
| **`openspec-sdd`** | Spec-Driven Development (SDD) lifecycle | Fission-AI/OpenSpec, proposals, delta-specs, DoD |
| **`token-budget-optimizer`** | Context economics & Karpathy "Think in Code" | Headless script probes, TOON serialization |
| **`test-driven-development`** | Zero-defect automated testing lifecycle | Red-Green-Refactor, `pytest`, `cargo test` |
| **`systematic-debugging`** | Scientific root-cause debugging | Halt-at-2 rule, Minimal Reproducible Example |
| **`code-refactoring-and-architecture`** | Cognitive complexity reduction & clean code | Dead-code elimination, SOLID, SRP |
| **`craft-ui-engineering`** | Modern non-AI design systems & styling | Anti-AI manifesto, Tailwind, SVG, Zero-Lag Data |
| **`git-workflow-and-commits`** | Version control discipline & hygiene | Conventional Commits 1.0, clean trees |
| **`hv-bushing-calc`** | Electrophysics & high-voltage bushing design | COMSOL Multiphysics MPh, FEMM, IEC 60137 |
| **`metrology-lab-data`** | Laboratory experimental data processing | GOST 8.207, Student's t-test, symbolic regression |
| **`uncertainty-and-units`** | Physical unit tracking & error propagation | `pint`, `uncertainties`, ISO/IEC 17025 |
| **`kompas-3d-automation`** | CAD drawing & 3D model generation | ASCON Kompas-3D, pywin32, GOST 2.104 |
| **`blender-bpy-modeling`** | Headless procedural 3D geometry scripting | Blender `bpy`, Boolean modifiers, STL/GLTF export |
| **`three-d-printing-preflight`** | Mesh inspection & slicer tolerance checks | FDM/SLA preflight, wall thickness, fit tolerances |
| **`typst-report`** | Publication-grade scientific report authoring | Typst, `modern-g7-32`, CeTZ vector graphics |

---

## ⚡ Token Economy & Thinking Budget Control

1. **Global Rules (`rules/AGENTS.md`)**:
   - **Direct-Answer Principle**: Eliminates chatty conversational fluff.
   - **The "Think in Code" Paradigm**: Code the analysis headlessly rather than loading huge raw datasets into context.
   - **Anti-Loop Circuit Breaker (Halt-at-2)**: Halts speculative trial-and-error after 2 repeated errors.
   - **Compact Inter-Agent Serialization**: Dense TOON / markdown formatting instead of verbose JSON.
2. **Dedicated Skill (`skills/token-budget-optimizer`)**:
   - Dynamic context pruning and session handoff summaries.

