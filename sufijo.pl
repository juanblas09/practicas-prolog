% Chequea si dos listas terminan igual, es decir, L1 en algun momento es igual a la cola de L2
% Uso: sufix(L1,L2). donde L1 es sufijo de L2

sufix(Xs,Xs):-!.
sufix(L1,[_|Ls]):-sufix(L1,Ls).
