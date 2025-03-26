--[[

    Creates several tiers of additional technologies for every resource.

]]

local tiers = {
    {
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
            },
            time = 15,
        },
    },
    {
        unit = {
            count = 100,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 15,
        },
    },
    {
        unit = {
            count = 150,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
            },
            time = 15,
        },
    },
    {
        unit = {
            count = 250,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
            },
            time = 15,
        },
    },
    {
        unit = {
            count = 500,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
            },
            time = 15,
        },
    },
    {
        unit = {
            count = 750,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
            time = 15,
        },
    },
    {
        unit = {
            count = 1000,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack", 1 },
                { "chemical-science-pack", 1 },
                { "production-science-pack", 1 },
                { "utility-science-pack", 1 },
            },
            time = 15,
        },
    },
}

local function create_resource_technologies(resource)
    local resource_name =
        resource.minable.results and
        resource.minable.results[1] and
        resource.minable.results[1].type == "fluid" and
        resource.name .. "-barrel"
    or
        resource.name

    local icon = resource.icon
    local icon_size = resource.icon_size

    if not icon then
        icon = resource.icons[1].icon
        icon_size = resource.icons[1].icon_size
    end

    local previous_name = nil
    for i, tier in ipairs(tiers) do
        local name = "factory-extra-" .. resource_name .. "-" .. i
        data:extend{{
            type = "technology",
            name = name,
            icon = icon,
            icon_size = icon_size,
            order = "f-i-i",
            prerequisites = { previous_name },
            unit = tier.unit,
            -- TODO: Fix "Extra iron-ore 1" -> "Extra Iron ore 1".
            localised_name = {
                "technology-name.extra-resource",
                resource.localised_name or resource_name,
                tostring(i),
            },
        }}
        previous_name = name
    end
end

for _, resource in pairs(data.raw.resource) do
    create_resource_technologies(resource)
end
