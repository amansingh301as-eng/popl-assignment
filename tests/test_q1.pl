:- consult('../code/id_q1.pl').

run_tests :-
    count_solutions([1,2,3,4,5,6,7,8],3),
    count_solutions([1,2,3,4,5,6,7,8,9],1),
    count_solutions([],13824),
    solution(S), satisfies([1,2,3,4,5,6,7,8,9],S),
    S = [p('Alex',design,java,embedded),
         p('Ben',development,javascript,web),
         p('Carla',testing,python,'AI'),
         p('Dana',research,'c++',data)],
    writeln('P1 OK').
