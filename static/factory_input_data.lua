--[[

    Defines a bunch of magic numbers to be used for positioning by other scripts.

]]

local north = defines.direction.north
local east  = defines.direction.east
local south = defines.direction.south
local west  = defines.direction.west

local lib = {
    factory_position = { x = 10, y = 10 },
    infinity_pipes = {
        [north] = "vertical-infinity-pipe",
        [east]  = "horizontal-infinity-pipe",
        [south] = "vertical-infinity-pipe",
        [west]  = "horizontal-infinity-pipe",
    },
    outdoor_pos = {
        offsets = {
            [north] = {
                x = { 0, 1, 2, 3, 8, 9, 10, 11 },
                y = { 0, 0, 0, 0, 0, 0,  0,  0 },
            },
            [east] = {
                x = { 0, 0, 0, 0, 0, 0,  0,  0 },
                y = { 0, 1, 2, 3, 8, 9, 10, 11 },
            },
            [south] = {
                x = { 0, 1, 2, 3, 8, 9, 10, 11 },
                y = { 0, 0, 0, 0, 0, 0,  0,  0 },
            },
            [west] = {
                x = { 0, 0, 0, 0, 0, 0,  0,  0 },
                y = { 0, 1, 2, 3, 8, 9, 10, 11 },
            },
        },
        positions = {
            [north] = {
                chest         = { 4, -2 },
                loader        = { 4,  0 },
                belt          = { 4,  1 },
                infinity_pipe = { 4,  1 },
            },
            [east] = {
                chest         = { 21, 4 },
                loader        = { 20, 4 },
                belt          = { 18, 4 },
                infinity_pipe = { 18, 4 },
            },
            [south] = {
                chest         = { 4, 21 },
                loader        = { 4, 20 },
                belt          = { 4, 18 },
                infinity_pipe = { 4, 18 },
            },
            [west] = {
                chest         = { -2, 4 },
                loader        = {  0, 4 },
                belt          = {  1, 4 },
                infinity_pipe = {  1, 4 },
            },
        },
    },
    indoor_pos = {
        offsets = {
            [north] = {
                x = { 0, 4, 15, 19, 30, 34, 45, 49 },
                y = { 0, 0,  0,  0,  0,  0,  0,  0 },
            },
            [east] = {
                x = { 0, 0,  0,  0,  0,  0,  0,  0 },
                y = { 0, 4, 15, 19, 30, 34, 45, 49 },
            },
            [south] = {
                x = { 0, 4, 15, 19, 30, 34, 45, 49 },
                y = { 0, 0,  0,  0,  0,  0,  0,  0 },
            },
            [west] = {
                x = { 0, 0,  0,  0,  0,  0,  0,  0 },
                y = { 0, 4, 15, 19, 30, 34, 45, 49 },
            },
        },
        positions = {
            [north] = {
                belt = { -25, -31 },
                pipe = { -25, -31 },
            },
            [east] = {
                belt = { 30, -25 },
                pipe = { 30, -25 },
            },
            [south] = {
                belt = { -25, 30 },
                pipe = { -25, 30 },
            },
            [west] = {
                belt = { -31, -25 },
                pipe = { -31, -25 },
            },
        },
    },
    directions = { north, east, south, west },
}

return lib
