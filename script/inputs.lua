--[[

    Manages resource inputs to the main factory floor.

]]

local all_factory_data = require("static.all_factory_data")
local liteception_util = require("script.liteception_util")

local inputs = {}

local function get_position(is_indoor, name, direction, id, offset)
    local surface_position_data = is_indoor and storage.factory_data.indoor_pos or storage.factory_data.outdoor_pos
    local position = surface_position_data.positions[direction]

    local offsets = surface_position_data.offsets[direction]

    local offset_x, offset_y
    if direction == defines.direction.north or direction == defines.direction.south then
        offset_x = offsets[id]
        offset_y = 0
    else
        offset_x = 0
        offset_y = offsets[id]
    end

    return {
        position[name][1] + offset_x + offset,
        position[name][2] + offset_y + offset,
    }
end

function inputs.set_item_input(direction, id, input, surface_name)
    local indoor_surface = game.get_surface(storage.factory[surface_name].surface_name)
    local outdoor_surface = game.get_surface(storage.factory[surface_name].placed_on_surface_name)
    if indoor_surface == nil or outdoor_surface == nil then
        game.print("Error setting item input: surface is nil.")
        return
    end

    local belt_tier_name = storage.belt_tier_name
    local entity_direction = direction + 8
    if entity_direction >= 16 then entity_direction = entity_direction - 16 end

    local chest_position = get_position(false, "chest", direction, id, 0)
    local loader_position = get_position(false, "loader", direction, id, 0)
    local outdoor_belt_position = get_position(false, "belt", direction, id, 0)
    local indoor_belt_position = get_position(true, "belt", direction, id, 0)

    local infinity_chest = outdoor_surface.create_entity {
        name = "infinity-chest",
        position = chest_position,
        force = "player",
    }
    if infinity_chest == nil then
        game.print("Error setting item input: infinity chest is nil.")
        return
    end
    local loader = outdoor_surface.create_entity {
        name = "liteception-loader",
        position = loader_position,
        force = "player",
        type = "output",
        direction = entity_direction,
    }
    local outdoor_belt = outdoor_surface.create_entity {
        name = belt_tier_name .. "transport-belt",
        position = outdoor_belt_position,
        direction = entity_direction,
        force = "player",
        raise_built = true,
    }
    local indoor_belt = indoor_surface.create_entity {
        name = belt_tier_name .. "transport-belt",
        position = indoor_belt_position,
        direction = entity_direction,
        force = "player",
        raise_built = true,
    }

    infinity_chest.set_infinity_container_filter(1, {
        name = input,
        count = 50,
        index = 1,
    })

    infinity_chest.force = "enemy"
    loader.force = "enemy"
    outdoor_belt.force = "enemy"
    indoor_belt.force = "enemy"
    indoor_belt.destructible = false
end

function inputs.get_item_input(direction, id, surface_name)
    local outdoor_surface = game.get_surface(storage.factory[surface_name].placed_on_surface_name)
    if outdoor_surface == nil then
        game.print("Error getting item input: surface is nil.")
        return nil
    end

    local chest_position = get_position(false, "chest", direction, id, 0.5)

    local infinity_chest = outdoor_surface.find_entity("infinity-chest", chest_position)

    if infinity_chest ~= nil then
        local filter = infinity_chest.get_infinity_container_filter(1)
        if filter ~= nil then
            return filter.name
        end
        return nil
    end

    return nil
end

function inputs.set_fluid_input(direction, id, input, surface_name)
    local fluid_input = input:sub(1, input:find("-barrel") - 1)

    local indoor_surface = game.get_surface(storage.factory[surface_name].surface_name)
    local outdoor_surface = game.get_surface(storage.factory[surface_name].placed_on_surface_name)
    if indoor_surface == nil or outdoor_surface == nil then
        game.print("Error setting fluid input: surface is nil.")
        return
    end

    local entity_direction = direction + 8
    if entity_direction >= 16 then entity_direction = entity_direction - 16 end

    local infinity_pipe_position = get_position(false, "infinity_pipe", direction, id, 0)
    local indoor_pipe_position = get_position(true, "pipe", direction, id, 0)

    local infinity_pipe_name = all_factory_data.infinity_pipes[direction]

    local infinity_pipe = outdoor_surface.create_entity {
        name = infinity_pipe_name,
        position = infinity_pipe_position,
        force = "player",
    }
    if infinity_pipe == nil then
        game.print("Error setting fluid input: infinity pipe is nil.")
        return
    end
    local indoor_pipe = indoor_surface.create_entity {
        name = "pipe",
        position = indoor_pipe_position,
        force = "player",
        raise_built = true,
    }
    indoor_pipe.destructible = false

    infinity_pipe.set_infinity_pipe_filter({
        name = fluid_input,
        percentage = 100,
    })

    -- TODO: Rotate factory pumps correctly, as they start in the useless output mode.

    infinity_pipe.force = "enemy"
    indoor_pipe.force = "enemy"
end

