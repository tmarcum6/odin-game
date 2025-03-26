package engine

import rl "vendor:raylib"

input_handler :: proc(player: ^entity) {
    handle_keyboard_input(player)
    //handle_mouse_scroll_input()
}

handle_keyboard_input :: proc(player: ^entity) {
    if rl.IsKeyPressed(.LEFT) {
        player.pos.x -= 1 * 8 //tile width
    } else if rl.IsKeyPressed(.RIGHT) {
        player.pos.x += 1 * 8 
    } else if rl.IsKeyPressed(.UP) {
        player.pos.y += 1 * 8
    } else if rl.IsKeyPressed(.DOWN) {
        player.pos.y -= 1 * 8
    }
}

handle_mouse_scroll_input :: proc() {
    wheel := rl.GetMouseWheelMove()
    if (wheel != 0) {
        zoomIncrement := f32(0.015)
        camera.zoom += (wheel * zoomIncrement);
        if (camera.zoom < 3.0) {camera.zoom = 3.0}
        if (camera.zoom > 8.0) {camera.zoom = 8.0}
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