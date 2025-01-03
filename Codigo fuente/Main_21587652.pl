:- use_module("tda_player_21587652.pl").
:- use_module("tda_game_21587652-7.pl").
:- use_module("Funciones_Auxiliares_21587652.pl").


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF2 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite crear un jugador.
% Dom: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining_pieces (int) X Player
% player/8
player(Id , Name , Color , Wins , Loss , Draws , Rpiece ,
       [Id , Name , Color , Wins , Loss , Draws , Rpiece]).


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF3 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que crea una ficha de Conecta4.
% Dom: color (string)
% piece/2
piece(Color, [Color]).


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF4 %%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF5 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite verificar si se puede realizar m�s jugadas en el
% tablero.
% Dom: board (board)
% can_play \1
can_play([Car|_]):-
	member( 0 , Car), !.
can_play([_|Cdr]):-
    can_play(Cdr).


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF6 %%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF7 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma vertical.
% Dom: board (board) X int(1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical)
% check_vertical_win \2
check_vertical_win(Board, Int):-
    verticalParte1(Board, 0,0,Int), !.
check_vertical_win(Board,Int):-
    mapCdr(Board,CdrBoard),
    check_vertical_win(CdrBoard,Int), !.
check_vertical_win(_,0):- !.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF8 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma horizontal.
% Dom: board (board), int (1 si gana jugador 1, 2 si gana jugador 2, 0si no hay ganador vertical)
% check_horizontal_win \2
check_horizontal_win([Car|_],Int):-
    horizontalParte1(Car, 0, 0, Int),!.
check_horizontal_win([_|Cdr],Int):-
    check_horizontal_win(Cdr, Int),!.
check_horizontal_win([],0):- !.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF9 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite verificar el estado actual del tablero y
% entregar el posible ganador que cumple con la regla de conectar 4
% fichas de forma diagonal.
% Dom: board (board) X int (1 si gana jugador
% 1, 2 si gana jugador 2, 0 si no hay ganador vertical)
% check_diagonal_win/2
check_diagonal_win([],0):-!.
check_diagonal_win(Board,Int):-
    diagonalParte2(Board,Int),!.
check_diagonal_win(Board,Int):-
    reverse(Board,ReversedBoard),
    diagonalParte2(ReversedBoard,Int),!.
check_diagonal_win(Board,Int):-
    cdr(Board,Cdr),
    check_diagonal_win(Cdr,Int),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF10 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma diagonal.
% Dom: board (Board) X Int (1,2 o 0)
% who_is_winner/2
who_is_winner(Board, Int):-
    check_vertical_win(Board, IntVer),
    (IntVer = 1; IntVer = 2),
    Int is IntVer, !.
who_is_winner(Board,Int):-
    check_horizontal_win(Board, IntHor),
    (IntHor = 1; IntHor = 2),
    Int is IntHor, !.
who_is_winner(Board,Int):-
    check_diagonal_win(Board, IntDia),
    (IntDia = 1; IntDia = 2),
    Int is IntDia, !.
who_is_winner(_,0):- !.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF11 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que permite crear una nueva partida.
% Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
% game/5
game(P1,P2,Board,Current_turn, [P1,P2,Board,Current_turn,History]):-
    History = [].


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF12 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que genera un historial de movimientos de la partida.
% Dom: game (game)
% game_history/2
game_history([_,_,_,_,History],History).


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF13 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que verifica si el estado actual del juego es empate.
% Dom: game (game)
% is_draw/1
is_draw(Game):-
    get_P1(Game,Player1),
    get_P2(Game,Player2),
    get_Rpiece(Player1,Piezas1),
    get_Rpiece(Player2,Piezas2),
    Piezas1 = 0,
    Piezas2 = 0,!.
is_draw(Game):-
    game_get_board(Game,Board),
    not(can_play(Board)),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF14 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que actualiza las estad�sticas del jugador, ya sea victoria, derrotas o empates.
