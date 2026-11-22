---
name: scheme-dev
description: Use when writing, testing or reviewing Racket Scheme code for CS F301 Assignment 2 (problems S1 and S2, files 7_q3.rkt and 7_q4.rkt).
---

# Scheme Development Skill

## Language and environment

- Target: Racket 8.x.
- Every solution file starts with `#lang racket/base`.
- Solution files live in `7/code/`, and tests live in `7/tests/`. Run every command below from the `7/` folder.

## Allowed built-ins

Use only these:

- **Definitions and binding:** `define`, `lambda`, `let`, `let*`, `letrec`, named `let`
- **Control and logic:** `if`, `cond` (with `else`), `and`, `or`, `not`, `begin`
- **Data:** `quote` (written `'`), `cons`, `car`, `cdr`, `list`, and every composition of `car` and `cdr` up to four levels, such as `cadr`, `cddr`, `caddr`, `cdddr`, `cadddr` and `cddddr`
- **Tests and lookup:** `null?`, `pair?`, `eq?`, `assq`, `assoc`
- **Arithmetic and comparison:** `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, `=`, `max`
- **Output:** `display`, `newline`
- **S2 only:** `read`

Nothing else from `racket/base` may be used.

## Forbidden

- `set!` and its relatives, vectors, hash tables and strings
- Loops such as `do` and `for`
- `require` and `provide`
- `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, `list-tail`
- Any other unlisted name, including `when`, `unless`, `case`, `apply`, `foldl`, `foldr`, `add1`, `sub1`, `zero?`, `equal?`, `list?`, `number?`, `symbol?`, `first`, `rest`, `empty?` and quasiquote

If one of these is needed, write a helper from the allowed built-ins, for example `my-reverse`.

## Working rules

- One prompt is one unit of work: one function, one test file or one review. Never produce a whole problem from one prompt.
- Write only the unit requested. Do not add or change other functions without saying so.
- Commit each finished unit separately, with its prompt copied word for word into `prompts/S1.md` or `prompts/S2.md`.
- Solution files contain only definitions.
- Never call a function at the top level and never print while the file loads. The grader appends its own calls.
- Pass all state through function arguments.

## Coding conventions

- Use `kebab-case` for names, `?` at the end of predicates, and a `my-` prefix for replacements of forbidden built-ins.
- Use the exact required function names and argument order.
- Put a comment above each function with its contract and recursive reading:

```racket
; my-length : list -> number
; The length of () is 0. Otherwise it is 1 plus the length of the tail.
```

- Handle the base case first, usually with `null?`.
- Treat a value as an atom when it is neither a pair nor the empty list.
- Use a named `let` with an accumulator where tail recursion is natural.
- Use `letrec` when a local function must call itself or another local function.
- Prefer tail recursion for long list operations.
- Preserve the original order of list elements.
- Keep helpers small, and give them names that describe their result.
- Add comments for non-obvious logic, and leave no debugging output.

## S1: Binary Tree Traversals (`7_q3.rkt`)

A tree is either `()` or a three-element list `(value left right)`. A value is a number or a single-character symbol.

Required functions:

- `(print-inorder tree)` prints the inorder list on one line.
- `(print-all-traversals tree)` prints the inorder, preorder and postorder lists on three lines, in that order.
- `(print-height-and-leaves tree)` prints the list `(height leaf-count)` on one line.

Review requirements:

- Inorder is left, node, right. Preorder is node, left, right. Postorder is left, right, node.
- Always visit the left subtree before the right subtree.
- The height of `()` is 0, and a node's height is 1 plus the larger subtree height.
- A leaf is a node whose left and right subtrees are both `()`. The empty tree has 0 leaves.
- For the empty tree, each traversal prints `()`, and height and leaves print `(0 0)`.
- Print with `display`, and end every function's output with a newline.

## S2: Conditionally Insert into a Nested List (`7_q4.rkt`)

Required functions:

- `my-length` and `my-map`, written using only allowed built-ins
- `(make-inserter x len-ok?)`, which returns a one-argument function that processes a list
- `(insert-if-short x lst n)`, defined using `make-inserter`
- `(print-insert-result)`, which takes no arguments

