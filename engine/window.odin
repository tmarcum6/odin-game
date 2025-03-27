package engine

import rl "vendor:raylib"

window :: struct {
    window_width  : i32,
    window_height : i32,
}

lock_player_to_window :: proc(player: ^entity, player_width: f32, player_height: f32, window_width: f32, window_height: f32) {
    if player.pos.x < 0 {
        player.pos.x = 0
    }
    if player.pos.x + player_width > f32(window_width) {
        player.pos.x = f32(window_width) - player_width
    }
    if player.pos.y < 0 {
        player.pos.y = 0
    }
    if player.pos.y + player_height > f32(window_height) {
        player.pos.y = f32(window_height) - player_height
    } 
}