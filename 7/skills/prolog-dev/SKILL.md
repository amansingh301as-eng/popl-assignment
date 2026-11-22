---
name: prolog-dev
description: Use when writing, testing or reviewing SWI-Prolog code for CS F301 Assignment 2 (problems P1 and P2, files 7_q1.pl and 7_q2.pl).
---

# Prolog Development Skill

## Language and environment

- Target: SWI-Prolog 9.x. If another version is used while developing, run the final file once on 9.x before submission.
- Allowed libraries: `lists`, `apply`, `yall`, `aggregate`. Test files may also use `plunit` and `readutil`.
- Solution files live in `7/code/`, and tests live in `7/tests/`. Run every command below from the `7/` folder.

## Working rules

- One prompt is one unit of work: one predicate, one test file or one review. Never produce a whole problem from one prompt.
- Write only the unit requested. Do not add or change other predicates without saying so.
- Commit each finished unit separately, with its prompt copied word for word into `prompts/P1.md` or `prompts/P2.md`.
- Solution files contain only definitions and comments.
- Never use `assert`, `retract`, `b_setval`, `nb_setval`, `halt` or any `initialization` directive.
- Print only what the problem specifies. P2 predicates print nothing.
- In P2, never build a string and parse it back into a term to evaluate it.

## Coding conventions

- Use `snake_case` for predicates and atoms, and `PascalCase` for variables.
- Quote atoms that need it, exactly as specified: `'Alex'`, `'AI'`, `'c++'`.
- Put a comment above each predicate with its mode and a declarative reading:

```prolog
% count_solutions(+Active, -N)
% N is the number of assignments that satisfy every clue in Active.
```

- Use `+` for inputs, `-` for outputs and `?` for either.
- Keep all clauses of a predicate together, so that loading prints no discontiguous warning.
- Name helpers after what they mean, and use `_` for values that are not needed.
- Prefer pure relations. Use `once/1`, `forall/2` or `->` when they state the intent, and avoid cuts that change the logical meaning.

## Running and testing

Run the P1 solution:

```bash
swipl -q -f code/7_q1.pl -g main -t halt
```

Run any goal:

```bash
swipl -q -f code/7_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8],N),writeln(N)" -t halt
```

Run the P2 examples:

```bash
swipl -q -f code/7_q2.pl -g "all_equations([4,2,5,3],Es),print(Es),nl" -t halt
```

Run the P1 tests:

```bash
swipl -q -f tests/test_q1.pl -g run_tests -t halt
```

Check that loading a file prints nothing:

```bash
swipl -q -f code/7_q1.pl -g true -t halt
```

Tests must include every example from the assignment, plus edge cases such as empty lists, single-element lists, no valid answer, and repeated or reordered inputs.

## Self-review checklist

Apply this before answering:

- [ ] The answer contains only the requested unit.
- [ ] The file loads with no warnings or output.
- [ ] Predicate names, argument order and output format match the assignment exactly.
- [ ] Atoms are spelled and quoted exactly as specified.
- [ ] No forbidden predicate, directive or library is used.
- [ ] Each comment gives a correct declarative reading.
- [ ] Backtracking gives the intended answers, with no duplicates.
- [ ] Failure cases fail cleanly rather than looping or raising an error.
- [ ] Arithmetic is evaluated only on bound values.
- [ ] The code was actually run, and the assignment examples pass.
- [ ] Counts were checked by a separate method when possible.

## Known failure modes of AI tools in Prolog

- **Confusing equality operators.** `=` unifies, `==` compares without binding, `=:=` compares arithmetic values, and `is` evaluates. Using the wrong one can silently change the result.
- **Negation on unbound variables.** `\+`, `\=` and `\==` behave differently before variables are bound. Generate values first, then test them.
- **Duplicate answers.** A clause using `member/2` or `;` can succeed more than once and inflate a `findall/3` count. Check counts against distinct results.
- **Inventing library predicates.** Confirm that a predicate exists and comes from an allowed library.
- **Wrong quoting.** `AI` is a variable but `'AI'` is an atom. `c++` is not a plain atom and must be written `'c++'`.
- **Wrong print predicate.** `write` and `~w` omit quotes, while `print`, `writeq` and `~q` keep them. Choose according to the required output.
- **Strings, atoms and code lists.** Double-quoted text is a string in SWI-Prolog. P2 must return strings, not atoms or code lists.
- **Unsafe division.** `/` may not behave as integer division. Check for a zero divisor and an exact result before dividing.
- **Infinite recursion.** Left recursion and unbounded generators can loop forever. Make each recursive call work on a smaller input.
- **Scattered clauses.** Separating clauses of one predicate prints a warning, which counts as unwanted output.
- **Hard-coded answers.** Results must be derived from the rules, never written directly into the program.
- **Claiming success without running.** Report only results that were actually executed.
