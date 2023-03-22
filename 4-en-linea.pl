columna(1).
columna(2).
columna(3).
columna(4).
columna(5).
columna(6).
columna(7).

%   1)

tableroInicial([[-,-,-,-,-,-,-],
                [-,-,-,-,-,-,-],
                [-,-,-,-,-,-,-], 
                [-,-,-,-,-,-,-],
                [-,-,-,-,-,-,-],
                [-,-,-,-,-,-,-]]).
% --------------------------------------------------------------------------------------
%   2)

ingresarFicha([T, T1 | Ts], Columna, Ficha, [X, T1 | Ts]) :- columnaDisp([T, T1 | Ts], Columna), not(noExisteFicha(T1, Columna)),!, filaAtPut(T, Columna, Ficha, X).
ingresarFicha([T], Columna, Ficha,  [T1]) :- filaAtPut(T, Columna, Ficha, T1), !.
ingresarFicha([T | Ts], Columna, Ficha, [T | TR]) :- noExisteFicha(T, Columna), ingresarFicha(Ts, Columna, Ficha, TR).
% --------------------------------------------------------------------------------------
%   3)

columnaDisp([T | _], Columna) :- noExisteFicha(T, Columna).
columnaDisp([T | Ts], Columna) :- not(noExisteFicha(T, Columna)), columnaDisp(Ts, Columna).
% --------------------------------------------------------------------------------------
%   4)

contenido([T| _], [1, Y], F) :- filaAt(T, Y, F).
contenido([_ | Ts], [X, Y], F) :- contenido(Ts, [X2, Y], F), X is X2 + 1.
% --------------------------------------------------------------------------------------

%   5)

conecta4(T, F, ListaPos) :- conecta4Hori(T, F, ListaPos), !.
conecta4(T, F, ListaPos) :- conecta4Verti(T, F, ListaPos), !.
conecta4(T, F, ListaPos) :- conecta4DI(T, F, ListaPos), !.
conecta4(T, F, ListaPos) :- conecta4ID(T, F, ListaPos).

%   HORIZONTAL
conecta4Hori([T | _], F, [[1, L1], [1, L2], [1, L3], [1, L4]]) :- iguales4(T, F, [L1, L2, L3, L4]).
conecta4Hori([T | Ts], F, [[X, Y1], [X, Y2], [X, Y3], [X, Y4] ]) :-  not(iguales4(T, F, _)), conecta4(Ts, F, [[X1, Y1], [X1, Y2], [X1, Y3], [X1, Y4]]), X is X1+1.

iguales4([D, D, D, D | _], D, [1,2,3,4]) :- not(igual(D, -)), !.
iguales4([_ | Fs], D, [N1, N2, N3, N4]) :- iguales4(Fs, D, [N11, N22, N33, N44]), N1 is N11+1, N2 is N22+1, N3 is N33+1, N4 is N44+1.


%   VERTICAL
conecta4Verti(T, F, [[L1, X], [L2, X], [L3, X], [L4, X]]) :- conseguirColumna(T, X, 6, C1), iguales4(C1, F, [L1, L2, L3, L4]).


%   DIAGONALES NEGATIVAS
conecta4DI(T, F, ListaPos) :- obtDiagSec(T, ListaPos, [F | _]).
obtDiagPrin(Matriz, [[X, Y], [X1, Y1], [X2, Y2], [X3, Y3]], [L, L, L, L]) :- contenido(Matriz, [X, Y], L), not(igual(L, -)), contenido(Matriz, [X1, Y1], L), contenido(Matriz, [X2, Y2], L), contenido(Matriz, [X3, Y3], L),
                                            X1 is X + 1, X2 is X + 2, X3 is X+ 3,Y1 is Y + 1, Y2 is Y + 2, Y3 is Y + 3, !.
obtDiagPrin(_, [6, _], _) :- !, fail.
obtDiagPrin(_, [_, 7], _) :- !, fail.
obtDiagPrin(Matriz, [X, Y], Ls) :- obtDiagPrin(Matriz, [X1, Y], Ls), X1 is X + 1.
obtDiagPrin(Matriz, [X, Y], Ls) :- obtDiagPrin(Matriz, [X, Y1], Ls), Y1 is Y + 1.


