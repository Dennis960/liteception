local gleba_spawner = data.raw["unit-spawner"]["gleba-spawner-small"]
gleba_spawner.collision_mask = {
    layers = {
        is_lower_object = true,
        is_object = true,
        object = true,
        player = true
    }
} -- Allow placement on floor tiles

gleba_spawner.flags = {
    "placeable-player",
    "placeable-enemy",
    "not-repairable",
    -- "placeable-off-grid"
}

local pentapod_egg = data.raw["item"]["pentapod-egg"]
--- @type data.ItemPrototype
local gleba_spawner_placer = {
    type = "item",
    name = "gleba-spawner-placer",
    icon = gleba_spawner.icon,
    icon_size = gleba_spawner.icon_size or 64,
    order = "z[gleba-spawner-placer]",
    stack_size = 10,
    group = "production",
    subgroup = "liteception-entity-placer",
    spoil_ticks = 60 * 60 * 30, -- 30 minutes
    spoil_to_trigger_result = pentapod_egg.spoil_to_trigger_result,
    fuel_category = "chemical",
    fuel_value = "20MJ",
    place_result = "gleba-spawner-small",
    auto_recycle = true,
    localised_name = { "item-name.gleba-spawner-placer" },
    localised_description = { "item-description.gleba-spawner-placer" },
    
}
--- @type data.RecipePrototype
local gleba_spawner_placer_recipe = {
    name = "gleba-spawner-placer",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "gleba-spawner-placer",
            amount = 1,
        },
    },
    category = "crafting-with-fluid",
    icon = gleba_spawner.icon,
    icon_size = gleba_spawner.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "wood",
            amount = 100,
        },
        {
            type = "item",
            name = "stone",
            amount = 50,
        },
        {
            type = "fluid",
            name = "water",
            amount = 1000,
        },
    },
    reset_freshness_on_craft = true,
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

--- @type data.TechnologyPrototype
local gleba_spawner_placer_technology = {
    type = "technology",
    name = "gleba-spawner-placer",
    icon = gleba_spawner.icon,
    icon_size = gleba_spawner.icon_size or 64,
    prerequisites = { "yumako", "jellynut" },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "gleba-spawner-placer"
        }
    },
    research_trigger = {
        item = "nutrients",
        type = "craft-item",
        count = 1,
    },
}

local biochamber_technology = data.raw["technology"]["biochamber"]
biochamber_technology.prerequisites = {
    "gleba-spawner-placer",
}
data:extend({ gleba_spawner_placer, gleba_spawner_placer_recipe, gleba_spawner_placer_technology })
