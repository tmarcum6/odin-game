package engine

import rl "vendor:raylib"

handle_input :: proc(player: ^entity) {
    if rl.IsKeyDown(.LEFT) {
        player.vel.x = -200
    } else if rl.IsKeyDown(.RIGHT) {
        player.vel.x = 200
    } else if rl.IsKeyDown(.UP) {
        player.vel.y = 200
    } else if rl.IsKeyDown(.DOWN) {
        player.vel.y = -200
    } else {
        player.vel.xy = 0
    }
}

lock_player_to_window :: proc(player: ^entity, player_run_width: f32, player_run_height: f32, window_width: f32, window_height: f32) {
    if player.pos.x < 0 {
        player.pos.x = 0
    }
    if player.pos.x + player_run_width > f32(window_width) {
        player.pos.x = f32(window_width) - player_run_width
    }
    if player.pos.y < 0 {
        player.pos.y = 0
    }
    if player.pos.y + player_run_height > f32(window_height) {
        player.pos.y = f32(window_height) - player_run_height
    } 
}