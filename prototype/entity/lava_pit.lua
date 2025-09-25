local steel_chest = data.raw["container"]["steel-chest"]

local lava_pit_entity = table.deepcopy(steel_chest)
lava_pit_entity.name = "liteception-lava-pit"
lava_pit_entity.icon = "__liteception__/graphics/entity/lava_pit/lava-pit.png"
lava_pit_entity.icon_size = 64
lava_pit_entity.minable = { mining_time = 0.5 }
lava_pit_entity.picture.layers = {
    {
        filename = "__liteception__/graphics/entity/lava_pit/lava-pit.png",
        width = 64,
        height = 64,
        shift = { 0, 0 },
        scale = 0.5,
    }
}
lava_pit_entity.hit_visualization_box = nil
lava_pit_entity.quality_affects_inventory_size = false
lava_pit_entity.surface_conditions = {
    {
        property = "pressure",
        min = 4000,
        max = 4000,
    },
}


local steel_chest_item = data.raw["item"]["steel-chest"]
local lava_pit_item = table.deepcopy(steel_chest_item)
lava_pit_item.name = "liteception-lava-pit"
lava_pit_item.icon = lava_pit_entity.icon
lava_pit_item.icon_size = lava_pit_entity.icon_size or 64
lava_pit_item.order = "z[liteception-lava-pit]"
lava_pit_item.place_result = "liteception-lava-pit"
lava_pit_item.localised_name = "item-name.liteception-lava-pit"
lava_pit_item.localised_description = "item-description.liteception-lava-pit"

--- @type data.RecipePrototype
local lava_pit_recipe = {
    name = "liteception-lava-pit",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "liteception-lava-pit",
            amount = 1,
        },
    },
    category = "crafting",
    icon = lava_pit_entity.icon,
    icon_size = lava_pit_entity.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "tungsten-plate",
            amount = 50,
        },
        {
            type = "item",
            name = "stone",
            amount = 100,
        },
        {
            type = "item",
            name = "steel-plate",
            amount = 200,
        },
    },
    energy_required = 30,
    enabled = false,
    surface_conditions = {
        {
            property = "pressure",
            min = 4000,
            max = 4000,
        }
    },
}

--- @type data.TechnologyPrototype
local lava_pit_technology = {
    type = "technology",
    name = "liteception-lava-pit",
    icon = "__liteception__/graphics/entity/lava_pit/lava-pit.png",
    icon_size = 128,
    prerequisites = { "metallurgic-science-pack" },
    unit = {
        count = 50,
        ingredients = {
            { "metallurgic-science-pack", 1 }
        },
        time = 30
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "liteception-lava-pit"
        }
    }
}

data:extend({ lava_pit_entity, lava_pit_item, lava_pit_recipe, lava_pit_technology })
