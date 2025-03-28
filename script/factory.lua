--[[

    Create the main factory and set it up properly, including researching necessary technologies.
    Move the player into the factory on game start or respawn.

]]

local all_factory_data = require("static.all_factory_data")

local factory = {}

factory.factory_surface_name = "nauvis-factory-floor"

local function initialize()
    local player = game.get_player(1)
    local outside_surface = player.surface


    -- Create factory
    local factory_entity = outside_surface.create_entity{
        name = storage.factory_data.entity_name,
        position = storage.factory_data.entity_position,
        force = "player",
        raise_built = true,
    }


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

    local factory_surface = game.get_surface(factory.factory_surface_name)
    factory_surface.set_tiles(tiles)


    -- Store factory data
    storage.factory = {
        name = factory_entity.name,
        position = factory_entity.position,
        surface_name = factory.factory_surface_name,
        placed_on_surface_name = factory_entity.surface.name,
    }


    -- Create input combinator
    storage.combinator = factory_surface.create_entity{
        name = "factory-input-combinator",
        position = storage.factory_data.combinator_position,
        force = "player",
    }


    -- Research factory technologies
    local starting_technologies = {
        "factory-architecture-t1",
        "factory-architecture-t2",
        "factory-architecture-t3",
        "factory-connection-type-fluid",
        "factory-interior-upgrade-lights",
        "factory-recursion-t1",
        "factory-recursion-t2",
    }

    for _, force in pairs(game.forces) do
        for _, technology in ipairs(starting_technologies) do
            force.technologies[technology].researched = true
        end
    end
end

local function teleport_player(index)
    local player = game.get_player(index)

    if player == nil or player.character == nil then
        return game.print("Error teleporting player.")
    end

    player.teleport(
        storage.factory_data.player_spawn_position,
        factory.factory_surface_name
    )
end

local function on_init()
    storage.factory_type = settings.global["liteception-factory-type"].value
    storage.factory_data = all_factory_data[storage.factory_type]

    if remote.interfaces["freeplay"] then
        remote.call("freeplay", "set_skip_intro", true)
        remote.call("freeplay", "set_disable_crashsite", true)
    end
end

local function on_player_created(event)
    if event.player_index ~= 1 then
        teleport_player(event.player_index)
        return
    end

    initialize()
    teleport_player(event.player_index)
end


local function on_player_respawned(event)
    teleport_player(event.player_index)
end

local function on_cutscene_cancelled(event)
    teleport_player(event.player_index)
end

factory.lib = {
    on_init = on_init,
    on_load = on_load,
    events = {
        [defines.events.on_player_created] = on_player_created,
        [defines.events.on_player_respawned] = on_player_respawned,
        [defines.events.on_cutscene_cancelled] = on_cutscene_cancelled,
    },
}

return factory
