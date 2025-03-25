package engine

import rl "vendor:raylib"
import "core:fmt"
import "core:encoding/json"
import "core:os"

s_map :: struct {
    texture : rl.Texture2D,
    source  : rl.Rectangle,
    dest    : rl.Rectangle,
    origin  : rl.Vector2,
}

tile_layer :: struct {
    data    : []i32   "data",
    height  : i32     "height",
    id      : i32     "id",
    name    : string  "name",
    opacity : f32     "opacity",
    type    : string  "type",
    visible : bool    "visible",
    width   : i32     "width",
    x       : i32     "x",
    y       : i32     "y",
}

tile_set :: struct {
    firstgid : i32    "firstgid",
    source   : string "source",
}

tile_map :: struct {
    compressionlevel : i32           "compressionlevel",
    height           : i32           "height",
    width            : i32           "width",
    infinite         : bool          "infinite",
    layers           : []tile_layer  "layers",
    nextlayerid      : i32           "nextlayerid",
    nextobjectid     : i32           "nextobjectid",
    orientation      : string        "orientation",
    renderorder      : string        "renderorder",
    tiledversion     : string        "tiledversion",
    tileheight       : i32           "tileheight",
    tilesets         : []tile_set    "tilesets",
    tilewidth        : i32           "tilewidth",
    type             : string        "type",
    version          : string        "version",
}

load_tiled_map :: proc(filepath: string) -> tile_map {
    file_data, err := os.read_entire_file(filepath)
    tmap: tile_map
    json_err: json.Unmarshal_Error = json.unmarshal(file_data, &tmap) // Capture the error properly

    if json_err != nil {
        fmt.println("JSON parsing error:", json_err)
        return tile_map{}
    }

    fmt.println("Parsed TileMap successfully!")
    fmt.println("Width:", tmap.width, "Height:", tmap.height)
    fmt.println("Tile Size:", tmap.tilewidth, "x", tmap.tileheight)
    fmt.println("Layers Count:", len(tmap.layers))

    if len(tmap.layers) > 0 {
        fmt.println("First layer name:", tmap.layers[0].name)
        fmt.println("First layer dimensions:", tmap.layers[0].width, "x", tmap.layers[0].height)
    } else {
        fmt.println("No layers found in the tilemap!")
    }

    return tmap
}

get_tile_at_position :: proc(tmap: tile_map, x: f32, y: f32) -> i32 {
    tile_x := i32(x) / 30 //tmap.tilewidth
    tile_y := i32(y) / 20 //tmap.tileheight

    if tile_x < 0 || tile_x >= tmap.width || tile_y < 0 || tile_y >= tmap.height {
        return -1 // Out of bounds
    }

    index := tile_y * tmap.width + tile_x
    return tmap.layers[0].data[index] // Get tile ID
}