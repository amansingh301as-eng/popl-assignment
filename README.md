# CS F301 — Assignment 2

## Setup
Replace `id` in the four files under `code/` with your group ID before submission, retaining required naming. Work in a single shared GitHub repo (not a zip submission). SWI-Prolog 9.x and Racket 8.x are required.

## Execution
From the repository root:

```bash
swipl -q -f code/id_q1.pl -g main -t halt
swipl -q -f code/id_q2.pl -g 'all_equations([4,2,5,3],Es),writeln(Es)' -t halt
racket code/id_q3.rkt
racket code/id_q4.rkt
bash tests/run_tests.sh
```

The Scheme code deliberately produces no output when loaded. The grader appends calls to the files. For isolated Scheme tests the script temporarily appends calls to copies outside the repository.

## Contribution plan — must represent actual work
- Member 1: P1 clues/solver/report, Prolog skill, P2 review.
- Member 2: P2 generation/rendering, equation tests, P1 review.
- Member 3: S1 traversals/statistics, Scheme skill, S2 review.
- Member 4: S2 higher-order transform, nested/large inputs, S1 review.

All four should use their own GitHub accounts and commit actual changes, test extensions, fixes, and reviews. Don't fabricate history or change authorship to disguise who did work. Split and document further predicate/function requests to comply with the decomposition rule. Each person should be ready to explain their work and the general working of all four programs.

## Submission checklist
- [ ] Replace placeholder `id` with real group ID.
- [ ] Run tests with the required installed interpreters.
- [ ] Confirm prompt files contain verbatim genuine prompt history.
- [ ] Each contributor adds their own genuine commits and reviews.
- [ ] Push the repository with the full commit history.
