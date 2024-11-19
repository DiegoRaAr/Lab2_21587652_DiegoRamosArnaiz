%:- use_module("Funciones_Auxiliares_21587652.pl").
:- use_module("TDA_Board.pl").



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
    (Piezas1 = 0 , Piezas2 = 0),
    get_board(Game,Board),
    \+ can_play(Board).


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

