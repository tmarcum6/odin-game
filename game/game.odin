package game

import rl "vendor:raylib"
import "core:math/rand"
import e "../engine" 
import "core:fmt"
import "core:strconv"

main :: proc() {

// init
    window := e.window{
        window_width  = 1280,
        window_height = 720
    }
    rl.InitWindow(window.window_width,window.window_height,"Game")

// load textures
    map_texture := rl.LoadTexture("../assets/testmapexport.png")
    smap := e.s_map {
        source = rl.Rectangle{0, 0, f32(map_texture.width), f32(map_texture.height)},
        dest   = rl.Rectangle{0, 0, f32(window.window_width), f32(window.window_height)},
        origin = rl.Vector2{0, 0}
    }
    defer rl.UnloadTexture(map_texture)

    player_texture := rl.LoadTexture("../assets/rogue.png")
    player := e.entity {
        id             = rand.uint64(),
        size           = rl.Vector2 {f32(player_texture.width), f32(player_texture.height)},
        pos            = rl.Vector2 { 640, 320 },
        vel            = 0,
        run_num_frames = 1
    }
    defer rl.UnloadTexture(player_texture)

    enemy := e.entity {
        id             = rand.uint64(),
        size           = rl.Vector2 {50, 50},
        pos            = rl.Vector2 { 680, 320 },
        vel            = 0,
        run_num_frames = 1
    }

// load map data
    tmap_data := e.load_tiled_map("../assets/testmapexport.json")
    fmt.println("Loaded tilemap with dimensions:", tmap_data.width, "x", tmap_data.height)
   
// game loop
    for !rl.WindowShouldClose() {
        update(window, &player, &enemy, tmap_data)
        draw(&player, &enemy, player_texture, map_texture, smap, false)
    }

    rl.CloseWindow()
}

update :: proc(window : e.window, player : ^e.entity, enemy : ^e.entity, tmap_data : e.tile_map) {
    if rl.GetScreenWidth() != window.window_width || rl.GetScreenHeight() != window.window_height {
        rl.SetWindowSize(window.window_width, window.window_height) 
    }        

    e.camera.target = rl.Vector2{player.pos.x + player.size.x / 2, player.pos.y + player.size.y / 2}
    e.camera.offset = rl.Vector2{f32(window.window_width) / 2, f32(window.window_height) / 2}

    buf: [20]u8 
    i := int(e.get_tile_at_position(tmap_data, player.pos.x, player.pos.y))
    result: string = strconv.itoa(buf[:], i)
    fmt.println("TileId:", result)

    e.input_handler(player)

    player.pos += player.vel * rl.GetFrameTime()

    e.lock_player_to_window(player, player.size.x, player.size.y, f32(window.window_width), f32(window.window_height))
}

draw :: proc(player : ^e.entity, enemy : ^e.entity, player_texture : rl.Texture2D, map_texture : rl.Texture2D, smap : e.s_map, collided : bool) {
    rl.BeginDrawing()
    rl.ClearBackground({110, 184, 168, 255})
    rl.BeginMode2D(e.camera)

    draw_player_source := rl.Rectangle {
        x = 0,
        y = 0,
        width = player.size.x,
        height = player.size.y
    }

    draw_player_dest := rl.Rectangle {
        x = player.pos.x,
        y = player.pos.y,
        width = player.size.x,
        height = player.size.y
    }

    player_rect := rl.Rectangle{player.pos.x, player.pos.y, player.size.x, player.size.y}
    enemy_rect  := rl.Rectangle{enemy.pos.x, enemy.pos.y, enemy.size.x, enemy.size.y}

    collided    := rl.CheckCollisionRecs(player_rect, enemy_rect)
    if collided {
        rl.DrawText("Collision!", 350, 50, 20, rl.RED)
    }
        rl.DrawTexturePro(map_texture, smap.source, smap.dest, smap.origin, 0, rl.WHITE)
        rl.DrawTexturePro(player_texture, draw_player_source, draw_player_dest, 0, 0, rl.WHITE)
        rl.DrawRectangleRec(enemy_rect, rl.DARKGRAY)

        rl.EndMode2D()
        rl.EndDrawing()
}