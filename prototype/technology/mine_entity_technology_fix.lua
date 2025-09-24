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

for _, tech in pairs(technologies) do
    local trigger = tech.research_trigger
    if trigger ~= nil then
        if trigger.type == "mine-entity" then
            local minable_entities = { "big-volcanic-rock", "iron-stromatolite", "copper-stromatolite", "fulgoran-ruin-vault" } -- These are the entities we have placers for
            if not table_contains(minable_entities, trigger.entity) then
                tech.research_trigger = nil

                local has_new_cost = false
                for _, prerequisite_name in pairs(tech.prerequisites) do
                    local prerequisite = technologies[prerequisite_name]
                    if prerequisite.unit ~= nil then
                        tech.unit = {
                            count = 100,
                            ingredients = prerequisite.unit.ingredients,
                            time = prerequisite.unit.time,
                        }
                        has_new_cost = true
                        break
                    end
                end

                if not has_new_cost then
                    tech.unit = {
                        count = 100,
                        ingredients = { { "automation-science-pack", 1 } },
                        time = 15,
                    }
                end
            end
        end
    end
end
