---
name: system-architecture
description: Modular system design and interface contract standards based on ECC (Everything Claude Code). Covers boundary isolation, prompt topology optimization, and architectural decision records (ADR).
---

# 🏛️ System Architecture & Interface Design (ECC Standard)

This skill provides architectural guidelines for scalable software and multi-agent systems.

## Key Architectural Rules

### 1. The Interface-First Principle
- Define explicit interface boundaries before writing implementation details.
- Minimize shared state; pass immutable payloads between modules.

### 2. Micro-Agent Topology
- Agents should possess laser-focused responsibilities.
- Avoid "God-agents" that handle both high-level planning, coding, verification, and CAD.
- Use explicit delegation triggers based on intent detection.

### 3. Lightweight Architectural Decision Records (ADR)
When making architectural shifts, document them in 4 sections:
1. **Title**: Short decision summary (e.g., `ADR-001: Auto-Dispatch Routing for Antigravity Squad`).
2. **Context**: What problem or performance bottleneck triggered this change.
3. **Decision**: Chosen solution, discarded alternatives, and rationale.
4. **Impact**: Expected performance gains, migration steps, and compatibility checks.
