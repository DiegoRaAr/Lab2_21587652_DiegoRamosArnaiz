:- module(funciones_auxiliares, [len/2, car/2, cdr/2, cons/3, get_fila1/2, get_fila2/2, get_fila3/2, get_fila4/2, get_fila5/2, get_fila6/2, jugar_ficha/4,se_puede_jugar/2, mapCdr/2, verticalParte1/4, horizontalParte1/4]).

len([], 0).
len([_|T], N) :-
    len(T, N1),
    N is N1 + 1.

% CAR
car([Primero | _], Primero).

% CDR
cdr([_|Resto], Resto).

% CONS
cons([], Lst2, Lst2).  % Caso base
%if
cons([Head|Tail], Lst2, [Head|LstOut]) :-
    cons(Tail, Lst2, LstOut).


% Caso base. IF
pertenece(Elemento, [Elemento|_]):- !.
% Else
pertenece(Elemento, [_|Resto]) :-
    pertenece(Elemento, Resto).


get_fila1([Fila1,_,_,_,_,_],Fila1).
get_fila2([_,Fila2,_,_,_,_],Fila2).
get_fila3([_,_,Fila3,_,_,_],Fila3).
get_fila4([_,_,_,Fila4,_,_],Fila4).
get_fila5([_,_,_,_,Fila5,_],Fila5).
get_fila6([_,_,_,_,_,Fila6],Fila6).




jugar_ficha(Fila, Ficha, 0, [Ficha|Cdr]):-
    cdr(Fila,Cdr).
jugar_ficha(Fila, Ficha, Pos, Retorno):-
    cdr(Fila,Cdr),
    car(Fila,Car),
    Pos2 is Pos - 1,
    jugar_ficha(Cdr,Ficha,Pos2,Var),
    Retorno = [Car|Var].

se_puede_jugar([0|_],0).
se_puede_jugar([_|Cola],Pos):-
               Pos2 is Pos -1,
               se_puede_jugar(Cola,Pos2).


mapCdr(Board,NewBoard):-
    get_fila1(Board,Fila1),
    get_fila2(Board,Fila2),
    get_fila3(Board,Fila3),
    get_fila4(Board,Fila4),
    get_fila5(Board,Fila5),
    get_fila6(Board,Fila6),
    cdr(Fila1, CFila1),
    cdr(Fila2, CFila2),
    cdr(Fila3, CFila3),
    cdr(Fila4, CFila4),
    cdr(Fila5, CFila5),
    cdr(Fila6, CFila6),
    NewBoard = [CFila1,CFila2,CFila3,CFila4,CFila5,CFila6].

verticalParte1(_,4,_,1):- !.
verticalParte1(_,_,4,2):- !.
verticalParte1([Car|Cdr], ContRed, _, Int):-
    car(Car, CarFila),
    CarFila = "red",
    ContRed2 is ContRed + 1,
    verticalParte1(Cdr, ContRed2, 0, Int).
verticalParte1([Car|Cdr], _,ContYell, Int):-
    car(Car, CarFila),
    CarFila = "yellow",
    ContYell2 is ContYell + 1,
    verticalParte1(Cdr, 0, ContYell2, Int).
verticalParte1([Car|Cdr], _,_, Int):-
    car(Car, CarFila),
    CarFila = 0,
    verticalParte1(Cdr, 0, 0, Int).


horizontalParte1(_, 4, _, 1):- !.
horizontalParte1(_, _, 4, 2):- !.
horizontalParte1([Car|Cdr], ContRed, _, Int):-
    Car = "red",
    ContRed2 is ContRed + 1,
    horizontalParte1(Cdr, ContRed2, 0, Int).
horizontalParte1([Car|Cdr], _, ContYell, Int):-
    Car = "yellow",
    ContYell2 is ContYell + 1,
    horizontalParte1(Cdr, 0, ContYell2, Int).
horizontalParte1([Car|Cdr],_,_,Int):-
    Car = 0,
    horizontalParte1(Cdr, 0, 0, Int).
