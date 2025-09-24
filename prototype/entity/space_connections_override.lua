local all_factory_data = require("static.all_factory_data")

local restricted_to_factory3 = {
    "artillery-turret",
    "rocket-silo",
    "cargo-landing-pad",
}

for _, prototype in pairs(restricted_to_factory3) do
    for _, entity in pairs(data.raw[prototype]) do
        entity.surface_conditions = nil
    end
end

-- Create space-connections between factory floors
for _, planet_name in ipairs(all_factory_data.planet_names) do
    local planet = data.raw.planet[planet_name]
    local planet_copy = table.deepcopy(planet)
    if planet_copy.name == "fulgora" then
        planet_copy.lightning_properties = nil
    end
    planet.distance = planet.distance + 5
    planet.orientation = planet.orientation + 0.25
    planet_copy.name = planet_name .. "-factory-floor"
    planet_copy.order = "e[" .. planet_name .. "-factory-floor]"
    data:extend({
        planet_copy,
    })
    for _, planet_name2 in ipairs(all_factory_data.planet_names) do
        if planet_name2 ~= planet_name then
            local connection_name = planet_name .. "-" .. planet_name2
            local connection = data.raw["space-connection"][connection_name]
            if connection ~= nil then
                local connection_copy = table.deepcopy(connection)
                connection_copy.name = planet_name .. "-factory-floor-" .. planet_name2 .. "-factory-floor"
                connection_copy.from = planet_name .. "-factory-floor"
                connection_copy.to = planet_name2 .. "-factory-floor"
                data:extend({
                    connection_copy,
                })
            end
        end
    end
    local connection_name = "aquilo-solar-system-edge"
    local connection = data.raw["space-connection"][connection_name]
    local connection_copy = table.deepcopy(connection)
    connection_copy.name = "aquilo-factory-floor-solar-system-edge"
    connection_copy.from = "aquilo-factory-floor"
    connection_copy.to = "solar-system-edge"
    data:extend({
        connection_copy,
    })
end
