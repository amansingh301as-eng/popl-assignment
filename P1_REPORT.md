# P1 report — Department Assignment Puzzle

With clues 1–8, `count_solutions([1,2,3,4,5,6,7,8], N)` returns **N = 3**.
Thus the given clues do not determine a unique assignment.

The added ninth clue is: **The friend who prefers the AI project works in testing.**
It refers to a friend only by attribute values and selects exactly one of the three solutions.
With clue 9, `count_solutions([1,2,3,4,5,6,7,8,9], N)` returns **N = 1**.

The unique solution is:

```text
Alex = [design, java, embedded]
Ben = [development, javascript, web]
Carla = [testing, python, AI]
Dana = [research, c++, data]
```

Check the counts with SWI-Prolog 9.x, e.g.:

```bash
swipl -q -f code/id_q1.pl -g 'count_solutions([1,2,3,4,5,6,7,8],N),writeln(N)' -t halt
swipl -q -f code/id_q1.pl -g 'count_solutions([1,2,3,4,5,6,7,8,9],N),writeln(N)' -t halt
```
