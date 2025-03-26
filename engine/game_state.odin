package engine

turn_state :: enum {
    PlayerTurn,
    EnemyTurn,
    EndTurn,
}

game_state :: struct {
    turn_state: turn_state,
    player: entity,
    enemies: []entity,
}

// update_turn :: proc(state: ^game_state) {
//     switch state.turn_state {
//     case .PlayerTurn:
//         if player_has_made_a_move(state) {
//             state.turn_state = .EnemyTurn;
//         }

//     case .EnemyTurn:
//         for enemy in state.enemies {
//             enemy_take_action(enemy, state);
//         }
//         state.turn_state = .EndTurn;

//     case .EndTurn:
//         state.turn_state = .PlayerTurn;
//     }
// }

// enemy_take_action :: proc(enemy: ^entity, state: ^game_state) {
//     if enemy.x < state.player.x {
//         enemy.x += 1;
//     } 
//     else if enemy.x > state.player.x {
//         enemy.x -= 1;
//     }
// }

// player_has_made_a_move :: proc(state: ^game_state) -> bool {
//     return false
// }