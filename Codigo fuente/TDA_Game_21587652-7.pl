%:- use_module("Funciones_Auxiliares_21587652.pl").
:- module(tda_Game, [get_P1/2, get_P2/2, get_board/2,get_turno/2,get_Rpiece/2,verificacion1/4,mostrarTablero/1]).
:- use_module("tda_board_21587652.pl").
:- use_module("tda_player_21587652.pl").
:- use_module("funciones_auxiliares_21587652").


% Predicado que permite crear una nueva partida.
% Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
% game/5
game(P1,P2,Board,Current_turn, [P1,P2,Board,Current_turn,History]):-
    History = [].

% Predicado que genera un historial de movimientos de la partida.
% Dom: game (game)
% game_history/2
game_history([_,_,_,_,History],History).

get_P1([Player1,_,_,_,_],Player1).
get_P2([_,Player2,_,_,_],Player2).
get_board([_,_,Board,_,_],Board).
get_turno([_,_,_,Turno,_],Turno).
get_Rpiece([_,_,_,_,_,_,Rpiece],Rpiece).


% Predicado que verifica si el estado actual del juego es empate.
% Dom: game (game)
% is_draw/1
is_draw(Game):-
    get_P1(Game,Player1),
    get_P2(Game,Player2),
    get_Rpiece(Player1,Piezas1),
    get_Rpiece(Player2,Piezas2),
    (Piezas1 = 0 , Piezas2 = 0),!.
is_draw(Game):-
    game_get_board(Game,Board),
    not(can_play(Board)).

% Predicado que obtiene el jugador cuyo turno está en curso.
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


% Predicado que entrega por pantalla el estado actual del tablero en el juego.
% Game X Board
% game_get_board/2
game_get_board(Game,Board):-
    get_board(Game,Board).


% Predicado finaliza el juego actualizando las estadísticas de los jugadores según el resultado.
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




verificacion1(Game,Player,Colunma,[J1,J2,NewBoard,Turno,NewHistorial]):-
    get_current_player(Game,PlayerActual),
    get_nombre(PlayerActual, NombrePlayerActual),
    get_nombre(Player,NombrePlayerEntregado),
    NombrePlayerActual = NombrePlayerEntregado,
    get_P1(Game,Player1),
    get_P2(Game,J2),
    get_nombre(Player1,NombrePlayer1),
    NombrePlayer1 = NombrePlayerEntregado,
    restar_pieza(Player1,J1),
    game_get_board(Game,Board),
    get_color(Player,Pieza),
    play_piece(Board,Colunma,Pieza,NewBoard),
    game_history(Game,Historial),
    Jugada = [NombrePlayerEntregado,Colunma],
    NewHistorial = [Jugada|Historial],
    get_turno(Game,TurnoActual),
    Turno is TurnoActual + 1,!.

verificacion1(Game,Player,Colunma,[J1,J2,NewBoard,Turno,NewHistorial]):-
    get_current_player(Game,PlayerActual),
    get_nombre(PlayerActual, NombrePlayerActual),
    get_nombre(Player,NombrePlayerEntregado),
    NombrePlayerActual = NombrePlayerEntregado,
    get_P1(Game,J1),
    get_P2(Game,Player2),
    get_nombre(Player2,NombrePlayer2),
    NombrePlayer2 = NombrePlayerEntregado,
    restar_pieza(Player2,J2),
    game_get_board(Game,Board),
    get_color(Player,Pieza),
    play_piece(Board,Colunma,Pieza,NewBoard),
    game_history(Game,Historial),
    Jugada = [NombrePlayerEntregado,Colunma],
    NewHistorial = [Jugada|Historial],
    get_turno(Game,TurnoActual),
    Turno is TurnoActual + 1,!.

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







mostrarTablero(Game):-
    get_board(Game,Board),
    get_fila1(Board,Fila1),
    get_fila2(Board,Fila2),
    get_fila3(Board,Fila3),
    get_fila4(Board,Fila4),
    get_fila5(Board,Fila5),
    get_fila6(Board,Fila6),
    write(Fila1),
    write(Fila2),
    write(Fila3),
    write(Fila4),
    write(Fila5),
    write(Fila6).
