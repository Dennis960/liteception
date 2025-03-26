--[[

    

]]

local horizontal_pipe = table.deepcopy(data.raw["infinity-pipe"]["infinity-pipe"])
horizontal_pipe.name = "horizontal-infinity-pipe"
horizontal_pipe.fluid_box.pipe_connections = {
    { direction = defines.direction.east, position = { 0, 0 } },
    { direction = defines.direction.west, position = { 0, 0 } },
}

local vertical_pipe = table.deepcopy(data.raw["infinity-pipe"]["infinity-pipe"])
vertical_pipe.name = "vertical-infinity-pipe"
vertical_pipe.fluid_box.pipe_connections = {
    { direction = defines.direction.north, position = { 0, 0 } },
    { direction = defines.direction.south, position = { 0, 0 } },
}

data:extend{horizontal_pipe, vertical_pipe}
