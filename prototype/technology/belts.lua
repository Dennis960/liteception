--[[

    Creates input belt upgrade technology for each tier of belt (except the slowest one).

]]


-- Make a map of all belts
local belt_names = {}
for _, belt in pairs(data.raw["transport-belt"]) do
    belt_names[belt.name] = true
end


-- Find every researchable belt. Add a new input belt upgrade technology that
-- depends on the original technology.
for _, tech in pairs(data.raw["technology"]) do
    if tech.effects then
        for _, effect in pairs(tech.effects) do
            if effect.type == "unlock-recipe" then
                local has_recipe = ""

                local recipe = data.raw.recipe[effect.recipe]
                for _, result in pairs(recipe.results) do
                    if result.name and belt_names[result.name] then
                        has_recipe = result.name
                    end
                end

                if has_recipe ~= "" then
                    local item = data.raw.item[has_recipe]

                    data:extend{{
                        type = "technology",
                        name = "liteception-belt-" .. has_recipe,
                        icon = item.icon,
                        icon_size = item.icon_size,
                        prerequisites = { tech.name },
                        unit = {
                            count = math.min(tech.unit.count, 500),
                            ingredients = tech.unit.ingredients,
                            time = 15,
                        },
                        localised_name = { "technology-name.input-belt", "item-name." .. has_recipe },
                    }}
                    belt_names[has_recipe] = nil
                end
            end
        end
    end
end


-- Find the slowest belt - remove it from the map as it doesn't need its own technology.
local slowest_belt_name = nil
local slowest_belt_speed = nil
for belt_name, _ in pairs(belt_names) do
    local belt_speed = data.raw["transport-belt"][belt_name].speed
    if slowest_belt_name == nil then
        slowest_belt_name = belt_name
        slowest_belt_speed = belt_speed
    elseif data.raw["transport-belt"][belt_name].speed < slowest_belt_speed then
        slowest_belt_name = belt_name
        slowest_belt_speed = belt_speed
    end
end

belt_names[slowest_belt_name] = nil


-- Add all remaining belts as level 0 technologies
for belt_name in pairs(belt_names) do
    local item = data.raw.item[belt_name]
    data:extend{{
        type = "technology",
        name = "liteception-belt-" .. belt_name,
        icon = item.icon,
        icon_size = item.icon_size,
        unit = {
            count = 100,
            ingredients = {{ "automation-science-pack", 1 }},
            time = 15,
        },
        localised_name = { "technology-name.input-belt", "item-name." .. belt_name },
    }}
end
