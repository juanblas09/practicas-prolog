% Chequea si un elemento pertenece a la lista
% Uso: miembro(elemento, lista).

miembro(X,[X|_]):-!.
miembro(X,[_|L]):-miembro(X, L).
