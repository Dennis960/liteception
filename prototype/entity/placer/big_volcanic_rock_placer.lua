local big_volcanic_rock = data.raw["simple-entity"]["big-volcanic-rock"]

big_volcanic_rock.flags = {
    "placeable-player",
    "placeable-enemy",
    "not-repairable",
    -- "placeable-off-grid"
}

big_volcanic_rock.collision_mask = {
    layers = {
        is_lower_object = true,
        is_object = true,
        object = true,
        player = true
    }
} -- Allow placement on floor tiles

--- @type data.ItemPrototype
local big_volcanic_rock_placer = {
    type = "item",
    name = "big-volcanic-rock-placer",
    icon = big_volcanic_rock.icon,
    icon_size = big_volcanic_rock.icon_size or 64,
    order = "z[big-volcanic-rock-placer]",
    stack_size = 10,
    group = "production",
    subgroup = "liteception-entity-placer",
    place_result = "big-volcanic-rock",
    auto_recycle = true,
    localised_name = { "item-name.big-volcanic-rock-placer" },
    localised_description = { "item-description.big-volcanic-rock-placer" },
}

--- @type data.RecipePrototype
local big_volcanic_rock_placer_recipe = {
    name = "big-volcanic-rock-placer",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "big-volcanic-rock-placer",
            amount = 1,
        },
    },
    category = "crafting",
    icon = big_volcanic_rock.icon,
    icon_size = big_volcanic_rock.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "coal",
            amount = 50,
        },
        {
            type = "item",
            name = "tungsten-ore",
            amount = 20,
        },
    },
    energy_required = 5,
    surface_conditions = {
        {
            property = "pressure",
            min = 4000,
            max = 4000,
        }
    },
    enabled = false,
}

local planet_discovery_vulcanus_technology = data.raw["technology"]["planet-discovery-vulcanus"]
planet_discovery_vulcanus_technology.effects = planet_discovery_vulcanus_technology.effects or {}
table.insert(planet_discovery_vulcanus_technology.effects, {
    type = "unlock-recipe",
    recipe = "big-volcanic-rock-placer",
})
data:extend({ big_volcanic_rock_placer, big_volcanic_rock_placer_recipe })
