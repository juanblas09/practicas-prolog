% Ordena una lista según el algoritmo "quicksort"
% Uso: qsort(Lista,ListaOrdenada).

% https://www.youtube.com/watch?v=JCcNT5KfIl8

qsort([],[]).

qsort([X|Xs],LO):-
    particion(X,Xs,Menores,Mayores),
    qsort(Menores,MenoresOrdenados),
    qsort(Mayores,MayoresOrdenados),
    append(MenoresOrdenados,[X|MayoresOrdenados],LO).

particion(_,[],[],[]).

particion(P,[X|Xs],[X|Menores],Mayores):-
    P >= X,
    particion(P,Xs,Menores,Mayores).

particion(P,[X|Xs],Menores,[X|Mayores]):-
    P < X,
    particion(P,Xs,Menores,Mayores).
