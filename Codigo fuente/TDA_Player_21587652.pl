:- module(tda_player, [player/8,get_color/2,update_stats/3,restar_pieza/2,get_nombre/2]).



% Predicado que permite crear un jugador.
% Dom: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining_pieces (int) X Player
% player/8
player(Id , Name , Color , Wins , Loss , Draws , Rpiece ,
       [Id , Name , Color , Wins , Loss , Draws , Rpiece]).


% Predicado para obtener el color de un player
% Dom: Player (player)
% get_color/2
get_color([_,_,Color,_,_,_,_], Color).

get_nombre([_,Nombre,_,_,_,_,_],Nombre).

% Predicado que actualiza las estadísticas del jugador, ya sea victoria, derrotas o empates.
% Dom: Player (player) x Str (str)
% update_stats/3
update_stats([Id,Name,Color,Wins, Loss, Draw, Rpiece], "win" , [Id,Name,Color,NewWins, Loss, Draw, Rpiece]):-
    NewWins is Wins + 1,!.
update_stats([Id,Name,Color,Wins, Loss, Draw, Rpiece], "loss" , [Id,Name,Color,Wins, NewLoss, Draw, Rpiece]):-
    NewLoss is Loss + 1,!.
update_stats([Id,Name,Color,Wins, Loss, Draw, Rpiece], "draw" , [Id,Name,Color,Wins, Loss, NewDraw, Rpiece]):-
    NewDraw is Draw + 1,!.


restar_pieza([Id,Name,Color,Wins, Loss, Draw, Rpiece] , [Id,Name,Color,Wins, Loss, Draw, NewRpiece]):-
    NewRpiece is Rpiece - 1,!.


