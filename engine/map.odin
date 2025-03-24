package engine

import rl "vendor:raylib"

s_map :: struct {
    texture : rl.Texture2D,
    source : rl.Rectangle,
    dest: rl.Rectangle,
    origin: rl.Vector2,
}