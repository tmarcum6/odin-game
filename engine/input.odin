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