--[[

    Manages resource inputs to the main factory floor.

]]

local factory_input_data = require("static.factory_input_data")

local inputs = {}

function inputs.set_item_input(direction, id, input)
    local indoor_surface = game.get_surface(storage.factory.surface_name)
    local outdoor_surface = game.get_surface(storage.factory.placed_on_surface_name)

    local belt_tier_name = storage.belt_tier_name
    local entity_direction = direction + 8
    if entity_direction >= 16 then entity_direction = entity_direction - 16 end

    local outdoor_pos = factory_input_data.outdoor_pos.positions[direction]
    local indoor_pos = factory_input_data.indoor_pos.positions[direction]
    local outdoor_offset = factory_input_data.outdoor_pos.offsets[direction]
    local outdoor_offset_x = outdoor_offset.x[id]
    local outdoor_offset_y = outdoor_offset.y[id]
    local indoor_offset = factory_input_data.indoor_pos.offsets[direction]
    local indoor_offset_x = indoor_offset.x[id]
    local indoor_offset_y = indoor_offset.y[id]

    local chest_position = {
        outdoor_pos.chest[1] + outdoor_offset_x,
        outdoor_pos.chest[2] + outdoor_offset_y,
    }
    local loader_position = {
        outdoor_pos.loader[1] + outdoor_offset_x,
        outdoor_pos.loader[2] + outdoor_offset_y,
    }
    local outdoor_belt_position = {
        outdoor_pos.belt[1] + outdoor_offset_x,
        outdoor_pos.belt[2] + outdoor_offset_y,
    }
    local indoor_belt_position = {
        indoor_pos.belt[1] + indoor_offset_x,
        indoor_pos.belt[2] + indoor_offset_y,
    }

    local infinity_chest = outdoor_surface.create_entity{
        name = "infinity-chest",
        position = chest_position,
        force = "player",
    }
    local loader = outdoor_surface.create_entity{
        name = "liteception-loader",
        position = loader_position,
        force = "player",
        type = "output",
        direction = entity_direction,
    }
    local outdoor_belt = outdoor_surface.create_entity{
        name = belt_tier_name .. "transport-belt",
        position = outdoor_belt_position,
        direction = entity_direction,
        force = "player",
        raise_built = true,
    }
    local indoor_belt = indoor_surface.create_entity{
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
end

function inputs.get_item_input(direction, id)
    local outdoor_surface = game.get_surface(storage.factory.placed_on_surface_name)

    local outdoor_pos = factory_input_data.outdoor_pos.positions[direction]
    local outdoor_offset = factory_input_data.outdoor_pos.offsets[direction]
    local outdoor_offset_x = outdoor_offset.x[id]
    local outdoor_offset_y = outdoor_offset.y[id]

    local chest_position = {
        outdoor_pos.chest[1] + outdoor_offset_x + 0.5,
        outdoor_pos.chest[2] + outdoor_offset_y + 0.5,
    }

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

function inputs.set_fluid_input(direction, id, input)
    local fluid_input = input:sub(1, input:find("-barrel") - 1)

    local indoor_surface = game.get_surface(storage.factory.surface_name)
    local outdoor_surface = game.get_surface(storage.factory.placed_on_surface_name)

    local entity_direction = direction + 8
    if entity_direction >= 16 then entity_direction = entity_direction - 16 end

    local outdoor_pos = factory_input_data.outdoor_pos.positions[direction]
    local indoor_pos = factory_input_data.indoor_pos.positions[direction]
    local outdoor_offset = factory_input_data.outdoor_pos.offsets[direction]
    local outdoor_offset_x = outdoor_offset.x[id]
    local outdoor_offset_y = outdoor_offset.y[id]
    local indoor_offset = factory_input_data.indoor_pos.offsets[direction]
    local indoor_offset_x = indoor_offset.x[id]
    local indoor_offset_y = indoor_offset.y[id]

    local infinity_pipe_position = {
        outdoor_pos.infinity_pipe[1] + outdoor_offset_x,
        outdoor_pos.infinity_pipe[2] + outdoor_offset_y,
    }
    local indoor_pipe_position = {
        indoor_pos.pipe[1] + indoor_offset_x,
        indoor_pos.pipe[2] + indoor_offset_y,
    }

    local infinity_pipe_name = factory_input_data.infinity_pipes[direction]

    local infinity_pipe = outdoor_surface.create_entity{
        name = infinity_pipe_name,
        position = infinity_pipe_position,
        force = "player",
    }
    local indoor_pipe = indoor_surface.create_entity{
        name = "pipe",
        position = indoor_pipe_position,
        force = "player",
        raise_built = true,
    }

    infinity_pipe.set_infinity_pipe_filter({
        name = fluid_input,
        percentage = 100,
    })

    -- TODO: Rotate factory pumps correctly, as they start in the useless output mode.

    infinity_pipe.force = "enemy"
    indoor_pipe.force = "enemy"
end

function inputs.change_input_amount(name, amount)
    local input = storage.available_inputs[name]
    if input and input.amount then
        input.amount = input.amount + amount
    else
        storage.available_inputs[name] = {name = name, amount = 0}
    end
end

function inputs.remove_input(direction, id)
    local indoor_surface = game.get_surface(storage.factory.surface_name)
    local outdoor_surface = game.get_surface(storage.factory.placed_on_surface_name)

    local outdoor_pos = factory_input_data.outdoor_pos.positions[direction]
    local indoor_pos = factory_input_data.indoor_pos.positions[direction]
    local outdoor_offset = factory_input_data.outdoor_pos.offsets[direction]
    local outdoor_offset_x = outdoor_offset.x[id]
    local outdoor_offset_y = outdoor_offset.y[id]
    local indoor_offset = factory_input_data.indoor_pos.offsets[direction]
    local indoor_offset_x = indoor_offset.x[id]
    local indoor_offset_y = indoor_offset.y[id]

    local chest_position = {
        outdoor_pos.chest[1] + outdoor_offset_x + 0.5,
        outdoor_pos.chest[2] + outdoor_offset_y + 0.5,
    }
    local outdoor_belt_position = {
        outdoor_pos.belt[1] + outdoor_offset_x + 0.5,
        outdoor_pos.belt[2] + outdoor_offset_y + 0.5,
    }
    local indoor_belt_position = {
        indoor_pos.belt[1] + indoor_offset_x + 0.5,
        indoor_pos.belt[2] + indoor_offset_y + 0.5,
    }
    local indoor_pipe_position = {
        indoor_pos.pipe[1] + indoor_offset_x + 0.5,
        indoor_pos.pipe[2] + indoor_offset_y + 0.5,
    }

    local infinity_pipe_name = factory_input_data.infinity_pipes[direction]

    local outside = outdoor_surface.find_entities{ chest_position, outdoor_belt_position }
    if outside[1] == nil then
        outside = outdoor_surface.find_entities{ outdoor_belt_position, chest_position }
    end
    local inside = indoor_surface.find_entities{ indoor_pipe_position, indoor_belt_position }

    for _, entity in pairs(outside) do
        if entity.name == infinity_pipe_name then
            local filter = entity.get_infinity_pipe_filter(1)
            if filter ~= nil then
                inputs.change_input_amount(filter.name .. "-barrel", 1)
            end
        elseif entity.name == "infinity-chest" then
            local filter = entity.get_infinity_container_filter(1)
            if filter ~= nil then
                inputs.change_input_amount(filter.name, 1)
            end
        end
        entity.destroy{ raise_destroy = true }
    end

    for _, entity in pairs(inside) do
        entity.destroy{ raise_destroy = true }
    end
end

function inputs.set_input(direction, id, value)
    storage.selected[direction][id] = value

    inputs.remove_input(direction, id)

    if value ~= nil then
        if value:find("barrel") == nil then
            inputs.set_item_input(direction, id, value)
            inputs.change_input_amount(value, -1)
        else
            inputs.set_fluid_input(direction, id, value)
            inputs.change_input_amount(value, -1)
        end
    end
end

function inputs.add_factory_input(prototype)
    local resource_name
    if prototype.resource_category:find("fluid") ~= nil then
        resource_name = prototype.name .. "-barrel"
    else
        resource_name = prototype.name
    end

    -- Don't duplicate resources
    if storage.available_inputs[resource_name] ~= nil then
        return
    end

    storage.available_inputs[resource_name] = { name = resource_name, amount = 1 }
end

local function replace_belts()
    for _, direction in ipairs(factory_input_data.directions) do
        for id = 1, 8 do
            local item = inputs.get_item_input(direction, id)
            if item then
                inputs.remove_input(direction, id)
                inputs.set_item_input(direction, id, item)
            end
        end
    end
end

local function on_init()
    storage.players = {}
    storage.used_items = {}
    storage.available_inputs = {
        ["water-barrel"] = { name = "water-barrel", amount = 1 },
        ["wood"] = { name = "wood", amount = 1 },
    }

    -- Find and add all resources to available_inputs.
    local resources = prototypes.get_entity_filtered{{
        filter = "type",
        type = "resource",
    }}
    for _, prototype in pairs(resources) do
        inputs.add_factory_input(prototype)
    end

    -- Find the slowest belt to use as input connection.
    local slowest_belt_name = nil
    local slowest_belt_speed = nil
    for _, prototype in pairs(prototypes.get_entity_filtered{{ filter = "type", type = "transport-belt" }}) do
        if prototype.type == "transport-belt" then
            if slowest_belt_name == nil then
                slowest_belt_name = prototype.name
                slowest_belt_speed = prototype.belt_speed
            else
                if prototype.belt_speed < slowest_belt_speed then
                    slowest_belt_name = prototype.name
                    slowest_belt_speed = prototype.belt_speed
                end
            end
        end
    end

    -- Trim "-transport-belt" off the belt name.
    local trimmed_belt_name = slowest_belt_name:sub(1, -16)
    if trimmed_belt_name ~= "" then
        trimmed_belt_name = trimmed_belt_name .. "-"
    end
    storage.belt_tier_name = trimmed_belt_name

    storage.selected = {}
    for _, v in pairs(defines.direction) do
        storage.selected[v] = {}
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
    elseif event.research.name:find("factory%-extra%-") ~= nil then
        local resource_name = event.research.name:sub(15, -3)
        inputs.change_input_amount(resource_name, 1)
    end
end

inputs.lib = {
    on_init = on_init,
    events = {
        [defines.events.on_research_finished] = on_research_finished,
    },
}

return inputs
