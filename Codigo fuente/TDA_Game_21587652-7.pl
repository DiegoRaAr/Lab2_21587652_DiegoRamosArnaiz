%:- use_module("Funciones_Auxiliares_21587652.pl").
:- use_module("tda_board_21587652.pl").
:- use_module("tda_player_21587652.pl").




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


% Predicado que entrega por pantalla el estado actual del tablero en el juego.
% Game X Board
% game_get_board/2
game_get_board(Game,Board):-
    get_board(Game,Board).


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











