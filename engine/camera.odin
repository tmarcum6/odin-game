package engine

import rl "vendor:raylib"

camera := rl.Camera2D {
    target   = 0,
    offset   = 0,
    rotation = 0.0,
    zoom     = 1.0,
}

camera_zoom := proc() {
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