:- use_module(library(lists)).

% Every department, language, and project is used exactly once.
solution([p('Alex',DA,LA,PA),p('Ben',DB,LB,PB),
          p('Carla',DC,LC,PC),p('Dana',DD,LD,PD)]) :-
    permutation([research,development,design,testing],[DA,DB,DC,DD]),
    permutation([python,java,'c++',javascript],[LA,LB,LC,LD]),
    permutation(['AI',web,embedded,data],[PA,PB,PC,PD]).

clue(1, S) :- member(p(Name,Dept,_,'AI'),S), Name \= 'Dana', Dept \= research.
clue(2, S) :- member(p('Alex',Dept,Lang,_),S), Dept \= development, Lang \= 'c++'.
clue(3, S) :- member(p(_,testing,python,_),S).
clue(4, S) :- member(p('Ben',Dept,_,web),S), Dept \= testing.
clue(5, S) :- member(p(_,design,java,_),S).
clue(6, S) :- member(p('Carla',Dept,_,Project),S), Project \= embedded, Dept \= development.
clue(7, S) :- member(p('Dana',Dept,Lang,_),S), Lang \= java,
                (Dept = research ; Dept = testing).
clue(8, S) :- member(p(_,research,Lang,data),S), Lang \= javascript.
% CLUE 9: The friend who prefers the AI project works in testing.
clue(9, S) :- member(p(_,testing,_,'AI'),S).

satisfies([], _).
satisfies([N|Ns], S) :- clue(N,S), satisfies(Ns,S).

count_solutions(Active,N) :-
    findall(S, (solution(S),satisfies(Active,S)), Solutions),
    length(Solutions,N).

main :-
    solution(S), satisfies([1,2,3,4,5,6,7,8,9],S), !,
    print_solution(S).

print_solution([]).
print_solution([p(Name,Dept,Lang,Project)|Rest]) :-
    format('~w = [~w, ~w, ~w]~n',[Name,Dept,Lang,Project]),
    print_solution(Rest).
