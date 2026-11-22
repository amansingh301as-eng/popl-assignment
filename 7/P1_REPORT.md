# P1 Report

## P1.b: Number of solutions for clues 1 to 8

`count_solutions([1,2,3,4,5,6,7,8], N)` gives **N = 3**.

**What this tells us:** the puzzle is consistent, because at least one assignment satisfies all eight clues. It is also under-constrained, because the clues do not identify a single answer. Three different assignments satisfy every clue:

| Solution | Alex | Ben | Carla | Dana |
|---|---|---|---|---|
| 1 | design, java, AI | development, javascript, web | research, c++, data | testing, python, embedded |
| 2 | design, java, embedded | development, javascript, web | testing, python, AI | research, c++, data |
| 3 | testing, python, embedded | development, javascript, web | design, java, AI | research, c++, data |

The clues settle part of the puzzle:

- Ben is fully determined: development, javascript, web.
- Three groupings hold in every solution: development with javascript and web, research with c++ and data, and design with java.
- Testing is always paired with python.

The clues leave these points open:

- Which of Alex, Carla and Dana holds each of the remaining three roles.
- Whether the design and testing friends prefer AI or embedded.

An additional clue is therefore needed to reduce the count from 3 to 1.
