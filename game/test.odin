package game

import  "vendor:raylib"

main :: proc() {
    raylib.InitWindow(800, 600, "Sprite Collision")
    defer raylib.CloseWindow()
    player_pos := raylib.Vector2{100, 100}
    enemy_pos  := raylib.Vector2{300, 200}
    player_speed := 200.0

    for !raylib.WindowShouldClose() {
        dt := raylib.GetFrameTime()

        // Move player
        if raylib.IsKeyDown(.RIGHT) {
            player_pos.x += f32(player_speed) * dt
        }
        if raylib.IsKeyDown(.LEFT) {
            player_pos.x -= f32(player_speed) * dt
        }
        if raylib.IsKeyDown(.DOWN) {
            player_pos.y += f32(player_speed) * dt
        }
        if raylib.IsKeyDown(.UP) {
            player_pos.y -= f32(player_speed) * dt
        }

        // Define collision rectangles based on entity positions
        player_rect := raylib.Rectangle{player_pos.x, player_pos.y, 50, 50}
        enemy_rect  := raylib.Rectangle{enemy_pos.x, enemy_pos.y, 50, 50} // Assuming a 50x50 enemy

        collided := raylib.CheckCollisionRecs(player_rect, enemy_rect)

        raylib.BeginDrawing()
        raylib.ClearBackground(raylib.RAYWHITE)

        // Draw player sprite
        //raylib.DrawTexture(texture, i32(player_pos.x), i32(player_pos.y), raylib.GREEN)
        raylib.DrawRectangleRec(player_rect, raylib.GREEN)

        // Draw enemy (using a rectangle for simplicity)
        raylib.DrawRectangleRec(enemy_rect, raylib.DARKGRAY)

        // Draw collision indicator
        if collided {
            raylib.DrawText("Collision!", 350, 50, 20, raylib.RED)
        }

        raylib.EndDrawing()
    }
}