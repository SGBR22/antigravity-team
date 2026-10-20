---
name: code-refactoring-and-architecture
description: Clean code principles, practical modular architecture, dead code elimination, and cognitive complexity reduction for scientific and engineering software without typing bureaucracy.
---

# Pragmatic Code Architecture & Refactoring

This skill guides structuring, cleaning, and refactoring engineering and scientific code to ensure it remains clear, fast, and easy to maintain.

---

## 1. Practical Architecture Principles for Engineers

1. **Keep It Simple & Pythonic (KISS)**:
   - Avoid heavy boilerplate, multiple layers of abstraction, and over-designed class hierarchies.
   - Separate pure calculations (math, algorithms) from I/O (files, CAD models, COMSOL calls).
2. **Lightweight Signatures**:
   - Add simple type hints to function arguments and returns for readability (`def solve_step(voltage: float, steps: int = 10) -> list[float]:`).
   - Do NOT use heavy `pydantic` or `mypy --strict` rules that complicate interop with COM and C-extensions.
3. **Use Dataclasses for Structured Data**:
   - When grouping related parameters, use Python's built-in `@dataclass` rather than complex validation frameworks:
   ```python
   from dataclasses import dataclass

   @dataclass
   class BushingParameters:
       r_conductor_mm: float
       r_flange_mm: float
       voltage_kv: float
       n_layers: int = 12
   ```

---

## 2. Refactoring Recipes

- **Extract Function**: Break monolithic 100-line scripts into cohesive 10-20 line steps (setup, compute, export).
- **De-nesting**: Use early returns (guard clauses) to reduce indentation depth.
- **Vectorization**: Replace raw Python `for` loops operating on float numbers with vectorized NumPy operations for speed.
- **Resource Safety**: Always use `with` statements for files, or `try / finally` blocks when interacting with COM CAD applications.
