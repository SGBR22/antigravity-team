---
name: autoresearch
description: Autonomous empirical research loop based on Andrej Karpathy and Hermes-Agent workflows. Formulates hypotheses, executes headless probe scripts, extracts metrics, and compiles dense factual findings without context bloat.
---

# 🔬 Autoresearch Skill (Karpathy & Hermes Workflow)

This skill guides agents in conducting autonomous, token-efficient empirical research.

## The 4-Step Autoresearch Loop

```
[Formulate Hypothesis] ──> [Write Headless Probe] ──> [Run & Extract Metrics] ──> [Compact Synthesis]
```

### 1. Formulate Hypothesis
- Define exactly what question or invariant is being tested.
- Example: *"Does library X support streaming AST parsing without loading the whole file into memory?"*

### 2. Write Headless Probe
- Never load huge files or raw logs into LLM context.
- Write a short standalone Python or Node script in a scratch directory.
- The script must measure, aggregate, and print only the final answer or summary table.

### 3. Run & Extract
- Execute via `run_command` in quiet mode.
- Output should be $\le 10$ lines of structured text.

### 4. Compact Synthesis
- Present findings as a structured Markdown table or bulleted decision matrix.
- Quote exact version numbers, file paths, and benchmark figures.
