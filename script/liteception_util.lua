--[[

    Various utility functions.

]]

local liteception_util = {}

function liteception_util.get_slowest_craftable_belt_name(belts, recipes, is_runtime)
    local slowest_belt_name = nil
    local slowest_belt_speed = nil

    for _, recipe in pairs(recipes) do
        if recipe.enabled == nil or recipe.enabled then
            local results = is_runtime and recipe.products or recipe.results
            if results then
                for _, result in pairs(results) do
                    if belts[result.name] then
                        local belt = belts[result.name]
                        local belt_speed = is_runtime and belt.belt_speed or belt.speed
                        if slowest_belt_name == nil or belt_speed < slowest_belt_speed then
                            slowest_belt_name = belt.name
                            slowest_belt_speed = belt_speed
                        end
                    end
                end
            end
        end
    end

    return slowest_belt_name
end

return liteception_util
