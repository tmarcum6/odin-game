package game

import rl "vendor:raylib"
import "core:math/rand"
import e "../engine" 
import "core:fmt"
import "core:strconv"

main :: proc() {

// init
    window_width  := i32(1280)
    window_height := i32(720)
    rl.InitWindow(window_width, window_height, "My First Game")

    player_run_frame_timer   : f32
    player_run_current_frame : int
    player_run_frame_length  := f32(0.1)
    
    map_texture := rl.LoadTexture("../assets/testmapexport.png")
    smap := e.s_map {
        source = rl.Rectangle{0, 0, f32(map_texture.width), f32(map_texture.height)},
        dest = rl.Rectangle{0, 0, f32(window_width), f32(window_height)},
        origin = rl.Vector2{0, 0}
    }
    defer rl.UnloadTexture(map_texture)

    player_texture  := rl.LoadTexture("../assets/rogue.png")
    player := e.entity {
        id = rand.uint64(),
        pos = rl.Vector2 { 640, 320 },
        vel = 0,
        run_num_frames = 1,
    }
    defer rl.UnloadTexture(player_texture)

    tmap := e.load_tiled_map("../assets/testmapexport.json")
    fmt.println("Loaded tilemap with dimensions:", tmap.width, "x", tmap.height)

// main game loop
    for !rl.WindowShouldClose() {

// update
        if rl.GetScreenWidth() != window_width || rl.GetScreenHeight() != window_height {
            rl.SetWindowSize(window_width, window_height) 
        }        

        player_run_width := f32(player_texture.width)
        player_run_height := f32(player_texture.height)
        e.camera.target = rl.Vector2{player.pos.x + player_run_width / 2, player.pos.y + player_run_height / 2}
        e.camera.offset = rl.Vector2{f32(window_width) / 2, f32(window_height) / 2}
        e.camera_zoom()

        // check for key press
        buf: [20]u8 
        i := int(e.get_tile_at_position(tmap, player.pos.x, player.pos.y))
        result: string = strconv.itoa(buf[:], i)
        fmt.println("TileId:", result)

// draw
        rl.BeginDrawing()
        rl.ClearBackground({110, 184, 168, 255})
        
        rl.BeginMode2D(e.camera)

        e.handle_input(&player)

        player.pos += player.vel * rl.GetFrameTime()

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
    
        e.lock_player_to_window(&player, player_run_width, player_run_height, f32(window_width), f32(window_height))
     
        rl.DrawTexturePro(map_texture, smap.source, smap.dest, smap.origin, 0, rl.WHITE)
        rl.DrawTexturePro(player_texture, draw_player_source, draw_player_dest, 0, 0, rl.WHITE)

        rl.EndMode2D()

        rl.DrawText("Move: Arrow Keys | Zoom: W/S", 10, 10, 20, rl.BLACK)
        rl.DrawText("Tile: ", 900, 10, 20, rl.BLACK)

        rl.EndDrawing()
    }

// close
    rl.CloseWindow()
}