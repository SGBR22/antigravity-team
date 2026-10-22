---
name: token-budget-optimizer
description: Active Token Shield and context budget optimizer. Enforces aggressive token conservation, differential file referencing, headless script data extraction, TOON serialization, and anti-regurgitation protocols to maximize efficiency without sacrificing accuracy.
---

# Active Token Shield & Context Optimization Skill

This skill enforces concrete procedures for maximizing token efficiency, minimizing context degradation, and staying well within rate limits while strictly preserving analytical accuracy and execution speed.

---

## 🛡️ Core Directives (Active Token Shield):

### 1. The Headless Extraction Principle ("Think in Code")
- **NEVER** dump hundreds of lines of logs, CSV tables, or entire source files into the prompt context.
- Instead, run a 5–10 line Python script or PowerShell filter via `run_command` that processes data locally and outputs only a concise summary table ($< 15$ lines).
- In PowerShell, pipe outputs:
  ```powershell
  # Bad: cat giant_log.txt
  # Good:
  Get-Content giant_log.txt | Select-String "ERROR|FAIL" | Select-Object -First 15
  ```

### 2. Differential Communication & File Pointers
- When passing context between agents or presenting changes:
  - **Forbidden**: Copy-pasting 200 lines of unchanged code.
  - **Required**: Provide a clickable line pointer and a surgical diff:
    `[service.py](file:///path/to/service.py#L45-L60)` (Diff: 5 lines).

### 3. TOON (Token-Oriented Object Notation)
- For all inter-agent communication, handoff state files, and subagent return messages, use dense indentation-driven TOON rather than verbose JSON:
  ```yaml
  # Dense TOON (~15 tokens vs ~50 tokens in JSON)
  status: ok
  lane: LaneA_femm
  data: artifacts/calc_results.json
  metrics: C=142.5pF | U_max=126kV
  ```

### 4. Anti-Regurgitation Protocol (Защита от пересказа)
- The Coordinator and root agent must **NEVER** duplicate or re-summarize content already present in artifacts, generated PDFs, or subagent transcripts.
- Deliver only:
  1. The clickable file link (`file:///.../report.pdf`).
  2. The 1–3 sentence executive decision / summary of critical metrics.
  3. Clear next actions or questions.

### 5. Speculative Skeleton Latency & Token Optimization
- When pipelining work (e.g., calculation + report):
  - Do not pass conversational prose back and forth.
  - Agree on a pre-defined path (`artifacts/results.json`).
  - Both agents communicate strictly via filesystem state, requiring ZERO conversational negotiation tokens.

### 6. Anti-Loop Circuit Breaker ("Стоп на 2")
- If any command, script, or test fails **2 times in succession**:
  1. **HALT** further tool executions.
  2. Extract the exact error message and the differing state.
  3. Formulate 2 distinct hypotheses and switch strategy or request human clarification.
