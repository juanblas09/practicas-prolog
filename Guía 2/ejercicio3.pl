hoja(arbol(_,nil,nil)).

sumahoja(nil,0).

sumahoja(arbol(R,AI,AD),Suma):-
    hoja(arbol(R,AI,AD)),
    Suma is R.

sumahoja(arbol(_,AI,AD),Suma):-
    sumahoja((AI),S1),
    sumahoja((AD),S2),
    Suma is S1+S2,!.