% Dom: Player (player) x Str (str)
% update_stats/3

update_stats([Id,Name,Color,Wins, Loss, Draw, Rpiece], "win" , [Id,Name,Color,NewWins, Loss, Draw, Rpiece]):-
    NewWins is Wins + 1,!.
update_stats([Id,Name,Color,Wins, Loss, Draw, Rpiece], "loss" , [Id,Name,Color,Wins, NewLoss, Draw, Rpiece]):-
    NewLoss is Loss + 1,!.
update_stats([Id,Name,Color,Wins, Loss, Draw, Rpiece], "draw" , [Id,Name,Color,Wins, Loss, NewDraw, Rpiece]):-
    NewDraw is Draw + 1,!.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF15 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que obtiene el jugador cuyo turno est� en curso.
% Dom: game (game)
% get_current_player/2
get_current_player(Game,Player):-
    get_P1(Game,Player1),
    get_P2(Game,Player2),
    get_Rpiece(Player1,Piezas1),
    get_Rpiece(Player2,Piezas2),
    Piezas1 >= Piezas2,
    Player = Player1, !.
get_current_player(Game,Player):-
    get_P2(Game,Player2),
    Player = Player2, !.


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF16 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que entrega por pantalla el estado actual del tablero en el juego.
% Game X Board
% game_get_board/2
game_get_board(Game,Board):-
    get_board(Game,Board).


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF17 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado finaliza el juego actualizando las estad�sticas de los jugadores seg�n el resultado.
% Dom: Game(game)
% end_game/2
end_game(Game, [Jugador1,Jugador2,Board,0,Historial] ):-
    game_get_board(Game, Board),
    game_history(Game,Historial),
    is_draw(Game),
    get_P1(Game,P1),
    get_P2(Game,P2),
    update_stats(P1, "draw", Jugador1),
    update_stats(P2, "draw",Jugador2),!.
end_game(Game, [Jugador1,Jugador2,Board,0,Historial] ):-
    game_get_board(Game, Board),
    game_history(Game,Historial),
    who_is_winner(Board,Ganador),
    Ganador = 1,
    get_P1(Game,P1),
    get_P2(Game,P2),
    update_stats(P1, "win", Jugador1),
    update_stats(P2, "loss",Jugador2),!.
end_game(Game, [Jugador1,Jugador2,Board,0,Historial] ):-
    game_get_board(Game, Board),
    game_history(Game,Historial),
    who_is_winner(Board,Ganador),
    Ganador = 2,
    get_P1(Game,P1),
    get_P2(Game,P2),
    update_stats(P1, "loss", Jugador1),
    update_stats(P2, "win",Jugador2).


%%%%%%%%%%%%%%%%%%%%%%%%%%% RF18 %%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que realiza un movimiento.
% Dom: game (game) X player (player) X column (int) X game (Game)
% play_piece/4

player_play(Game,Player,Columna,NewGame):-
    verificacion1(Game,Player,Columna,JugadaHecha),
    game_get_board(JugadaHecha,Board),
    who_is_winner(Board,Int),
    Int = 1,
    end_game(JugadaHecha,NewGame),!.
player_play(Game,Player,Columna,NewGame):-
    verificacion1(Game,Player,Columna,JugadaHecha),
    game_get_board(JugadaHecha,Board),
    who_is_winner(Board,Int),
    Int = 2,
    end_game(JugadaHecha,NewGame),!.

player_play(Game,Player,Columna,NewGame):-
    verificacion1(Game,Player,Columna,JugadaHecha),
    is_draw(JugadaHecha),
    end_game(JugadaHecha,NewGame).
player_play(Game,Player,Columna,NewGame):-
    verificacion1(Game,Player,Columna,JugadaHecha),
    game_get_board(JugadaHecha,Board),
    who_is_winner(Board,Int),
    Int = 0,
    NewGame = JugadaHecha.