function inputs.remove_input(direction, id, surface_name)
    local indoor_surface = game.get_surface(storage.factory[surface_name].surface_name)
    local outdoor_surface = game.get_surface(storage.factory[surface_name].placed_on_surface_name)
    if indoor_surface == nil or outdoor_surface == nil then
        game.print("Error removing input: surface is nil.")
        return
    end

    local chest_position = get_position(false, "chest", direction, id, 0.5)
    local outdoor_belt_position = get_position(false, "belt", direction, id, 0.5)
    local indoor_belt_position = get_position(true, "belt", direction, id, 0.5)
    local indoor_pipe_position = get_position(true, "pipe", direction, id, 0.5)

    local outside = outdoor_surface.find_entities { chest_position, outdoor_belt_position }
    if outside[1] == nil then
        outside = outdoor_surface.find_entities { outdoor_belt_position, chest_position }
    end
    local inside = indoor_surface.find_entities { indoor_pipe_position, indoor_belt_position }

    for _, entity in pairs(outside) do
        entity.destroy { raise_destroy = true }
    end

    for _, entity in pairs(inside) do
        entity.destroy { raise_destroy = true }
    end
end

function inputs.set_input(direction, id, value, surface_name)
    storage.selected[surface_name][direction][id] = value

    inputs.remove_input(direction, id, surface_name)

    if value ~= nil then
        if value:find("barrel") == nil then
            inputs.set_item_input(direction, id, value, surface_name)
        else
            inputs.set_fluid_input(direction, id, value, surface_name)
        end
    end
end

local function replace_belts()
    for _, direction in ipairs(all_factory_data.directions) do
        for _, id in ipairs(storage.factory_data.gui_inputs[direction]) do
            if id ~= 0 then
                for _, planet_name in pairs(all_factory_data.planet_names) do
                    local surface_name = planet_name
                    local item = inputs.get_item_input(direction, id, surface_name)
                    if item then
                        inputs.remove_input(direction, id, surface_name)
                        inputs.set_input(direction, id, item, surface_name)
                    end
                end
            end
        end
    end
end

local function on_init()
    storage.players = {
        elements = {
            main_frame = {}
        },
    }
    storage.used_items = {}
    storage.available_inputs = {}
    storage.available_inputs["nauvis"] = {
        ["wood"] = { name = "wood" },
        ["coal"] = { name = "coal" },
        ["stone"] = { name = "stone" },
        ["iron-ore"] = { name = "iron-ore" },
        ["copper-ore"] = { name = "copper-ore" },
        ["uranium-ore"] = { name = "uranium-ore" },
        ["water-barrel"] = { name = "water-barrel" },
        ["crude-oil-barrel"] = { name = "crude-oil-barrel" },
        ["raw-fish"] = { name = "raw-fish" },
    }
    storage.available_inputs["vulcanus"] = {
        ["coal"] = { name = "coal" },
        ["tungsten-ore"] = { name = "tungsten-ore" },
        ["sulfuric-acid-barrel"] = { name = "sulfuric-acid-barrel" },
        ["calcite"] = { name = "calcite" },
        ["lava-barrel"] = { name = "lava-barrel" },
    }
    storage.available_inputs["gleba"] = {
        ["yumako"] = { name = "yumako" },
        ["jellynut"] = { name = "jellynut" },
        ["water-barrel"] = { name = "water-barrel" },
        ["wood"] = { name = "wood" },
        ["stone"] = { name = "stone" },
    }
    storage.available_inputs["fulgora"] = {
        ["scrap"] = { name = "scrap" },
        ["heavy-oil-barrel"] = { name = "heavy-oil-barrel" },
    }
    storage.available_inputs["aquilo"] = {
        ["fluorine-barrel"] = { name = "fluorine-barrel" },
        ["lithium-brine-barrel"] = { name = "lithium-brine-barrel" },
        ["crude-oil-barrel"] = { name = "crude-oil-barrel" },
    }

    local belts = prototypes.get_entity_filtered { { filter = "type", type = "transport-belt" } }
    local slowest_belt_name = liteception_util.get_slowest_craftable_belt_name(belts, prototypes.recipe, true)
    if slowest_belt_name == nil then
        slowest_belt_name = "transport-belt"
    end

    -- Trim "-transport-belt" off the belt name.
    local trimmed_belt_name = slowest_belt_name:sub(1, -16)
    if trimmed_belt_name ~= "" then
        trimmed_belt_name = trimmed_belt_name .. "-"
    end
    storage.belt_tier_name = trimmed_belt_name

    storage.selected = {}
    for _, planet_name in pairs(all_factory_data.planet_names) do
        storage.selected[planet_name] = {}
        for _, v in pairs(defines.direction) do
            storage.selected[planet_name][v] = {}
        end
    end
end

local function on_research_finished(event)
    if event.research.name == nil then
        return
    end

    if event.research.name:find("liteception%-belt%-") then
        -- Trim "liteception-belt-" and "-transport-belt"
        local belt_tier_name = event.research.name:sub(18, -16)
        if belt_tier_name ~= "" then
            belt_tier_name = belt_tier_name .. "-"
        end

        local current_name = storage.belt_tier_name .. "transport-belt"
        local current_speed = prototypes.entity[current_name].belt_speed

        local new_name = belt_tier_name .. "transport-belt"
        local new_speed = prototypes.entity[new_name].belt_speed

        if new_speed > current_speed then
            storage.belt_tier_name = belt_tier_name
            replace_belts()
        end
    end
end

inputs.lib = {
    on_init = on_init,
    events = {
        [defines.events.on_research_finished] = on_research_finished,
    },
}

return inputs
