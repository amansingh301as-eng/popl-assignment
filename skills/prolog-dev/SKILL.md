---
name: prolog-dev
description: Develop and review small logic programs for SWI-Prolog 9.x without side effects.
---
# Prolog development
- Target SWI-Prolog 9.x; files have only definitions, no initialization or halt calls.
- Prefer descriptive predicate names, lowercase atoms, and independent declarative relations.
- Explain each predicate in terms of what is true, not imperative steps.
- Keep all states in terms/arguments; no assert/retract or global variables.
- Use only permitted libraries: lists, apply, yall, aggregate.
- Test with `swipl -q -f code/id_q1.pl -g main -t halt` and isolated `-g` goals.
- Review: ensure all person attributes are bijections, exact string output, all clue subsets honored, and empty inputs fail safely.
- Known AI failure modes: hard-coded puzzle answers, accidentally applying inactive clues, treating `c++`/`AI` as unquoted atoms, floating point division, duplicate equations, losing number order, wrong associativity/parentheses, unintended startup printing.
- Make commits per completed predicate or test/review unit, from the actual contributor's GitHub identity.
