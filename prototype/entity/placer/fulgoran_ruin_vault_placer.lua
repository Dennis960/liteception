local fulgoran_ruin_vault = data.raw["simple-entity"]["fulgoran-ruin-vault"]

fulgoran_ruin_vault.flags = {
    "placeable-player",
    "placeable-enemy",
    "not-repairable",
    -- "placeable-off-grid"
}

fulgoran_ruin_vault.collision_mask = {
    layers = {
        is_lower_object = true,
        is_object = true,
        object = true,
        player = true
    }
} -- Allow placement on floor tiles

--- @type data.ItemPrototype
local fulgoran_ruin_vault_placer = {
    type = "item",
    name = "fulgoran-ruin-vault-placer",
    icon = fulgoran_ruin_vault.icon,
    icon_size = fulgoran_ruin_vault.icon_size or 64,
    order = "z[fulgoran-ruin-vault-placer]",
    stack_size = 1,
    group = "production",
    subgroup = "liteception-entity-placer",
    place_result = "fulgoran-ruin-vault",
    auto_recycle = true,
    localised_name = { "item-name.fulgoran-ruin-vault-placer" },
    localised_description = { "item-description.fulgoran-ruin-vault-placer" },
}

--- @type data.RecipePrototype
local fulgoran_ruin_vault_placer_recipe = {
    name = "fulgoran-ruin-vault-placer",
    type = "recipe",
    results = {
        {
            type = "item",
            name = "fulgoran-ruin-vault-placer",
            amount = 1,
        },
    },
    category = "crafting",
    icon = fulgoran_ruin_vault.icon,
    icon_size = fulgoran_ruin_vault.icon_size or 64,
    ingredients = {
        {
            type = "item",
            name = "scrap",
            amount = 500,
        },
    },
    energy_required = 5,
    surface_conditions = {
        {
            property = "magnetic-field",
            min = 99,
            max = 99,
        }
    },
    enabled = false,
}


local planet_discovery_fulgora_technology = data.raw["technology"]["planet-discovery-fulgora"]
planet_discovery_fulgora_technology.effects = planet_discovery_fulgora_technology.effects or {}
table.insert(planet_discovery_fulgora_technology.effects, {
    type = "unlock-recipe",
    recipe = "fulgoran-ruin-vault-placer",
})
data:extend({ fulgoran_ruin_vault_placer, fulgoran_ruin_vault_placer_recipe })
