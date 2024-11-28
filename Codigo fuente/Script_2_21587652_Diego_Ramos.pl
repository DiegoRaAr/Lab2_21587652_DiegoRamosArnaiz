% 1. Crear jugadores (10 fichas cada uno, para lograr un empate por
% cantidad de fichas)

player(1, "Andrea", "red", 0, 0, 0, 10, P1),
player(2, "Diego", "yellow", 0, 0, 0, 10, P2),

% 2. Crear fichas
%
piece("red", RedPiece),
piece("yellow", YellowPiece),

% 3. Crear tablero inicial vacío

board(EmptyBoard),

% 4. Crear nuevo juego

game(P1, P2, EmptyBoard, 1, G0),
player_play(G0, P1, 3, G1),    % Andrea juega en columna 3
player_play(G1, P2, 4, G2),    % Diego juega en columna 4
player_play(G2, P1, 4, G3),    % Andrea juega en columna 4
player_play(G3, P2, 3, G4),    % Diego juega en columna 3
player_play(G4, P1, 0, G5),    % Andrea juega en columna 0
player_play(G5, P2, 2, G6),    % Diego juega en columna 2
player_play(G6, P1, 4, G7),    % Andrea juega en columna 4
player_play(G7, P2, 4, G8),    % Diego juega en columna 4
player_play(G8, P1, 6, G9),    % Andrea juega en columna 6
player_play(G9, P2, 5, G10),   % Diego juega en columna 5
player_play(G10, P1, 5, G11),  % Andrea juega en columna 5
player_play(G11, P2, 2, G12),    % Diego juega en columna 3
player_play(G12, P1, 3, G13),    % Andrea juega en columna 4
player_play(G13, P2, 3, G14),    % Diego juega en columna 4
player_play(G14, P1, 5, G15),    % Andrea juega en columna 3
player_play(G15, P2, 2, G16),    % Diego juega en columna 0
player_play(G16, P1, 2, G17),    % Andrea juega en columna 2
player_play(G17, P2, 5, G18),    % Diego juega en columna 4
player_play(G18, P1, 6, G19),    % Andrea juega en columna 4
player_play(G19, P2, 6, G20),    % Diego juega en columna 6 (Empate, ambos jugadoes sin fichas).

% 6. Verificaciones del estado del juego

write('¿Se puede jugar en el tablero vacío? '),
can_play(EmptyBoard), % Si se puede seguir jugando, el programa continuará
nl,
game_get_board(G20, CurrentBoard),
write('¿Se puede jugar después de 20 movimientos? '),
can_play(CurrentBoard),
nl,

% 7. Verificaciones de victoria

write('Verificación de victoria vertical: '),
check_vertical_win(CurrentBoard, VerticalWinner),
write(VerticalWinner),
nl,
write('Verificación de victoria horizontal: '),
check_horizontal_win(CurrentBoard, HorizontalWinner),
write(HorizontalWinner),
nl,
write('Verificación de victoria diagonal: '),
check_diagonal_win(CurrentBoard, DiagonalWinner),
write(DiagonalWinner),
nl,
write('Verificación de ganador: '),
who_is_winner(CurrentBoard, Winner),
write(Winner),
nl,

% 8. Mostrar historial de movimientos
write('Historial de movimientos: '),
game_history(G20, History),
write(History),
nl,

% 9. Actualizar estadsticas de los jugadores
write('Estadisticas actualizadas: '),
update_stats(P1, "draw", P1Actualizado),
update_stats(P2, "draw", P2Actualizado),
write(P1Actualizado),
write(P2Actualizado),
nl,

% 10. Jugador despues de 20 movimientos
write('Jugador actual después de 20 movimientos: '),
get_current_player(G20, CurrentPlayer),
write(CurrentPlayer),
nl,

%11. Tablero despues de 20 movimientos
write('Tablero despues de 20 movimientos'),
game_get_board(G20,ActualBoard),
write(ActualBoard),
nl,

%12. Finaliza el juego y vuelve a actualizar estadisticas
end_game(G11,JuegoTerminado),

%13. Verificación de empate
write('¿Es empate? '),
is_draw(G20),
nl.









