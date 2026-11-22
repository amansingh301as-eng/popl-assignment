% Q1 - group 7
% Department Assignment Puzzle, solved by generate and test:
%   1. generate a complete assignment,
%   2. test it against the active clues,
%   3. print one solution or count all of them.

:- use_module(library(lists)).

% ---------- Puzzle data ----------

departments([research, development, design, testing]).
languages([python, java, 'c++', javascript]).
projects(['AI', web, embedded, data]).

original_clues([1, 2, 3, 4, 5, 6, 7, 8]).

% ---------- Generating assignments ----------

% generate_assignment(-Solution)
% Solution is a list of p(Name, Dept, Lang, Project) terms for Alex, Ben,
% Carla and Dana, in that order, where each attribute is a permutation of
% its four values. On backtracking it yields all 4! * 4! * 4! = 13824
% assignments. No clue is checked here.
generate_assignment([ p('Alex',  D1, L1, P1),
                      p('Ben',   D2, L2, P2),
                      p('Carla', D3, L3, P3),
                      p('Dana',  D4, L4, P4) ]) :-
    departments(Departments),
    languages(Languages),
    projects(Projects),
    permutation(Departments, [D1, D2, D3, D4]),
    permutation(Languages, [L1, L2, L3, L4]),
    permutation(Projects, [P1, P2, P3, P4]).

% ---------- Testing assignments ----------

% satisfies_all(+Active, +Solution)
% Succeeds, at most once, when clue(N, Solution) holds for every clue number
% N in Active. An empty Active list is satisfied by any Solution.
satisfies_all(Active, Solution) :-
    forall(member(N, Active), clue(N, Solution)).

% solve(-Solution)
% Solution is an assignment that satisfies the original clues 1 to 8.
solve(Solution) :-
    original_clues(Clues),
    generate_assignment(Solution),
    satisfies_all(Clues, Solution).

% ---------- P1.a: printing one solution ----------

% main
% Finds the first solution of clues 1 to 8 and prints it.
main :-
    once(solve(Solution)),
    print_solution(Solution).

% print_solution(+Solution)
% Prints one line per friend, in the order stored in Solution.
print_solution(Solution) :-
    forall(member(Friend, Solution), print_friend(Friend)).

% print_friend(+Friend)
% Prints Friend in the form: Name = [Dept, Lang, Project].
print_friend(p(Name, Dept, Lang, Project)) :-
    format("~w = [~w, ~w, ~w]~n", [Name, Dept, Lang, Project]).

% ---------- P1.b: counting solutions ----------

% count_solutions(+Active, -N)
% N is the number of assignments that satisfy every clue in Active.
% Clues not listed in Active are ignored.
count_solutions(Active, N) :-
    findall(Solution,
            ( generate_assignment(Solution),
              satisfies_all(Active, Solution) ),
            Solutions),
    length(Solutions, N).

% ---------- Finding a friend in a solution ----------

% Each value is used exactly once, so each lookup finds exactly one friend.
friend_named(Name, Solution, Friend) :-
    Friend = p(Name, _, _, _),
    memberchk(Friend, Solution).

friend_in_department(Dept, Solution, Friend) :-
    Friend = p(_, Dept, _, _),
    memberchk(Friend, Solution).

friend_with_language(Lang, Solution, Friend) :-
    Friend = p(_, _, Lang, _),
    memberchk(Friend, Solution).

friend_with_project(Project, Solution, Friend) :-
    Friend = p(_, _, _, Project),
    memberchk(Friend, Solution).

% ---------- Facts about one friend ----------

is_named(p(Name, _, _, _), Name).
works_in(p(_, Dept, _, _), Dept).
likes(p(_, _, Lang, _), Lang).
prefers(p(_, _, _, Project), Project).

% ---------- The clues ----------

% clue(+N, +Solution)
% Succeeds when clue number N holds in the fully filled-in Solution.

% Clue 1: The friend who prefers the AI project does not work in research
% and is not Dana.
clue(1, Solution) :-
    friend_with_project('AI', Solution, Friend),
    \+ works_in(Friend, research),
    \+ is_named(Friend, 'Dana').

% Clue 2: Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    friend_named('Alex', Solution, Friend),
    \+ works_in(Friend, development),
    \+ likes(Friend, 'c++').

% Clue 3: The friend working in the testing department likes Python.
clue(3, Solution) :-
    friend_in_department(testing, Solution, Friend),
    likes(Friend, python).

% Clue 4: Ben prefers web projects and does not work in testing.
clue(4, Solution) :-
    friend_named('Ben', Solution, Friend),
    prefers(Friend, web),
    \+ works_in(Friend, testing).

% Clue 5: The friend whose favorite language is Java works in the design
% department.
clue(5, Solution) :-
    friend_with_language(java, Solution, Friend),
    works_in(Friend, design).

% Clue 6: Carla's project preference is not embedded, and her department
% is not development.
clue(6, Solution) :-
    friend_named('Carla', Solution, Friend),
    \+ prefers(Friend, embedded),
    \+ works_in(Friend, development).

% Clue 7: Dana's favorite language is not Java, and she works in research
% or testing.
clue(7, Solution) :-
    friend_named('Dana', Solution, Friend),
    \+ likes(Friend, java),
    ( works_in(Friend, research) ; works_in(Friend, testing) ).

% Clue 8: The friend who prefers data projects works in research and does
% not use JavaScript.
clue(8, Solution) :-
    friend_with_project(data, Solution, Friend),
    works_in(Friend, research),
    \+ likes(Friend, javascript).

% CLUE 9: The friend who prefers the AI project works in the testing department.
clue(9, Solution) :-
    friend_with_project('AI', Solution, Friend),
    works_in(Friend, testing).
