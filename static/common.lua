--[[

    Constant data shared by all factories.

]]

local north = defines.direction.north
local east  = defines.direction.east
local south = defines.direction.south
local west  = defines.direction.west

local common = {
    directions = { north, east, south, west },
    infinity_pipes = {
        [north] = "vertical-infinity-pipe",
        [east]  = "horizontal-infinity-pipe",
        [south] = "vertical-infinity-pipe",
        [west]  = "horizontal-infinity-pipe",
    },
}

return common
