# ⚡ Antigravity Multi-Agent Ecosystem (`antigravity-team` v2.6.0)

A modular, production-grade multi-agent ecosystem and token-saving engine designed specifically for Google Antigravity. Incorporates cutting-edge paradigms from **Andrej Karpathy's autoresearch workflows**, **ECC (Everything Claude Code)** modular architecture, **Craft UI Engineering**, and **NousResearch Hermes agent scratchpads**.

---

## 👥 10 Specialized Subagents

| Subagent | File | Model | Primary Capabilities |
| :--- | :--- | :--- | :--- |
| **`coordinator`** | `agents/coordinator.md` | `inherit` | Request decomposition, work graphs, execution plans, agent dispatching. |
| **`senior-dev`** | `agents/senior-dev.md` | `inherit` | Clean, pragmatic, robust code, automated TDD, zero-defect delivery. |
| **`code-reviewer`** | `agents/code-reviewer.md` | `inherit` | Adversarial code review, 6-point QA audit, memory & COM leaks, defect tickets. |
| **`researcher`** | `agents/researcher.md` | `inherit` | Karpathy & Hermes empirical research, headless benchmark probes, rapid exploration. |
| **`system-architect`** | `agents/system-architect.md` | `inherit` | ECC-style modular architecture, prompt hygiene, interface contracts, ADRs. |
| **`science-compute`** | `agents/science-compute.md` | `inherit` | COMSOL Multiphysics via MPh, FEMM, HV bushing electrophysics, GUM metrology. |
| **`cad-specialist`** | `agents/cad-specialist.md` | `inherit` | Kompas-3D pywin32 API 5/7, Blender bpy procedural modeling, 3D printing preflight. |
| **`typst-reporter`** | `agents/typst-reporter.md` | `inherit` | Publication-ready scientific/technical reports via Typst & `modern-g7-32` (ГОСТ 7.32). |
| **`visual-designer`** | `agents/visual-designer.md` | `inherit` | Exclusive visual styling & UI authority: adaptive non-AI modern design, showcases, UI/UX, Mermaid diagrams. |
| **`web-surfer`** | `agents/web-surfer.md` | `inherit` | Targeted web search, official documentation scraping, source attribution. |

---

## 🚨 Mandatory Auto-Dispatch Protocol

In accordance with `rules/AGENTS.md`, the primary Antigravity orchestrator must automatically delegate domain tasks to subagents via `invoke_subagent`:
- **Code implementation / bug fixing** $\to$ `senior-dev`
- **Security / code review** $\to$ `code-reviewer`
- **Empirical research / exploration** $\to$ `researcher`
- **System architecture / interfaces** $\to$ `system-architect`
- **Physical modeling & metrology** $\to$ `science-compute`
- **CAD & 3D printing** $\to$ `cad-specialist`
- **Formal reports (GOST / Typst)** $\to$ `typst-reporter`
- **Visual styling / UI / Showcases / Diagrams** $\to$ `visual-designer`

---

## ⚡ Token Economy & Thinking Budget Control

1. **Global Rules (`rules/AGENTS.md`)**:
   - **Direct-Answer Principle**: Eliminates chatty conversational fluff.
   - **The "Think in Code" Paradigm**: Code the analysis headlessly rather than loading huge raw datasets into context.
   - **Anti-Loop Circuit Breaker (Halt-at-2)**: Halts speculative trial-and-error after 2 repeated errors.
   - **Compact Inter-Agent Serialization**: Dense TOON / markdown formatting instead of verbose JSON.
2. **Dedicated Skill (`skills/token-budget-optimizer`)**:
   - Dynamic context pruning and session handoff summaries.
