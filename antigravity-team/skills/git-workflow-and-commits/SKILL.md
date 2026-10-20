---
name: git-workflow-and-commits
description: Git version control standards, Conventional Commits 1.0 specifications, atomic commits, branch hygiene, and clean changelog preparation.
---

# Git Workflow & Conventional Commits

This skill defines version control hygiene and semantic commit guidelines to keep repositories clean, traceable, and automated-release ready.

---

## 1. Conventional Commits 1.0 Specification

Every commit message follows this structured format:
```
<type>(<optional scope>): <description>

[optional body]

[optional footer(s)]
```

### Allowed Types:
- **`feat`**: A new feature for the user or consumer.
- **`fix`**: A bug fix for the user or consumer.
- **`refactor`**: Code changes that neither fix a bug nor add a feature (e.g., restructuring, renaming).
- **`perf`**: A code change that improves execution speed or reduces memory usage.
- **`test`**: Adding missing tests or correcting existing tests.
- **`docs`**: Documentation changes only.
- **`chore`**: Maintenance, build system, or dependencies updates without changing runtime source code.

### Examples:
- `feat(bushing): add capacitive foil grading optimization algorithm`
- `fix(cad): resolve COM disconnect error in Kompas-3D batch exporter`
- `refactor(metrology): extract Student-t lookup table to standalone module`
- `perf(femm): vectorize mesh coordinate extraction to speed up calculation by 4x`

---

## 2. Atomic Commits Rule

1. **One Logical Change Per Commit**:
   - Never combine unrelated bug fixes and new features in the same commit.
   - Separate refactorings from behavior-altering changes.
2. **Build Invariant**:
   - Every single commit in the git history must compile, pass static type checks, and pass all unit tests.
3. **Commit Messages**:
   - Write in the imperative mood (*"add feature"*, not *"added feature"* or *"adds feature"*).
   - Keep the summary line under 72 characters.
