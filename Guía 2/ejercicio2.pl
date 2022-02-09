atomo(X) :- atom(X), !.
atomo(X) :- integer(X), !.

listaAtomos([],[]).

listaAtomos([X|Xs],[X|Ls]):-
    atomo(X),
    listaAtomos(Xs,Ls).

listaAtomos([X|Xs],L):-
    listaAtomos(X,Aux1),
    listaAtomos(Xs,Aux2),
    append(Aux1, Aux2, L).