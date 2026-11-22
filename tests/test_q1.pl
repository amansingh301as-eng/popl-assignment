% Tests for P1. Run from the repository root:
%   swipl -q -f tests/test_q1.pl -g run_tests -t halt

:- use_module(library(plunit)).
:- use_module(library(lists)).
:- use_module(library(readutil)).
:- ensure_loaded('../code/7_q1.pl').

% ---------- Fixtures ----------

% build(+Rows, -Solution)
% Turns four Dept-Lang-Project rows into a solution for Alex, Ben, Carla, Dana.
build([D1-L1-P1, D2-L2-P2, D3-L3-P3, D4-L4-P4],
      [p('Alex', D1, L1, P1), p('Ben', D2, L2, P2),
       p('Carla', D3, L3, P3), p('Dana', D4, L4, P4)]).

% known_solution(?Index, ?Rows): the three solutions of clues 1 to 8.
known_solution(1, [design-java-'AI', development-javascript-web,
                   research-'c++'-data, testing-python-embedded]).
known_solution(2, [design-java-embedded, development-javascript-web,
                   testing-python-'AI', research-'c++'-data]).
known_solution(3, [testing-python-embedded, development-javascript-web,
                   design-java-'AI', research-'c++'-data]).

% single_clue_count(?Clue, ?Count): assignments satisfying that clue alone.
single_clue_count(1, 7776).
single_clue_count(2, 7776).
single_clue_count(3, 3456).
single_clue_count(4, 2592).
single_clue_count(5, 3456).
single_clue_count(6, 7776).
single_clue_count(7, 5184).
single_clue_count(8, 2592).
single_clue_count(9, 3456).

% rejected(?Clue, ?Rows): a complete assignment that violates that clue.
rejected(1, [research-java-'AI', development-javascript-web,
             design-'c++'-data, testing-python-embedded]).   % AI in research
rejected(1, [design-java-web, development-javascript-data,
             research-'c++'-embedded, testing-python-'AI']). % Dana has AI
rejected(2, [development-java-'AI', design-javascript-web,
             research-'c++'-data, testing-python-embedded]). % Alex in development
rejected(2, [design-'c++'-'AI', development-javascript-web,
             research-java-data, testing-python-embedded]).  % Alex prefers C++
rejected(3, [design-python-'AI', development-javascript-web,
             research-'c++'-data, testing-java-embedded]).   % testing without Python
rejected(4, [design-java-web, development-javascript-'AI',
             research-'c++'-data, testing-python-embedded]). % Ben not on web
rejected(4, [design-java-'AI', testing-python-web,
             research-'c++'-data, development-javascript-embedded]). % Ben in testing
rejected(5, [design-python-'AI', development-java-web,
             research-'c++'-data, testing-javascript-embedded]). % Java outside design
rejected(6, [design-java-'AI', development-javascript-web,
             research-'c++'-embedded, testing-python-data]). % Carla on embedded
rejected(6, [design-java-'AI', research-javascript-web,
             development-'c++'-data, testing-python-embedded]). % Carla in development
rejected(7, [design-python-'AI', development-javascript-web,
             research-'c++'-data, testing-java-embedded]).   % Dana prefers Java
rejected(7, [testing-java-'AI', development-javascript-web,
             research-'c++'-data, design-python-embedded]).  % Dana in design
rejected(8, [design-java-'AI', development-'c++'-web,
             research-javascript-data, testing-python-embedded]). % data with JavaScript
rejected(8, [design-java-data, development-javascript-web,
             research-'c++'-'AI', testing-python-embedded]). % data outside research
rejected(9, Rows) :- known_solution(1, Rows).
rejected(9, Rows) :- known_solution(3, Rows).

% render(+Solution, -Text): the exact text main/0 must print for Solution.
render(Solution, Text) :-
    with_output_to(string(Text),
        forall(member(p(N, D, L, P), Solution),
               format("~w = [~w, ~w, ~w]~n", [N, D, L, P]))).

% source_lines(-Lines): the lines of the solution file.
source_lines(Lines) :-
    source_file(main, File),
    read_file_to_string(File, Text, []),
    split_string(Text, "\n", "", Lines).

