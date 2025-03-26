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

local previous_name = nil
for k, tier in ipairs(tiers) do
    local name = "factory-extra-water-barrel-" .. k
    data:extend{{
        type = "technology",
        name = name,
        icon = "__base__/graphics/icons/fluid/water.png",
        icon_size = 64,
        order = "f-i-i",
        prerequisites = { previous_name },
        unit = tier.unit,
    }}
    previous_name = name
end
