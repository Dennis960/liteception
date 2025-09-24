local iron_stromatolite = data.raw["simple-entity"]["iron-stromatolite"]

iron_stromatolite.flags = {
    "placeable-player",
    "placeable-enemy",
    "not-repairable",
    -- "placeable-off-grid"
}

iron_stromatolite.collision_mask = {
    layers = {
        is_lower_object = true,
        is_object = true,
        object = true,
        player = true
    }
} -- Allow placement on floor tiles

--- @type data.ItemPrototype
local iron_stromatolite_placer = {
    type = "item",
    name = "iron-stromatolite-placer",
    icon = iron_stromatolite.icon,
    icon_size = iron_stromatolite.icon_size or 64,
    order = "z[iron-stromatolite-placer]",
    stack_size = 10,
    group = "production",
    subgroup = "liteception-entity-placer",
    place_result = "iron-stromatolite",
    auto_recycle = true,
    localised_name = { "item-name.iron-stromatolite-placer" },
    localised_description = { "item-description.iron-stromatolite-placer" },
}

--- @type data.RecipePrototype
local iron_stromatolite_placer_recipe = {
    name = "iron-stromatolite-placer",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "iron-stromatolite-placer",
            amount = 1,
        },
    },
    category = "crafting",
    icon = iron_stromatolite.icon,
    icon_size = iron_stromatolite.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "stone",
            amount = 20,
        },
        {
            type = "item",
            name = "jellynut",
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
    recipe = "iron-stromatolite-placer",
})
data:extend({ iron_stromatolite_placer, iron_stromatolite_placer_recipe })
