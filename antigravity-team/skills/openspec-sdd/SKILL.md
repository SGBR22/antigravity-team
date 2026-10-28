---
name: openspec-sdd
description: Spec-Driven Development (SDD) methodology and workflow based on Fission-AI/OpenSpec. Covers the entire change lifecycle (explore, propose, design, delta-specs, tasks, apply, verify, and archive), CLI operations, and multi-agent contract execution.
---

# Spec-Driven Development (OpenSpec SDD)

Spec-Driven Development (SDD) is an engineering practice popularized by [Fission-AI/OpenSpec](https://github.com/Fission-AI/OpenSpec). It bridges the gap between architectural intent and implementation, ensuring that code changes are proposed, specified, designed, reviewed, and tested against deterministic contracts before being archived into the living documentation of the repository.

---

## 🧭 Core SDD Principles

1. **Fluid, Not Rigid**: Specs adapt as learning occurs during development, but every non-trivial change must be documented before writing production code.
2. **Iterative, Not Waterfall**: Changes are partitioned into small, reviewable increments (`openspec/changes/<change-id>/`).
3. **Delta Specifications**: Changes define what is *added*, *modified*, or *removed* relative to the existing system, rather than rewriting the full system spec from scratch.
4. **Executable Scenarios**: Requirements are paired with concrete, testable scenarios that can be directly mapped to automated unit/integration tests.
5. **Living System Truth**: When a change is approved and completed, it is *archived*, merging its delta specs into the project's permanent `openspec/specs/` hierarchy.

---

## 🔄 The 5-Phase OpenSpec Lifecycle

```text
1. Explore ──► 2. Propose ──► 3. Apply ──► 4. Verify ──► 5. Archive
  (Analyze)      (Specs/Design)  (Code/Tests)   (QA Audit)     (Merge to Truth)
```

### Phase 1: Explore (`explore`)
* Inspect the existing codebase, dependencies, and previous specs (`openspec/specs/`).
* Identify technical constraints, edge cases, and scope boundaries before committing to a design.

### Phase 2: Propose (`propose` / `new change`)
A new change lives in its own directory: `openspec/changes/<change-id>/` and contains four standardized artifacts:

```text
openspec/changes/<change-id>/
├── proposal.md              # Motivation, user problem, scope, non-goals
├── specs/                   # Delta requirements and scenarios
│   └── <capability>/spec.md
├── design.md                # Technical design, interfaces, data models
└── tasks.md                 # Checkable implementation breakdown
```

#### 1. `proposal.md` Template:
```markdown
# Proposal: [Brief Descriptive Title]

## Motivation & Problem
Explain why this change is necessary and what user or architectural friction it solves.

## Proposed Solution
High-level overview of the proposed change.

## Scope & Non-Goals
- **In Scope**: Itemized features and behaviors included.
- **Out of Scope**: Explicitly deferred items to prevent scope creep.
```

#### 2. `specs/<capability>/spec.md` (Delta Format):
Specifications MUST use the OpenSpec delta keyword hierarchy:
```markdown
# Capability: [Capability Name]

## ADDED Requirements

### Requirement: [Clear requirement statement]
The system SHALL provide [feature behavior].

#### Scenario: [Specific testable condition]
- **Given** [preconditions]
- **When** [action taken]
- **Then** [expected result]

## MODIFIED Requirements

### Requirement: [Updated requirement statement]
...

## REMOVED Requirements

### Requirement: [Deprecated requirement statement]
...
```

#### 3. `design.md` Template:
```markdown
# Technical Design: [Change Name]

## Architecture & Data Flow
Diagrams, entity relationships, or state machine flows.

## Interface Contracts & Schemas
JSON schemas, TypeScript types, or database DDL definitions.

## Edge Cases & Error Handling
Handling of timeouts, invalid inputs, resource constraints.
```

#### 4. `tasks.md` Template:
```markdown
# Implementation Tasks

- [ ] 1. Foundation & Contracts
  - [ ] 1.1 Define database migrations and entity models
  - [ ] 1.2 Setup API contract interfaces and types
- [ ] 2. Core Implementation
  - [ ] 2.1 Backend service and endpoints (`senior-dev`)
  - [ ] 2.2 Client-side state and hooks (`frontend-dev`)
- [ ] 3. Automated Verification & QA
  - [ ] 3.1 Unit and property-based test suites (`test-engineer`)
  - [ ] 3.2 Peer audit and plan verification (`code-reviewer`)
```

### Phase 3: Apply (`apply`)
* Execute the tasks in `tasks.md` sequentially or in parallel lanes.
* Mark completed tasks: `- [x] 1.1 ...`.
* Maintain backwards compatibility and respect interface contracts established in `design.md`.

### Phase 4: Verify (`verify`)
* Compare implementation and test outputs against every `#### Scenario:` defined in `specs/`.
* Run test suites headlessly: `pytest -q`, `npx vitest run`.
* If any scenario fails or unhandled edge cases appear, update either the code or the proposal before proceeding.

### Phase 5: Archive (`archive`)
* Once verified by `code-reviewer`:
* The change directory is archived into `openspec/changes/archive/` (or via `openspec archive <change-id>`).
* Delta specs from `specs/` are merged into the permanent repository specs in `openspec/specs/<capability>/spec.md`.

---

## 🛠️ OpenSpec CLI Integration

When the OpenSpec CLI is available:

```bash
# Initialize OpenSpec in a repository
openspec init

# List active changes and registered stores
openspec list --json
openspec store list --json

# Create a new change scaffold
openspec new change <change-name>

# Check status and validate change schema integrity
openspec status --change <change-name>
openspec validate <change-name>

# Archive completed change
openspec archive <change-name>
```

---

## 🤝 Multi-Agent OpenSpec Collaboration Pattern

| Agent | OpenSpec Responsibility |
| :--- | :--- |
| 🏛️ **`system-architect`** | Authors `proposal.md`, `design.md`, and delta `specs/`. Formulates `tasks.md`. |
| 🎯 **`coordinator`** | Tracks task progress in `tasks.md`, dispatches developers in parallel lanes. |
| 🗄️ **`database-engineer`** | Executes database tasks from `tasks.md` conforming to `design.md`. |
| ⚡ **`senior-dev`** | Implements backend API logic and algorithms mapped to requirements in `specs/`. |
| 💻 **`frontend-dev`** | Builds client application logic and hooks based on the interface contracts. |
| 🎨 **`visual-designer`** | Creates aesthetic layouts, styling tokens, and design components. |
| 🧪 **`test-engineer`** | Writes automated tests directly mirroring every `#### Scenario:` in the spec. |
| 🖥️ **`sysadmin`** | Configures environments, services, and containers needed for change execution. |
| 🛡️ **`code-reviewer`** | Validates the completed change against the spec (`openspec validate`) before sign-off. |
