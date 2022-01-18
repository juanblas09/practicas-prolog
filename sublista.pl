% Chequea si los elementos de una lista están presente en la otra
% Se usa miembro(X,L) de miembro.pl
% Uso: sublist(L1,L2) donde L1 es sublista de L2

sublist([],_L2):-!.
sublist([X|Xs],L2):-miembro(X,L2),sublist(Xs,L2).
