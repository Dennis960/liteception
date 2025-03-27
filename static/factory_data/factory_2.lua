--[[

    Defines a bunch of magic numbers to be used for positioning by other scripts.

]]

local north = defines.direction.north
local east  = defines.direction.east
local south = defines.direction.south
local west  = defines.direction.west

local factory = {
    entity_name = "factory-2",
    entity_position = { x = 10, y = 10 },
    player_spawn_position = { x = 0, y = 23 },
    combinator_position = { x = 2, y = 24 },
    tile_fills = {
        {
            tile = "factory-wall-2",
            left = -2,
            top = 23,
            right = 1,
            bottom = 23,
        },
        {
            tile = "out-of-map",
            left = -3,
            top = 24,
            right = 2,
            bottom = 25,
        },
    },
    gui_inputs = {
        [north] = { 1, 2, 3, 0, 4, 5, 6 },
        [east]  = { 1, 2, 3, 0, 4, 5, 6 },
        [south] = { 1, 2, 3, 0, 4, 5, 6 },
        [west]  = { 1, 2, 3, 0, 4, 5, 6 },
    },
    outdoor_pos = {
        offsets = {
            [north] = { 0, 1, 2, 7, 8, 9 },
            [east]  = { 0, 1, 2, 7, 8, 9 },
            [south] = { 0, 1, 2, 7, 8, 9 },
            [west]  = { 0, 1, 2, 7, 8, 9 },
        },
        positions = {
            [north] = {
                chest         = { 5, 0 },
                loader        = { 5, 2 },
                belt          = { 5, 3 },
                infinity_pipe = { 5, 3 },
            },
            [east] = {
                chest         = { 19, 5 },
                loader        = { 18, 5 },
                belt          = { 16, 5 },
                infinity_pipe = { 16, 5 },
            },
            [south] = {
                chest         = { 5, 19 },
                loader        = { 5, 18 },
                belt          = { 5, 16 },
                infinity_pipe = { 5, 16 },
            },
            [west] = {
                chest         = { 0, 5 },
                loader        = { 2, 5 },
                belt          = { 3, 5 },
                infinity_pipe = { 3, 5 },
            },
        },
    },
    indoor_pos = {
        offsets = {
            [north] = { 0, 5, 10, 27, 32, 37 },
            [east]  = { 0, 5, 10, 27, 32, 37 },
            [south] = { 0, 5, 10, 27, 32, 37 },
            [west]  = { 0, 5, 10, 27, 32, 37 },
        },
        positions = {
            [north] = {
                belt = { -19, -24 },
                pipe = { -19, -24 },
            },
            [east] = {
                belt = { 23, -19 },
                pipe = { 23, -19 },
            },
            [south] = {
                belt = { -19, 23 },
                pipe = { -19, 23 },
            },
            [west] = {
                belt = { -24, -19 },
                pipe = { -24, -19 },
            },
        },
    },
}

return factory
