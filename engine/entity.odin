package engine

import rl "vendor:raylib"

entity :: struct {
    id                : u64,
    pos               : rl.Vector2,
    vel               : rl.Vector2,
    run_num_frames    : int,
}