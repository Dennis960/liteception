--[[

    Create the main factory and set it up properly, including researching necessary technologies.
    Move the player into the factory on game start or respawn.

]]

local all_factory_data = require("static.all_factory_data")

local factory = {}

--- @param surface_name string
local function initialize_surface_factory(surface_name)
    local factory_surface_name = surface_name .. "-factory-floor"
    local outside_surface = game.get_surface(surface_name)
    if outside_surface == nil then
        return game.print("Error initializing factory: outside surface is nil.")
    end


    -- Create factory
    local factory_entity = outside_surface.create_entity {
        name = storage.factory_data.entity_name,
        position = storage.factory_data.entity_position,
        force = "player",
        raise_built = true,
    }
    if factory_entity == nil then
        return game.print("Error initializing factory: factory entity is nil.")
    end


    -- Block factory entrance
    local tiles = {}

    for _, tile_fill in ipairs(storage.factory_data.tile_fills) do
        for y = tile_fill.top, tile_fill.bottom do
            for x = tile_fill.left, tile_fill.right do
                table.insert(tiles, {
                    name = tile_fill.tile,
                    position = { x = x, y = y },
                })
            end
        end
    end

    local factory_surface = game.get_surface(factory_surface_name)
    if factory_surface == nil then
        return game.print("Error initializing factory: factory surface is nil.")
    end
    factory_surface.set_tiles(tiles)


    -- Store factory data
    storage.factory[surface_name] = {
        name = factory_entity.name,
        position = factory_entity.position,
        surface_name = factory_surface_name,
        placed_on_surface_name = factory_entity.surface.name,
    }


    -- Create input combinator
    factory_input_combinator_entity = factory_surface.create_entity {
        name = "factory-input-combinator",
        position = storage.factory_data.combinator_position,
        force = "player",
    }
    factory_input_combinator_entity.destructible = false
    storage.combinator[surface_name] = factory_input_combinator_entity
end

local function teleport_player(index, surface_name)
    local player = game.get_player(index)
    local factory_surface_name = surface_name .. "-factory-floor"
    local factory_surface = game.get_surface(factory_surface_name)
    if factory_surface == nil then
        return game.print("Error teleporting player: factory surface is nil.")
    end

    if player == nil or player.character == nil then
        return game.print("Error teleporting player.")
    end

    player.teleport(
        storage.factory_data.player_spawn_position,
        factory_surface
    )
end

local function on_init()
    storage.factory_type = settings.global["liteception-factory-type"].value
    storage.factory_data = all_factory_data.factories[storage.factory_type]
    storage.factory = {}
    storage.combinator = {}

    if remote.interfaces["freeplay"] then
        remote.call("freeplay", "set_skip_intro", true)
        remote.call("freeplay", "set_disable_crashsite", true)
    end

    -- Research factory technologies
    local starting_technologies = {
        "factory-connection-type-fluid",
        "factory-interior-upgrade-lights",
        "factory-recursion-t1",
        "factory-recursion-t2",
    }

    local factory_tiers = {
        "factory-architecture-t1",
        "factory-architecture-t2",
        "factory-architecture-t3",
    }
    local setting_tiers = {
        ["none"] = 0,
        ["factory-1"] = 1,
        ["factory-2"] = 2,
        ["factory-3"] = 3,
    }
    local to_research = setting_tiers[settings.global["liteception-factory-research"].value]
    for i = 1, to_research do
        table.insert(starting_technologies, factory_tiers[i])
    end

    for _, force in pairs(game.forces) do
        for _, technology in ipairs(starting_technologies) do
            force.technologies[technology].researched = true
        end
    end


    for _, planet_name in ipairs(all_factory_data.planet_names) do
        game.planets[planet_name].create_surface()
        initialize_surface_factory(planet_name)
    end
end

--- @param event EventData.on_player_created
local function on_player_created(event)
    teleport_player(event.player_index, "nauvis")
end

--- @param event EventData.on_cutscene_cancelled
local function on_cutscene_cancelled(event)
    teleport_player(event.player_index, "nauvis")
end


factory.lib = {
    on_init = on_init,
    on_load = on_load,
    events = {
        [defines.events.on_player_created] = on_player_created,
        [defines.events.on_cutscene_cancelled] = on_cutscene_cancelled,
    },
}

return factory
