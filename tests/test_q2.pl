:- consult('../code/id_q2.pl').

run_tests :-
    all_equations([4,2,5,3],
      ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
       "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]),
    all_equations([2,3,4],[]),
    all_equations([2,4,8],["2*4=8"]),
    all_equations([],[]),
    all_equations([7],[]),
    count_equations([4,2,5,3],7),
    \+ generate_equation([], _),
    \+ generate_equation([3], _),
    generate_equation([2,4,8],"2*4=8"),
    writeln('P2 OK').
