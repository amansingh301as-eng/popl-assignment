---
name: scheme-dev
description: Write and review Racket 8.x solutions under a strict Scheme built-in whitelist.
---
# Scheme development
- Use `#lang racket/base`; keep files definitions-only and free of top-level function calls.
- Only use the specified built-ins: define, lambda, let/let*/letrec/named let, if, cond, and, or, not, begin, quote, cons, car/cdr and compositions up to four levels, null?, pair?, eq?, assq, assoc, + - * < > <= >= = max, display, newline; S2 may additionally use read.
- Use lowercase hyphenated function names, explain structural recursion and accumulator invariants.
- Write helper implementations rather than length, append, reverse, map, filter, member or list-ref.
- Run with `racket code/id_q3.rkt` or `racket code/id_q4.rkt`; test by appending test calls to a temporary copy, not by adding top-level calls to submission files.
- Review empty trees/lists, nesting, original versus transformed lengths, preservation of element order and exact line output.
- Known AI failure modes: forbidden built-ins (`map`, `length`, `append`), missing quoted empty list, treating empty sublists as atoms, inserting based on modified length, unbounded non-tail list traversals, accidentally calling a function at load time.
- Commit actual function-level work, tests, and reviews from individual developer identities.
