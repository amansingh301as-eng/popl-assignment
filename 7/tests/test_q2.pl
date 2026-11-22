% Tests for P2. Run from the group folder (7/):
%   swipl -q -f tests/test_q2.pl -g run_tests -t halt

:- use_module(library(plunit)).
:- use_module(library(lists)).
:- ensure_loaded('../code/7_q2.pl').

% ---------- Assignment Examples ----------

:- begin_tests(p2_examples).

test(all_equations_4_2_5_3) :-
    all_equations([4, 2, 5, 3], Es),
    Es == ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
           "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"].

test(count_equations_4_2_5_3) :-
    count_equations([4, 2, 5, 3], 7).

test(all_equations_2_3_4_empty) :-
    all_equations([2, 3, 4], []).

test(count_equations_2_3_4_zero) :-
    count_equations([2, 3, 4], 0).

test(all_equations_2_4_8) :-
    all_equations([2, 4, 8], ["2*4=8"]).

test(count_equations_2_4_8) :-
    count_equations([2, 4, 8], 1).

test(generate_equation_2_4_8) :-
    generate_equation([2, 4, 8], "2*4=8").

test(generate_equation_4_2_5_3_valid) :-
    generate_equation([4, 2, 5, 3], E),
    member(E, ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
               "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]).

test(generate_equation_2_3_4_fails, [fail]) :-
    generate_equation([2, 3, 4], _).

:- end_tests(p2_examples).

% ---------- Edge Cases (Length 0, 1, and no solution) ----------

:- begin_tests(p2_edge_cases).

test(generate_equation_empty_fails, [fail]) :-
    generate_equation([], _).

test(all_equations_empty) :-
    all_equations([], []).

test(count_equations_empty) :-
    count_equations([], 0).

test(generate_equation_single_fails, [fail]) :-
    generate_equation([7], _).

test(generate_equation_single_zero_fails, [fail]) :-
    generate_equation([0], _).

test(all_equations_single) :-
    all_equations([7], []).

test(count_equations_single) :-
    count_equations([7], 0).

test(two_identical_elements) :-
    all_equations([3, 3], ["3=3"]),
    count_equations([3, 3], 1),
    generate_equation([3, 3], "3=3").

test(two_different_elements_no_eq) :-
    all_equations([3, 4], []),
    count_equations([3, 4], 0).

test(zero_operands) :-
    all_equations([0, 0], ["0=0"]),
    generate_equation([0, 0], "0=0").

:- end_tests(p2_edge_cases).

% ---------- Precedence and Canonical Formatting ----------

:- begin_tests(p2_precedence_and_formatting).

test(render_num) :-
    7_q2:render(num(42), 0, top, S),
    S == "42".

test(render_add_mult_left_paren) :-
    % (4+2)*3
    7_q2:render(node('*', node('+', num(4), num(2)), num(3)), 0, top, S),
    S == "(4+2)*3".

test(render_add_mult_no_paren) :-
    % 4+2*3
    7_q2:render(node('+', num(4), node('*', num(2), num(3))), 0, top, S),
    S == "4+2*3".

test(render_div_mult_left_assoc) :-
    % 8/4*2 -> (8/4)*2
    7_q2:render(node('*', node('/', num(8), num(4)), num(2)), 0, top, S),
    S == "8/4*2".

test(render_div_mult_right_paren) :-
    % 8/(4*2)
    7_q2:render(node('/', num(8), node('*', num(4), num(2))), 0, top, S),
    S == "8/(4*2)".

test(render_sub_left_assoc) :-
    % 1-2-3 -> (1-2)-3
    7_q2:render(node('-', node('-', num(1), num(2)), num(3)), 0, top, S),
    S == "1-2-3".

test(render_sub_right_paren) :-
    % 1-(2-3)
    7_q2:render(node('-', num(1), node('-', num(2), num(3))), 0, top, S),
    S == "1-(2-3)".

test(render_add_right_paren) :-
    % 1+(2+3)
    7_q2:render(node('+', num(1), node('+', num(2), num(3))), 0, top, S),
    S == "1+(2+3)".

test(render_add_left_assoc) :-
    % 1+2+3 -> (1+2)+3
    7_q2:render(node('+', node('+', num(1), num(2)), num(3)), 0, top, S),
    S == "1+2+3".

:- end_tests(p2_precedence_and_formatting).

% ---------- Division Safety and Negative Sub-Expressions ----------

:- begin_tests(p2_division_and_negatives).

test(exact_division_only) :-
    % 12/3=4 and 12=3*4 are valid; 7/2 is inexact
    all_equations([12, 3, 4], Es),
    Es == ["12/3=4", "12=3*4"],
    all_equations([7, 2, 3], []).

test(negative_subexpression_allowed) :-
    % 1-5 = -4 and 2-6 = -4
    all_equations([1, 5, 2, 6], Es),
    member("1-5=2-6", Es).

test(division_by_zero_avoided) :-
    % Sub-expression evaluating to 0 as denominator must not crash
    all_equations([4, 2, 2, 1], Es),
    is_list(Es).

:- end_tests(p2_division_and_negatives).
