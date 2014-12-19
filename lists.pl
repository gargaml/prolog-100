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

dupli([],[]).

dupli([H|T],[H|[H|R]]) :-
    dupli(T,R).

build(_,0,[]).

build(X,N,[X|R]) :-
    N \= 0,
    M is N - 1,
    build(X,M,R).

dupli2([],_,[]).

dupli2([H|T],N,S) :-
    dupli2(T,N,R),
    build(H,N,L),
    append(L,R,S).

dropN([],_,[]).

dropN([_|T],1,T).

dropN([H|T],N,[H|R]) :-
    M is N - 1,
    dropN(T,M,R).

drop([],_,[]).

drop([H|T],N,R) :-
    drop([H|T],N,N,R).

drop([],_,_,[]).

drop([_|T],1,P,R) :-
    drop(T,P,P,R).

drop([H|T],N,P,[H|R]) :-
    N \= 1,
    M is N - 1,
    drop(T,M,P,R).

split([],_,[],[]).

split(L,0,[],L).

split([H|T],N,[H|L1],L2) :-
    N \= 0,
    M is N - 1,
    split(T,M,L1,L2).

slice([],_,_,[]).

slice([H|T],L,U,R) :-
    slice([H|T],1,L,U,R).

slice([],_,_,_,[]).

slice([H|_],I,_,I,[H]).

slice([H|T],I,L,U,[H|R]) :-
    I >= L,
    J is I + 1,
    slice(T,J,L,U,R).

slice([_|T],I,L,U,R) :-
    I < L,
    J is I + 1,
    slice(T,J,L,U,R).

rotate(L,N,R) :-
    length(L,Lth),
    F is (Lth + N) mod Lth,
    split(L,F,A,B),
    append(B,A,R).
    
remove_at([],_,_,[]).

remove_at([H|T],1,H,T).

remove_at([H|T],I,X,[H|R]) :-
    I \= 0,
    J is I - 1,
    remove_at(T,J,X,R).

insert_at(X,[],1,[X]).

insert_at(X,[H|T],1,[X|[H|T]]).

insert_at(X,[H|T],N,[H|R]) :-
    M is N - 1,
    insert_at(X,T,M,R).

range(U,L,[]) :-
    U > L.

range(U,U,[U]).

range(L,U,[L|R]) :-
    L < U,
    V is L + 1,
    range(V,U,R).

pick(A,X,R) :-
    length(A,L),
    random_between(1,L,P),
    remove_at(A,P,X,R).

rnd_select(_,0,[]).

rnd_select([H|T],N,[X|R]) :-
    N > 0,
    M is N - 1,
    pick([H|T],X,S),
    rnd_select(S,M,R).

lotto(N,M,R) :-
    range(1,M,L),
    rnd_select(L,N,R).

rnd_permu(L,R) :-
    length(L,N),
    rnd_select(L,N,R).

combination(0,_,[]).

combination(N,[H|T],[H|R]) :-
    N > 0,
    M is N - 1,
    combination(M,T,R).

combination(N,[_|T],R) :-
    N > 0,
    combination(N,T,R).

