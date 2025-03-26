--[[

    Provides the intended map generation settings as the "Liteception" preset on the Map Generator page.

]]

-- TODO: Nitpick, if the map generator window opens with Liteception as the default,
-- why does it label it as modified?

local preset = {
    order = "aa",
    basic_settings = {
        width = 48,
        height = 48,
        autoplace_controls = {
            ["enemy-base"] = { frequency = 0 },
        },
    },
    advanced_settings = {
        pollution = { enabled = false },
        enemy_evolution = { enabled = false },
        enemy_expansion = { enabled = false },
    },
}

data.raw["map-gen-presets"].default["liteception"] = preset
