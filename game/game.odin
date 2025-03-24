package game

import rl "vendor:raylib"
import "core:math/rand"
import e "../engine" 

main :: proc() {
    window_width  := i32(1280)
    window_height := i32(720)
    rl.InitWindow(window_width, window_height, "My First Game")

    player_run_frame_timer   : f32
    player_run_current_frame : int
    player_run_frame_length  := f32(0.1)
    
    map_texture := rl.LoadTexture("../assets/untitled.png")
    smap := e.s_map {
        source = rl.Rectangle{0, 0, f32(map_texture.width), f32(map_texture.height)},
        dest = rl.Rectangle{0, 0, f32(window_width), f32(window_height)},
        origin = rl.Vector2{0, 0}
    }

    player_texture  := rl.LoadTexture("../assets/rogue.png")
    player := e.entity {
        id = rand.uint64(),
        pos = rl.Vector2 { 640, 320 },
        vel = 0,
        run_num_frames = 1,
    }

    for !rl.WindowShouldClose() {
        if rl.GetScreenWidth() != window_width || rl.GetScreenHeight() != window_height {
            rl.SetWindowSize(window_width, window_height) 
        }        

        rl.BeginDrawing()
        rl.ClearBackground({110, 184, 168, 255})

        e.handle_input(&player)

        player.pos += player.vel * rl.GetFrameTime()

        player_run_width := f32(player_texture.width)
        player_run_height := f32(player_texture.height)

        player_run_frame_timer += rl.GetFrameTime()

        draw_player_source := rl.Rectangle {
            x = f32(player_run_current_frame) * player_run_width / f32(player.run_num_frames),
            y = 0,
            width = player_run_width / f32(player.run_num_frames),
            height = player_run_height,
        }

        draw_player_dest := rl.Rectangle {
            x = player.pos.x,
            y = player.pos.y,
            width = player_run_width * 4 / f32(player.run_num_frames),
            height = player_run_height * 4
        }
        
        // if player_pos.x >= f32(window_width) || player_pos.y >= f32(window_height) {
        //     player_vel = 0
        // }   

        rl.DrawTexturePro(map_texture, smap.source, smap.dest, smap.origin, 0, rl.WHITE)
        rl.DrawTexturePro(player_texture, draw_player_source, draw_player_dest, 0, 0, rl.WHITE)
        
        rl.EndDrawing()
    }

    rl.CloseWindow()
}