Review requirements:

- A list's length is its number of top-level elements, measured before any insertion.
- Insert `x` at the front of every list whose original length is less than `n`, at every nesting level.
- A list whose length equals `n` is not short, so nothing is inserted.
- Treat the top-level list like every other list.
- `()` has length 0, so it becomes `(x)` whenever `0 < n`.
- `len-ok?` takes one number and decides whether a list receives `x`.
- The final file contains exactly one definition of `insert-if-short`.
- `print-insert-result` reads `x`, `lst` and `n` in that order, prints no prompt, and prints only the result and a newline.

## Running and testing

Check that a solution file loads and prints nothing:

```bash
racket code/7_q3.rkt
```

To test without changing a solution file, copy it to a temporary file and append calls there:

```bash
cp code/7_q4.rkt /tmp/check_q4.rkt
```

```bash
echo '(print-insert-result)' >> /tmp/check_q4.rkt
```

```bash
printf '42 ((1 2) (3 4 5) (6) ()) 3' | racket /tmp/check_q4.rkt
```

Tests must include every example from the assignment, plus edge cases:

- **S1:** empty tree, single node, left-only and right-only chains, balanced trees, deep trees, and symbol values
- **S2:** empty top-level list, nested empty lists, `n = 0`, lists shorter than, equal to and longer than `n`, several nesting levels, nesting depth 100, and a list of 10,000 elements

For both problems, verify the exact output, including spaces and the final newline. Keep test calls out of the submitted solution files.

## Self-review checklist

Apply this before answering:

- [ ] The answer contains only the requested unit.
- [ ] The file starts with `#lang racket/base`.
- [ ] Every identifier used is on the allowed list or defined in the file.
- [ ] All required functions for the problem are defined.
- [ ] The file contains only definitions and prints nothing when loaded.
- [ ] No test calls or debugging output remain.
- [ ] Recursive cases reach every sublist or subtree.
- [ ] Element order is preserved.
- [ ] Tail recursion is used where practical.
- [ ] Names, argument order and output format match the assignment exactly.
- [ ] Every printing function ends its output with a newline.
- [ ] The empty list and other base cases are handled.
- [ ] Subtrees are visited left first, then right.
- [ ] In S2, lengths are measured on the original list, before insertion.
- [ ] Large and deeply nested inputs finish in reasonable time.
- [ ] The code was actually run, and the assignment examples pass.

## Known failure modes of AI tools in Scheme

- **Using forbidden built-ins out of habit.** `length`, `append`, `map` and `reverse` are the most common. Search the final file for them.
- **Using predicates that are not allowed.** `list?`, `number?`, `symbol?` and `equal?` look harmless but are not on the list.
- **Importing extra libraries.** `first`, `rest` and `empty?` come from `racket/list`, and no extra `require` is allowed.
- **Top-level expressions.** In a Racket module, a top-level expression prints its non-void result, which breaks the grader's output.
- **Measuring length after insertion.** In S2, inserting first can change whether a list counts as short.
- **Treating `()` as an atom.** It is a list with length 0, so it must also be processed.
- **Forgetting the top-level list.** The outer list follows the same rule as every nested list.
- **Quadratic list building.** Repeated appending can be too slow on 10,000 elements. Prefer accumulators.
- **Wrong accumulator order.** Tail-recursive helpers often build results backwards, so check whether a reverse is needed.
- **Wrong tree conventions.** The height of `()` is 0, a single node has height 1, and the empty tree has no leaves.
- **Misusing equality.** Use `=` for numbers and `eq?` for symbols. Calling `=` on a symbol raises an error.
- **Using mutation.** State must be passed through arguments, never updated with `set!`.
- **Incomplete recursion.** Code may process the top level but miss nested lists, or follow only one subtree.
- **Wrong traversal order.** Swapping the node's position or visiting right before left produces a plausible but wrong list.
- **Off-by-one threshold.** S2 uses strictly less than `n`, so a list of length `n` stays unchanged.
- **Leftover debugging.** Debug prints and test calls left in the file become unwanted grader output.
- **Claiming success without running.** Report only results that were actually executed.