%   DIAGONALES POSITIVAS
conecta4ID(T, F, ListaPos) :- obtDiagPrin(T, ListaPos, [F | _]).
obtDiagSec(Matriz, [[X, Y], [X1, Y1], [X2, Y2], [X3, Y3]], [L, L, L, L]) :- contenido(Matriz, [X, Y], L), not(igual(L, -)), contenido(Matriz, [X1, Y1], L), contenido(Matriz, [X2, Y2], L), contenido(Matriz, [X3, Y3], L),
                                            X1 is X + 1, X2 is X + 2, X3 is X+ 3,Y1 is Y - 1, Y2 is Y - 2, Y3 is Y - 3, !.
obtDiagSec(_, [6, _], _) :- !, fail.
obtDiagSec(_, [_, 1], _) :- !, fail.
obtDiagSec(Matriz, [X, Y], Ls) :- X < 6, obtDiagSec(Matriz, [X1, Y], Ls), X1 is X + 1.
obtDiagSec(Matriz, [X, Y], Ls) :- Y > 1, obtDiagSec(Matriz, [X, Y1], Ls), Y1 is Y - 1.
% --------------------------------------------------------------------------------------

%   6)

empate(T) :- not(conecta4(T, _, _)), not(todasColumnasDisp(T, 1)).

todasColumnasDisp(_, 8) :- !, fail. 
todasColumnasDisp(M, X) :- columnaDisp(M, X).
todasColumnasDisp(M, X) :- todasColumnasDisp(M, X1), X1 is X+1.
% --------------------------------------------------------------------------------------

%   7)

jugadaGanadora(T, F, Columna) :- columna(Columna), ingresarFicha(T, Columna, F, TR), conecta4(TR, F, _).
% --------------------------------------------------------------------------------------

%   8)

jugadaSegura(T, a, Columna) :- columna(Columna),  ingresarFicha(T, Columna, a, TR), not(jugadaGanadora(TR, b, _)). 
jugadaSegura(T, b, Columna) :- columna(Columna), ingresarFicha(T, Columna, b, TR), not(jugadaGanadora(TR, a, _)).
% --------------------------------------------------------------------------------------

%   9)

jugadaDefinitiva(T, a, Columna) :- columna(Columna), ingresarFicha(T, Columna, a, TR), not(jugadaSegura(TR, b, _)), not(jugadaGanadora(T, a, Columna)).
jugadaDefinitiva(T, b, Columna) :- columna(Columna), ingresarFicha(T, Columna, b, TR), not(jugadaSegura(TR, a, _)), not(jugadaGanadora(T, b, Columna)).
% --------------------------------------------------------------------------------------

%   AUXILIARES
conseguirColumna([F], N, 1, [T]) :- filaAt(F, N, T).
conseguirColumna([F | Fs], N, C, [T | Ts]) :- filaAt(F, N, T), conseguirColumna(Fs, N, C1, Ts), C is C1+1.

ultimaFila([_ | []], 1).
ultimaFila([_ | Fs], N) :- ultimaFila(Fs, N2), N is N2+1.

conseguirUltimaFila([M | []], M).
conseguirUltimaFila([_M | Ms], F) :- conseguirUltimaFila(Ms, F).

insertar([F | Fs], 1, C, D, [R | Fs]) :- filaAtPut(F, C, D, R).
insertar([F | Fs], Fila, C, D, [F | MR]) :- F2 is Fila-1, insertar(Fs, F2, C, D, MR).

filaAtPut([_ | Xs], 1, D, [D | Xs]).
filaAtPut([X | Xs], Pos, D, [X | L]) :- Pos2 is Pos-1, filaAtPut(Xs, Pos2, D, L).

noExisteFicha([X | _], 1) :- igual(X, -).
noExisteFicha([X | Xs], Pos) :- filaAt([X | Xs], Pos, C), igual(C, -), noExisteFicha(Xs, Pos2), Pos is Pos2+1.

filaAt([C| _], 1, C).
filaAt([_ | Xs], Pos, C) :- filaAt(Xs, Pos2, C), Pos is Pos2+1.

not(P) :- P, !, fail.
not(_).

igual(A, A).
