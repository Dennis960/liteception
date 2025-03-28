--[[

    Constant data used for positioning of factory elements.

]]

local north = defines.direction.north
local east  = defines.direction.east
local south = defines.direction.south
local west  = defines.direction.west

local factory_data = {
    factories = {
        ["factory-1"] = require("static.factory_data.factory_1"),
        ["factory-2"] = require("static.factory_data.factory_2"),
        ["factory-3"] = require("static.factory_data.factory_3"),
    },
    directions = { north, east, south, west },
    infinity_pipes = {
        [north] = "vertical-infinity-pipe",
        [east]  = "horizontal-infinity-pipe",
        [south] = "vertical-infinity-pipe",
        [west]  = "horizontal-infinity-pipe",
    },
}

return factory_data
