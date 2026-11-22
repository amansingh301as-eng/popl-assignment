% Q2 - group 7
% Form a Valid Arithmetic Equation
% Given a list of non-negative integers, insert +, -, *, / and exactly one =
% between the numbers (in order) so that both sides have the same integer value.

:- use_module(library(lists)).

% ---------- Arithmetic Evaluation ----------

% compute(+Op, +A, +B, -Val)
% Val is the integer result of applying arithmetic operator Op (+, -, *, /)
% to integer operands A and B.
% Division is permitted only when exact (remainder 0) and divisor is non-zero.
compute('+', A, B, Val) :- Val is A + B.
compute('-', A, B, Val) :- Val is A - B.
compute('*', A, B, Val) :- Val is A * B.
compute('/', A, B, Val) :- B =\= 0, 0 is A mod B, Val is A // B.

% ---------- Expression Generation & Evaluation ----------

% expr(+Numbers, -Tree, -Value)
% Constructs an expression Tree over a contiguous non-empty list of Numbers
% and evaluates it to integer Value.
% Tree is num(N) for a base number or node(Op, Left, Right) for an operation.
expr([N], num(N), N) :-
    integer(N),
    N >= 0.
expr(Ns, node(Op, L, R), Value) :-
    append(Left, Right, Ns),
    Left \= [],
    Right \= [],
    expr(Left, L, A),
    expr(Right, R, B),
    compute(Op, A, B, Value).

% ---------- Canonical String Formatting ----------

% precedence(+Op, -Prec)
% Precedence levels: * and / have precedence 2; + and - have precedence 1.
precedence('+', 1).
precedence('-', 1).
precedence('*', 2).
precedence('/', 2).

% render(+Tree, +ParentPrec, +Side, -Text)
% Formats Tree into canonical string Text without spaces.
% Side is one of top, left, or right.
% Parentheses rules:
% - Single numbers are never in parentheses.
% - A left operand is parenthesized only if its operator has lower precedence than parent.
% - A right operand is parenthesized if its operator has equal or lower precedence than parent.
render(num(N), _, _, Text) :-
    number_string(N, Text).
render(node(Op, L, R), ParentPrec, Side, Text) :-
    precedence(Op, Prec),
    render(L, Prec, left, LS),
    render(R, Prec, right, RS),
    atom_string(Op, OS),
    string_concat(LS, OS, LeftOp),
    string_concat(LeftOp, RS, Core),
    (   (Prec < ParentPrec ; (Side == right, Prec =:= ParentPrec))
    ->  string_concat('(', Core, Temp),
        string_concat(Temp, ')', Text)
    ;   Text = Core
    ).

% ---------- Equation Formation ----------

% valid_equation(+List, -Equation)
% Equation is a canonical string "L=R" formed by splitting List into non-empty
% Left and Right sublists, where expressions over Left and Right evaluate
% to the same integer value.
valid_equation(List, Equation) :-
    append(Left, Right, List),
    Left \= [],
    Right \= [],
    expr(Left, LT, LV),
    expr(Right, RT, RV),
    LV =:= RV,
    render(LT, 0, top, LS),
    render(RT, 0, top, RS),
    string_concat(LS, '=', Prefix),
    string_concat(Prefix, RS, Equation).
