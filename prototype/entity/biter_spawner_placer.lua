local biter_spawner = data.raw["unit-spawner"]["biter-spawner"]

biter_spawner.flags = {
    "placeable-player",
    "placeable-enemy",
    "not-repairable",
    -- "placeable-off-grid"
}

local biter_egg = data.raw["item"]["biter-egg"]
--- @type data.ItemPrototype
local biter_spawner_placer = {
    type = "item",
    name = "biter-spawner-placer",
    icon = biter_spawner.icon,
    icon_size = biter_spawner.icon_size or 64,
    order = "z[biter-spawner-placer]",
    stack_size = 10,
    group = "production",
    subgroup = "agriculture",
    spoil_ticks = 60 * 60 * 30, -- 30 minutes
    spoil_to_trigger_result = biter_egg.spoil_to_trigger_result,
    fuel_category = "chemical",
    fuel_value = "20MJ",
    place_result = "biter-spawner",
    auto_recycle = true,
    localised_name = { "item-name.biter-spawner-placer" },
    localised_description = { "item-description.biter-spawner-placer" },
}

--- @type data.RecipePrototype
local biter_spawner_placer_recipe = {
    name = "biter-spawner-placer",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "biter-spawner-placer",
            amount = 1,
        },
    },
    category = "crafting-with-fluid",
    icon = biter_spawner.icon,
    icon_size = biter_spawner.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "wood",
            amount = 100,
        },
        {
            type = "item",
            name = "coal",
            amount = 50,
        },
        {
            type = "fluid",
            name = "heavy-oil",
            amount = 1000,
        },
    },
    reset_freshness_on_craft = true,
    energy_required = 5,
    surface_conditions = {
        {
            property = "pressure",
            min = 1000,
            max = 1000,
        }
    },
    enabled = false,
}


local captivity_technology = data.raw["technology"]["captivity"]
captivity_technology.effects = captivity_technology.effects or {}
table.insert(captivity_technology.effects, {
    type = "unlock-recipe",
    recipe = "biter-spawner-placer"
})
data:extend({ biter_spawner_placer, biter_spawner_placer_recipe })
