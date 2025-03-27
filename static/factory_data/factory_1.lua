--[[

    Defines a bunch of magic numbers to be used for positioning by other scripts.

]]

local north = defines.direction.north
local east  = defines.direction.east
local south = defines.direction.south
local west  = defines.direction.west

local factory = {
    entity_name = "factory-1",
    entity_position = { x = 10, y = 10 },
    player_spawn_position = { x = 0, y = 15 },
    combinator_position = { x = 2, y = 16 },
    tile_fills = {
        {
            tile = "factory-wall-1",
            left = -2,
            top = 15,
            right = 1,
            bottom = 15,
        },
        {
            tile = "out-of-map",
            left = -3,
            top = 16,
            right = 2,
            bottom = 17,
        },
    },
    gui_inputs = {
        [north] = { 1, 2, 0, 3, 4 },
        [east]  = { 1, 2, 0, 3, 4 },
        [south] = { 1, 2, 0, 3, 4 },
        [west]  = { 1, 2, 0, 3, 4 },
    },
    outdoor_pos = {
        offsets = {
            [north] = { 0, 1, 4, 5 },
            [east]  = { 0, 1, 4, 5 },
            [south] = { 0, 1, 4, 5 },
            [west]  = { 0, 1, 4, 5 },
        },
        positions = {
            [north] = {
                chest         = { 7, 2 },
                loader        = { 7, 4 },
                belt          = { 7, 5 },
                infinity_pipe = { 7, 5 },
            },
            [east] = {
                chest         = { 17, 7 },
                loader        = { 16, 7 },
                belt          = { 14, 7 },
                infinity_pipe = { 14, 7 },
            },
            [south] = {
                chest         = { 7, 17 },
                loader        = { 7, 16 },
                belt          = { 7, 14 },
                infinity_pipe = { 7, 14 },
            },
            [west] = {
                chest         = { 2, 7 },
                loader        = { 4, 7 },
                belt          = { 5, 7 },
                infinity_pipe = { 5, 7 },
            },
        },
    },
    indoor_pos = {
        offsets = {
            [north] = { 0, 4, 15, 19 },
            [east]  = { 0, 4, 15, 19 },
            [south] = { 0, 4, 15, 19 },
            [west]  = { 0, 4, 15, 19 },
        },
        positions = {
            [north] = {
                belt = { -10, -16 },
                pipe = { -10, -16 },
            },
            [east] = {
                belt = { 15, -10 },
                pipe = { 15, -10 },
            },
            [south] = {
                belt = { -10, 15 },
                pipe = { -10, 15 },
            },
            [west] = {
                belt = { -16, -10 },
                pipe = { -16, -10 },
            },
        },
    },
}

return factory
