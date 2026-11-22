:- use_module(library(lists)).

% Each expr is constructed over a contiguous nonempty slice of input.
% Values are integers; division must be exact at EVERY internal node.
expr([N], num(N), N) :- integer(N), N >= 0.
expr(Ns, node(Op,L,R), Value) :-
    append(Left,Right,Ns), Left \= [], Right \= [],
    expr(Left,L,A), expr(Right,R,B),
    compute(Op,A,B,Value).

compute('+',A,B,V) :- V is A+B.
compute('-',A,B,V) :- V is A-B.
compute('*',A,B,V) :- V is A*B.
compute('/',A,B,V) :- B =\= 0, 0 is A mod B, V is A // B.

precedence('+',1).
precedence('-',1).
precedence('*',2).
precedence('/',2).

% side = left/right/top; right children with equal precedence need ()
render(num(N),_,_,Text) :- number_string(N,Text).
render(node(Op,L,R),ParentPrec,Side,Text) :-
    precedence(Op,Prec),
    render(L,Prec,left,LS),
    render(R,Prec,right,RS),
    atom_string(Op,OS),
    string_concat(LS,OS,Start),
    string_concat(Start,RS,Core),
    ( (Prec < ParentPrec ; (Side == right, Prec =:= ParentPrec)) ->
        string_concat('(',Core,A), string_concat(A,')',Text)
    ;   Text = Core
    ).

valid_equation(List,Equation) :-
    append(Left,Right,List), Left \= [], Right \= [],
    expr(Left,LT,LV), expr(Right,RT,RV), LV =:= RV,
    render(LT,0,top,LS), render(RT,0,top,RS),
    string_concat(LS,'=',Start), string_concat(Start,RS,Equation).

generate_equation(List,Equation) :- valid_equation(List,Equation).

all_equations(List,Equations) :-
    findall(E,valid_equation(List,E),Unsorted),
    sort(Unsorted,Equations).

count_equations(List,N) :- all_equations(List,Es), length(Es,N).
