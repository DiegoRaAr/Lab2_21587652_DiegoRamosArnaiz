board([F1,F2,F3,F4,F5,F6]) :-
	F1 = [1,1,1,0,1,1,1],
	F2 = [0,0,0,0,0,0,0],
	F3 = [0,0,0,0,0,0,0],
	F4 = [0,0,0,0,0,0,0],
	F5 = [0,0,0,0,0,0,0],
	F6 = [0,0,0,0,0,0,0].

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


can_play(Board):-
    get_fila1(Board, Fila1),
    pertenece(0, Fila1).


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
