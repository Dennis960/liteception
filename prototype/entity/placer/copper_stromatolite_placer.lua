local copper_stromatolite = data.raw["simple-entity"]["copper-stromatolite"]

copper_stromatolite.flags = {
    "placeable-player",
    "placeable-enemy",
    "not-repairable",
    -- "placeable-off-grid"
}

copper_stromatolite.collision_mask = {
    layers = {
        is_lower_object = true,
        is_object = true,
        object = true,
        player = true
    }
} -- Allow placement on floor tiles

--- @type data.ItemPrototype
local copper_stromatolite_placer = {
    type = "item",
    name = "copper-stromatolite-placer",
    icon = copper_stromatolite.icon,
    icon_size = copper_stromatolite.icon_size or 64,
    order = "z[copper-stromatolite-placer]",
    stack_size = 10,
    group = "production",
    subgroup = "liteception-entity-placer",
    place_result = "copper-stromatolite",
    auto_recycle = true,
    localised_name = { "item-name.copper-stromatolite-placer" },
    localised_description = { "item-description.copper-stromatolite-placer" },
}

--- @type data.RecipePrototype
local copper_stromatolite_placer_recipe = {
    name = "copper-stromatolite-placer",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "copper-stromatolite-placer",
            amount = 1,
        },
    },
    category = "crafting",
    icon = copper_stromatolite.icon,
    icon_size = copper_stromatolite.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "stone",
            amount = 20,
        },
        {
            type = "item",
            name = "yumako",
            amount = 5,
        },
    },
    energy_required = 5,
    surface_conditions = {
        {
            property = "pressure",
            min = 2000,
            max = 2000,
        }
    },
    enabled = false,
}

local planet_discovery_gleba_technology = data.raw["technology"]["planet-discovery-gleba"]
planet_discovery_gleba_technology.effects = planet_discovery_gleba_technology.effects or {}
table.insert(planet_discovery_gleba_technology.effects, {
    type = "unlock-recipe",
    recipe = "copper-stromatolite-placer",
})
data:extend({ copper_stromatolite_placer, copper_stromatolite_placer_recipe })
