local lava_barrel = table.deepcopy(data.raw["item"]["water-barrel"])
lava_barrel.name = "lava-barrel"
lava_barrel.localised_name = { "item-name.lava-barrel" }
lava_barrel.localised_description = { "item-description.lava-barrel" }
lava_barrel.icons = {
    { icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",         icon_size = 64 },
    { icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",     icon_size = 64, tint = { r = 1, g = 0.3, b = 0, a = 0.75 } },
    { icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png", icon_size = 64, tint = { r = 1, g = 0.7, b = 0.2, a = 0.75 } },
}

local fluorine_barrel = table.deepcopy(data.raw["item"]["water-barrel"])
fluorine_barrel.name = "fluorine-barrel"
fluorine_barrel.localised_name = { "item-name.fluorine-barrel" }
fluorine_barrel.localised_description = { "item-description.fluorine-barrel" }
fluorine_barrel.icons = {
    { icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",         icon_size = 64 },
    { icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",     icon_size = 64, tint = { r = 0.3, g = 0.8, b = 1, a = 0.75 } },
    { icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png", icon_size = 64, tint = { r = 0.7, g = 1, b = 1, a = 0.75 } },
}

local lithium_brine_barrel = table.deepcopy(data.raw["item"]["water-barrel"])
lithium_brine_barrel.name = "lithium-brine-barrel"
lithium_brine_barrel.localised_name = { "item-name.lithium-brine-barrel" }
lithium_brine_barrel.localised_description = { "item-description.lithium-brine-barrel" }
lithium_brine_barrel.icons = {
    { icon = "__base__/graphics/icons/fluid/barreling/empty-barrel.png",         icon_size = 64 },
    { icon = "__base__/graphics/icons/fluid/barreling/barrel-side-mask.png",     icon_size = 64, tint = { r = 0.7, g = 0.9, b = 0.6, a = 0.75 } },
    { icon = "__base__/graphics/icons/fluid/barreling/barrel-hoop-top-mask.png", icon_size = 64, tint = { r = 0.9, g = 1, b = 0.7, a = 0.75 } },
}

data:extend { lava_barrel, fluorine_barrel, lithium_brine_barrel }
