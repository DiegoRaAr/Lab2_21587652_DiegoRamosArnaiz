% 1. Crear jugadores (21 fichas cada uno)

player(1, "Matea", "red", 0, 0, 0, 21, P1),
player(2, "Patricia", "yellow", 0, 0, 0, 21, P2),

% 2. Crear fichas
%
piece("red", RedPiece),
piece("yellow", YellowPiece),

% 3. Crear tablero inicial vac�o

board(EmptyBoard),

% 4. Crear nuevo juego

game(P1, P2, EmptyBoard, 1, G0),
player_play(G0, P1, 2, G1),    % Matea juega en columna 2
player_play(G1, P2, 4, G2),    % Patricia juega en columna 4
player_play(G2, P1, 2, G3),    % Matea juega en columna 2
player_play(G3, P2, 2, G4),    % Patricia juega en columna 2
player_play(G4, P1, 3, G5),    % Matea juega en columna 3
player_play(G5, P2, 0, G6),    % Patricia juega en columna 0
player_play(G6, P1, 3, G7),    % Matea juega en columna 3
player_play(G7, P2, 1, G8),    % Patricia juega en columna 1
player_play(G8, P1, 1, G9),    % Matea juega en columna 1
player_play(G9, P2, 0, G10),   % Patricia juega en columna 0
player_play(G10, P1, 4, G11),  % Matea juega en columna 4 (victoria horizontal)

% 6. Verificaciones del estado del juego

write('�Se puede jugar en el tablero vac�o? '),
can_play(EmptyBoard), % Si se puede seguir jugando, el programa continuar�
nl,
game_get_board(G11, CurrentBoard),
write('�Se puede jugar despu�s de 11 movimientos? '),
can_play(CurrentBoard),
nl,

% 7. Verificaciones de victoria

write('Verificaci�n de victoria vertical: '),
check_vertical_win(CurrentBoard, VerticalWinner),
write(VerticalWinner),
nl,
write('Verificaci�n de victoria horizontal: '),
check_horizontal_win(CurrentBoard, HorizontalWinner),
write(HorizontalWinner),
nl,
write('Verificaci�n de victoria diagonal: '),
check_diagonal_win(CurrentBoard, DiagonalWinner),
write(DiagonalWinner),
nl,
write('Verificaci�n de ganador: '),
who_is_winner(CurrentBoard, Winner),
write(Winner),
nl,

% 8. Mostrar historial de movimientos
write('Historial de movimientos: '),
game_history(G11, History),
write(History),
nl,

% 9. Actualizar estadsticas de los jugadores
write('Estadisticas actualizadas: '),
update_stats(P1, "win", P1Actualizado),
update_stats(P2, "loss", P2Actualizado),
write(P1Actualizado),
write(P2Actualizado),
nl,

% 10. Jugador despues de 11 movimientos
write('Jugador actual despu�s de 11 movimientos: '),
get_current_player(G11, CurrentPlayer),
write(CurrentPlayer),
nl,

%11. Tablero despues de 11 movimientos
write('Tablero despues de 11 movimientos'),
game_get_board(G11,ActualBoard),
write(ActualBoard),
nl,

%12. Finaliza el juego y vuelve a actualizar estadisticas
end_game(G11,JuegoTerminado),

%13. Verificaci�n de empate
write('�Es empate? '),
is_draw(G11),
nl.

