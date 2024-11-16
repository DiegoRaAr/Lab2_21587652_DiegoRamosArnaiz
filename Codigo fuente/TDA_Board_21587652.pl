:- use_module("Funciones_Auxiliares_21587652.pl").

% Predicado para crear un tablero de Conecta4.
% Dom: Void
% board \1
board([F1,F2,F3,F4,F5,F6]) :-
	F1 = [0,0,0,0,0,0,0],
	F2 = [0,0,0,0,0,0,0],
	F3 = [0,0,0,0,0,0,0],
	F4 = [0,0,0,0,0,0,0],
	F5 = [0,0,0,0,0,0,0],
	F6 = [0,0,0,0,0,0,0].


% Predicado que permite verificar si se puede realizar más jugadas en el
% tablero.
% Dom: board (board)
% can_play \1
can_play([Car|_]):-
	member( 0 , Car), !.
can_play([_|Cdr]):-
    can_play(Cdr).


% Predicado que permite jugar una ficha en el tablero
% Dom: Board (board) X Column (int) X Piece (piece) X NewBoard (board)
% Tipo: recursivo
% play_piece \5

play_piece([],_,_,_):- fail.
play_piece(Board, Col, Piece, NewBoard):-
    len(Board,Largo),
    Largo > 1,
    reverse(Board, RBoard),
    car(RBoard, CarBoardRev),
    cdr(RBoard, CdrBoardRev),
    se_puede_jugar(CarBoardRev, Col),
    jugar_ficha(CarBoardRev, Piece, Col, CarBoardJugado),
    cons([CarBoardJugado],CdrBoardRev,RevNewBoard),
    reverse(RevNewBoard, NewBoard), !.

play_piece([Car|Cdr], Col, Piece, NewBoard):-
    len([Car|Cdr],Largo),
    Largo > 1,
    reverse([Car|Cdr], TableroRev),
    cdr(TableroRev,CdrTableroRev),
    reverse(CdrTableroRev,TableroSinUltima),
    car(TableroRev,CarTableroRev),
    play_piece(TableroSinUltima,Col,Piece,Piezajugada),
    cons(Piezajugada,[CarTableroRev], NewBoard), !.

play_piece([Car|_], Col, Piece, [NewBoard]):-
    se_puede_jugar(Car, Col),
    jugar_ficha(Car, Piece, Col, NewBoard), !.


% Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma vertical.
% Dom: board (board) X int(1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical)
% check_vertical_win \2
check_vertical_win(Board, Int):-
    verticalParte1(Board, 0,0,Int), !.
check_vertical_win(Board,Int):-
    mapCdr(Board,CdrBoard),
    check_vertical_win(CdrBoard,Int), !.
check_vertical_win(_,0):- !.


% Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma horizontal.
% Dom: board (board), int (1 si gana jugador 1, 2 si gana jugador 2, 0si no hay ganador vertical)
% check_horizontal_win \2
check_horizontal_win([Car|_],Int):-
    horizontalParte1(Car, 0, 0, Int),!.
check_horizontal_win([_|Cdr],Int):-
    check_horizontal_win(Cdr, Int),!.
check_horizontal_win([],0):- !.




diagonalParte1(_, 4, _, 1).
diagonalParte1(_, _, 4, 2).
diagonalParte1([Car|Cdr], ContRed, _, Int):-
    car(Car, CarFila),
    CarFila = "red",
    mapCdr(Cdr, TableroPequeño),
    Cont2 is ContRed + 1,
    diagonalParte1(TableroPequeño, Cont2, 0, Int).
diagonalParte1([Car|Cdr], _, ContYell, Int):-
    car(Car, CarFila),
    CarFila = "yellow",
    mapCdr(Cdr, TableroPequeño),
    Cont2 is ContYell + 1,
    diagonalParte1(TableroPequeño, 0, Cont2, Int).
diagonalParte1([Car|Cdr], _, _, Int):-
    car(Car, CarFila),
    CarFila = 0,
    mapCdr(Cdr, TableroPequeño),
    diagonalParte1(TableroPequeño, 0, 0, Int).



diagonalParte2(Board, Int):-
    diagonalParte1(Board, 0, 0, Int).
diagonalParte2(Board, Int):-
    mapCdr(Board, CdrBoard),
    diagonalParte2(CdrBoard, Int).


check_diagonal_win([],0).
check_diagonal_win([Car|_],Int):-
    diagonalParte2(Car,Int).
check_diagonal_win([_|Cdr],Int):-
    check_diagonal_win(Cdr,Int).
