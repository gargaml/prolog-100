my_last(X,[X]).

my_last(X,[_|T]) :-
    my_last(X,T).

element_at(X,[X|_],0).

element_at(X,[_|T],N) :-
    M is N - 1,
    element_at(X,T,M).

my_length([],0).

my_length([_|T],M) :-
    length(T,N),
    M is N+1.

my_rev(L,R) :-
    my_rev(L,[],R).

my_rev([],Acc,Acc).

my_rev([H|T],Acc,R) :-
    my_rev(T,[H|Acc],R).

not_last([_],[]).

not_last([H|T],[H|R]) :-
    not_last(T,R).

palindrome([]).

palindrome([_]).

palindrome([H|T]) :-
    my_last(H,T),
    not_last(T,R),
    palindrome(R).

palindrome_simple(L) :-
    my_rev(L,L).

my_flatten([],[]).

my_flatten([H|T],[H|B]) :-
    not(is_list(H)),
    my_flatten(T,B).

my_flatten([H|T],B) :-
    is_list(H),
    append(H,T,R),
    my_flatten(R,B).

eliminate([],[]).

eliminate([H|T],[H|R]) :-
    eliminate(T,H,R).

eliminate([],_,[]).

eliminate([H|T],H,R) :-
    eliminate(T,H,R).

eliminate([H|T],I,[H|R]) :-
    H \= I,
    eliminate(T,H,R).

pack([],[]).

pack([X],[[X]]).

pack([H|T],[[H|[H|TR]]|R]) :-
    pack(T,[[H|TR]|R]).
    
pack([H|T],[[H]|[[I|TR]|R]]) :-
    pack(T,[[I|TR]|R]),
    H \= I.

encode([],[]).

encode([X],[[X,1]]).

encode([H|T],[[H,M]|R]) :-
    encode(T,[[H,N]|R]),
    M is N+1.
    
encode([H|T],[[H,1]|[[I,N]|R]]) :-
    encode(T,[[I,N]|R]),
    H \= I.

