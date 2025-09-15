--[[

    Spawner Placer - Event Handlers to make it change to enemy force on placement

]]

local spawner_placer = {}

--- @param event EventData.on_built_entity | EventData.on_robot_built_entity | EventData.on_space_platform_built_entity
local function on_built_entity(event)
    if event.entity.name ~= "gleba-spawner" and event.entity.name ~= "biter-spawner" then
        return
    end
    event.entity.force = "enemy"
end

spawner_placer.lib = {
    events = {
        [defines.events.on_built_entity] = on_built_entity,
        [defines.events.on_robot_built_entity] = on_built_entity,
        [defines.events.on_space_platform_built_entity] = on_built_entity,
    },
}

return spawner_placer
