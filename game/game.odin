package game

import rl "vendor:raylib"

main :: proc() {
    window_width  := i32(1280)
    window_height := i32(720)

    rl.InitWindow(window_width, window_height, "My First Game")
    player_pos := rl.Vector2 { 640, 320 }
    player_vel: rl.Vector2
    player_grounded: bool

    player_flip: bool
    player_run_texture := rl.LoadTexture("../assets/rogue.png")
    player_run_num_frames := 4
    player_run_frame_timer: f32
    player_run_current_frame: int
    player_run_frame_length := f32(0.1)
    
    map_texture := rl.LoadTexture("../assets/untitled.png")
    source_rec  := rl.Rectangle{0, 0, f32(map_texture.width), f32(map_texture.height)}
    dest_rec    := rl.Rectangle{0, 0, f32(window_width), f32(window_height)}
    origin      := rl.Vector2{0, 0}
    
    for !rl.WindowShouldClose() {
        if rl.GetScreenWidth() != window_width || rl.GetScreenHeight() != window_height {
            rl.SetWindowSize(window_width, window_height) 
        }        

        rl.BeginDrawing()
        rl.ClearBackground({110, 184, 168, 255})

        if rl.IsKeyDown(.LEFT) {
            player_vel.x = -400
            player_flip = true
        } else if rl.IsKeyDown(.RIGHT) {
            player_vel.x = 400
            player_flip = false
        } else {
            player_vel.x = 0
        }

        player_vel.y += 2000 * rl.GetFrameTime()

        if player_grounded && rl.IsKeyPressed(.SPACE) {
            player_vel.y = -600
            player_grounded = false
        }

        player_pos += player_vel * rl.GetFrameTime()

        if player_pos.y > f32(rl.GetScreenHeight()) - 64 {
            player_pos.y = f32(rl.GetScreenHeight()) - 64
            player_grounded = true
        }

        player_run_width := f32(player_run_texture.width)
        player_run_height := f32(player_run_texture.height)

        player_run_frame_timer += rl.GetFrameTime()

        if player_run_frame_timer > player_run_frame_length {
            player_run_current_frame += 1
            player_run_frame_timer = 0            
        if player_run_current_frame == player_run_num_frames {
                player_run_current_frame = 0
            }
        }
        draw_player_source := rl.Rectangle {
            x = f32(player_run_current_frame) * player_run_width / f32(player_run_num_frames),
            y = 0,
            width = player_run_width / f32(player_run_num_frames),
            height = player_run_height,
        }

        if player_flip {
            draw_player_source.width = -draw_player_source.width
        }

        draw_player_dest := rl.Rectangle {
            x = player_pos.x,
            y = player_pos.y,
            width = player_run_width * 4 / f32(player_run_num_frames),
            height = player_run_height * 4
        }

        rl.DrawTexturePro(map_texture, source_rec, dest_rec, origin, 0, rl.WHITE)
        rl.DrawTexturePro(player_run_texture, draw_player_source, draw_player_dest, 0, 0, rl.WHITE)
        
        rl.EndDrawing()
    }

    rl.CloseWindow()
}