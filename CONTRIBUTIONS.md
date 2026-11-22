# Group contribution record (fill with real evidence)

All four members may share one AI account, but GitHub contributions should reflect their own work. The file tree is a starting draft, not proof that four people have implemented or reviewed it.

| Member | GitHub username | Assigned area | Actual authored changes, tests or reviews | Commit hashes / PRs |
|---|---|---|---|---|
| 1 | 2023B5A70795H | P1 + Prolog skill | TODO | TODO |
| 2 | 2023B3A70476H | P2 + P2 tests | TODO | TODO |
| 3 | 2023B3A70436H | S1 + Scheme skill | TODO | TODO |
| 4 | 2023B5A70790H | S2 + S2 tests | TODO | TODO |

## Suggested workflow
1. Owner creates repository and invites the other three as collaborators.
2. Each member checks out a separate feature branch and inspects the supplied draft for correctness.
3. Each member makes substantive improvements, writes additional tests, explains their changes in a pull request, and commits as themselves.
4. Each PR gets reviewed by a different member. Merge without squashing if preserving granular commits is desired.
5. Include genuine subsequent, one-unit prompts verbatim in the corresponding `prompts/*.md` file.
6. Use `git shortlog -sne --all` and `git log --format='%h %an %s'` to verify the record.

Do not fabricate or reattribute commits, invent prompt histories, or claim equal effort without it actually occurring.
