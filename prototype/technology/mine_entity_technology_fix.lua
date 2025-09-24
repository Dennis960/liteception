--[[

    Since the player doesn't have access to resource patches, they can't unlock
    technologies with entity mine triggers, e.g. mining oil to unlock Basic Oil
    Processing. To remedy this, we give all such technologies a traditional
    science pack cost.

]]

local technologies = data.raw["technology"]

local function table_contains(tbl, val)
    for _, v in ipairs(tbl) do
        if v == val then
            return true
        end
    end
    return false
end

local minable_entities = { "big-volcanic-rock", "iron-stromatolite", "copper-stromatolite", "fulgoran-ruin-vault" } -- These are the entities we can manually craft and place

for _, tech in pairs(technologies) do
    local trigger = tech.research_trigger
    if trigger ~= nil and trigger.type == "mine-entity" and not table_contains(minable_entities, trigger.entity) then
        tech.research_trigger = nil
        tech.unit = {
            count = 100,
            ingredients = { { "automation-science-pack", 1 } },
            time = 15,
        }
    end
end
