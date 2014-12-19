and(A,B) :- A,B.

or(A,_) :- A.
or(_,B) :- B.

nand(A,B) :- not(and(A,B)).

nor(A,B) :- not(or(A,B)).

xor(A,B) :- not(equ(A,B)).

impl(A,_) :- not(A).
impl(A,B) :- A,B.

equ(A,B) :- A,B.
equ(A,B) :- not(A),not(B).

pick(true).
pick(false).

pickL([H]) :-
    pick(H).

pickL([H|T]) :-
    pick(H),
    pickL(T).

table(Xs,F) :-
    pickL(Xs),
    eval(Xs,F),
    fail.

printXs([]).
printXs([H|T]) :- write(H), write(' '), printXs(T).
    
eval(L,_) :- printXs(L), fail.
eval(_,F) :- F, !, write(true), nl.
eval(_,_) :- write(false), nl.

gray(
