% Q1 - group 7

:- use_module(library(lists)).

% generate_assignment(-Solution)
% Solution is a list of p(Name, Dept, Lang, Project) terms for Alex, Ben,
% Carla and Dana, in that order, where each attribute is a permutation of
% its four values. On backtracking it yields all 4! * 4! * 4! = 13824
% assignments. No clue is checked here.
generate_assignment([ p('Alex',  D1, L1, P1),
                      p('Ben',   D2, L2, P2),
                      p('Carla', D3, L3, P3),
                      p('Dana',  D4, L4, P4) ]) :-
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript], [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data], [P1, P2, P3, P4]).

% clue(+N, +Solution)
% Succeeds when clue number N holds in the fully filled-in Solution.

% Clue 1: The friend who prefers the AI project does not work in research
% and is not Dana.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \== research,
    Name \== 'Dana'.

% Clue 2: Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \== development,
    Lang \== 'c++'.