% clue9_source(-Comment, -Head, -Body): the clue 9 comment and the two lines after it.
clue9_source(Comment, Head, Body) :-
    source_lines(Lines),
    once(( append(_, [Comment, Head, Body | _], Lines),
           string_concat("% CLUE 9:", _, Comment) )).

% ---------- Generator ----------

:- begin_tests(p1_generator).

test(all_assignments_distinct) :-
    findall(S, generate_assignment(S), All),
    length(All, 13824),
    sort(All, Unique),
    length(Unique, 13824).

:- end_tests(p1_generator).

% ---------- P1.a: main/0 ----------

:- begin_tests(p1_main).

test(prints_a_solution_of_clues_1_to_8) :-
    with_output_to(string(Output), main),
    once(( known_solution(_, Rows),
           build(Rows, Solution),
           render(Solution, Output) )).

test(four_lines_in_name_order) :-
    with_output_to(string(Output), main),
    split_string(Output, "\n", "", [A, B, C, D, ""]),
    string_concat("Alex = [", _, A),
    string_concat("Ben = [", _, B),
    string_concat("Carla = [", _, C),
    string_concat("Dana = [", _, D).

test(atoms_are_printed_without_quotes) :-
    with_output_to(string(Output), main),
    \+ sub_string(Output, _, _, _, "'").

:- end_tests(p1_main).

% ---------- P1.b: count_solutions/2 ----------

:- begin_tests(p1_count).

test(no_active_clues, N == 13824) :-
    count_solutions([], N).

test(clues_1_to_8, N == 3) :-
    count_solutions([1, 2, 3, 4, 5, 6, 7, 8], N).

test(clue_order_is_irrelevant, N == 3) :-
    count_solutions([8, 7, 6, 5, 4, 3, 2, 1], N).

test(repeated_clues_are_harmless, N == 3) :-
    count_solutions([1, 1, 2, 3, 4, 5, 6, 7, 8, 8], N).

test(each_clue_alone, [forall(single_clue_count(Clue, Expected)), N == Expected]) :-
    count_solutions([Clue], N).

test(finds_exactly_the_known_solutions, Found == Expected) :-
    findall(S, ( generate_assignment(S),
                 satisfies_all([1, 2, 3, 4, 5, 6, 7, 8], S) ), All),
    sort(All, Found),
    findall(S, ( known_solution(_, Rows), build(Rows, S) ), Known),
    sort(Known, Expected).

:- end_tests(p1_count).

% ---------- Each clue on hand-written cases ----------

:- begin_tests(p1_clues).

test(known_solutions_satisfy_clues_1_to_8,
     [forall(( known_solution(_, Rows), between(1, 8, Clue) ))]) :-
    build(Rows, Solution),
    once(clue(Clue, Solution)).

test(rejected_cases_are_real_assignments, [forall(rejected(_, Rows))]) :-
    build(Rows, Solution),
    once(generate_assignment(Solution)).

test(violations_are_rejected, [forall(rejected(Clue, Rows)), fail]) :-
    build(Rows, Solution),
    clue(Clue, Solution).

:- end_tests(p1_clues).

% ---------- P1.c: clue 9 rules ----------

:- begin_tests(p1_clue9).

test(clues_1_to_9_give_one_solution, N == 1) :-
    count_solutions([1, 2, 3, 4, 5, 6, 7, 8, 9], N).

test(true_only_in_the_kept_solution, Kept == [2]) :-
    findall(I, ( known_solution(I, Rows),
                 build(Rows, S),
                 clue(9, S) ), Kept).

test(comment_is_directly_above_clause) :-
    clue9_source(_, Head, _),
    string_concat("clue(9,", _, Head).

test(mentions_no_friend_by_name,
     [forall(member(Name, ["Alex", "Ben", "Carla", "Dana"])), fail]) :-
    clue9_source(Comment, Head, Body),
    member(Text, [Comment, Head, Body]),
    sub_string(Text, _, _, _, Name).

:- end_tests(p1_clue9).

% ---------- Assignment constraints ----------

:- begin_tests(p1_constraints).

test(no_forbidden_constructs,
     [forall(member(Word, ["assert", "retract", "b_setval", "nb_setval",
                           "initialization", "halt"])), fail]) :-
    source_lines(Lines),
    member(Line, Lines),
    sub_string(Line, _, _, _, Word).

:- end_tests(p1_constraints).
