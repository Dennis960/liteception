--[[

    Finds the fastest existing belt, and creates a loader fast enough to support it.

]]

local fastest_belt_speed = nil

for _, belt in pairs(data.raw["transport-belt"]) do
    if fastest_belt_speed == nil then
        fastest_belt_speed = belt.speed
    else
        if belt.speed > fastest_belt_speed then
            fastest_belt_speed = belt.speed
        end
    end
end

local loader = util.table.deepcopy(data.raw["loader"]["loader"])
loader.name = "liteception-loader"
loader.speed = fastest_belt_speed

data:extend{loader}
