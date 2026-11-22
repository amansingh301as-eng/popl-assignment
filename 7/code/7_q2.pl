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
