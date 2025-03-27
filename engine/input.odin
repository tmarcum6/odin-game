package engine

import rl "vendor:raylib"

input_handler :: proc(player: ^entity) {
    keyboard_input(player)
    keyboard_camera_zoom()
    //handle_mouse_scroll_input()
}

keyboard_input :: proc(player: ^entity) {
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

keyboard_camera_zoom := proc() {
    if rl.IsKeyDown(.W) {
        camera.zoom += 0.05
    }
    if rl.IsKeyDown(.S) {
        camera.zoom -= 0.05
    }
    if camera.zoom < 0.5 {
        camera.zoom = 0.5 
    }
    if camera.zoom > 3.0 {
        camera.zoom = 3.0 
    }
}   

mouse_scroll_zoom :: proc() {
    wheel := rl.GetMouseWheelMove()
    if (wheel != 0) {
        zoomIncrement := f32(0.015)
        camera.zoom += (wheel * zoomIncrement);
        if (camera.zoom < 3.0) {camera.zoom = 3.0}
        if (camera.zoom > 8.0) {camera.zoom = 8.0}
    }
}