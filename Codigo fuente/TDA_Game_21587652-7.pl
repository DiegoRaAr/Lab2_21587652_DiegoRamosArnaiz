% Predicado que permite crear una nueva partida.
% Dom: player1 (player) X player2 (player) X board (board) X current-turn (int)
% game/5
game(P1,P2,Board,Current-turn, [P1,P2,Board,Current-turn,History]):-
    History is [].

% Predicado que genera un historial de movimientos de la partida.
% Dom: game (game)
% game_history/2
game_history([_,_,_,_,History],History).
