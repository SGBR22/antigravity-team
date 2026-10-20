---
name: token-budget-optimizer
description: Optimizes context window and reasoning budget to prevent token burn and overthinking. Use when a conversation is getting long, before delegating large payloads between agents, or when pruning conversation state.
---

# Token Budget Optimizer Skill

This skill provides operational procedures for aggressive token conservation, context pruning, and lean data serialization in Antigravity.

## When to Activate:
- Context window exceeds ~50% capacity.
- Transferring research or code between subagents.
- Agent gets stuck in repetitive diagnostic reasoning loops.
- Preparing long-running tasks for clean session handoff.

---

## 1. Context Pruning Protocol

1. **Purge Intermediate Conversational Turns**:
   - Replace sprawling trial-and-error transcripts with a single state snapshot.
2. **File Pointer Compression**:
   - Never quote entire files in prompt contexts when a pointer suffices:
   - Bad: Pasting 300 lines of unchanged code.
   - Good: `[service.py](file:///path/to/service.py#L45-L60)` with a 3-line diff.
3. **Structured Handoff Artifact (`session_handoff.md`)**:
   - When context is saturated, compile state into:
     - Current Goal & Stage
     - Completed Milestones
     - Active Blockers / Remaining Tasks
     - Key File Pointers & Commit Hashes

---

## 2. TOON (Token-Oriented Object Notation) Formatting

Instead of verbose JSON with nested quotes, brackets, and commas:
```json
// Verbose (burns ~45 tokens):
{
  "status": "success",
  "files_modified": ["src/main.py", "tests/test_main.py"],
  "test_results": {"passed": 14, "failed": 0}
}
```

Use dense, indentation-driven TOON notation (saves 40-60% tokens):
```yaml
# Dense TOON (burns ~18 tokens):
status: success
modified:
  - src/main.py
  - tests/test_main.py
tests: 14 passed | 0 failed
```

---

## 3. Anti-Loop Circuit Breaker Procedure

1. Count attempts on the exact same error output.
2. If Attempt Count >= 2:
   - **HALT** all automated code modification tools.
   - Extract the failing command and exact error message.
   - Formulate 2 distinct alternative hypotheses.
   - Output an explicit blocker notice to the user or ask for clarification.
