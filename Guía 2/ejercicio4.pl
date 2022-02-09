quitar([], _, []). 
quitar([E| Ls], E, Ls).
quitar([L | Ls], E, [L | R]):-
    not(igual(L, E)),
    member(E, Ls),
    quitar(Ls, E, R), !.

nMayores(L,1,[X]):-
    mayorLista(L,X).

nMayores(L,N,[X|Xs]):-
    mayorLista(L,X),
    quitar(L,X,L1),
    M is N-1,
    nMayores(L1,M,Xs).

mayorLista([X],X).
mayorLista([L, X | Ls], M):-
    L>=X,
    mayorLista([L|Ls],M).
mayorLista([L, X | Ls], M):-
    X>L,
    mayorLista([X|Ls],M).

igual(A,A).