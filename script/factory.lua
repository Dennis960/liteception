--[[

    Create the main factory and set it up properly, including researching necessary technologies.
    Move the player into the factory on game start or respawn.

]]

local factory_input_data = require("static.factory_input_data")

local factory = {}

factory.factory_surface_name = "nauvis-factory-floor"

local function initialize()
    local player = game.get_player(1)
    local outside_surface = player.surface


    -- Create factory
    local factory_entity = outside_surface.create_entity{
        name = "factory-3",
        position = factory_input_data.factory_position,
        force = "player",
        raise_built = true,
    }


    -- Block factory entrance
    local tiles = {}

    local walls = {
        name = "factory-wall-3",
        left = -2,
        right = 1,
        y = 30,
    }
    local out_of_maps = {
        name = "out-of-map",
        left = -3,
        top = 31,
        right = 2,
        bottom = 32,
    }

    for x = walls.left, walls.right do
        table.insert(tiles, {
            name = walls.name,
            position = {
                x = x,
                y = walls.y
            }
        })
    end

    for y = out_of_maps.top, out_of_maps.bottom do
        for x = out_of_maps.left, out_of_maps.right do
            table.insert(tiles, {
                name = out_of_maps.name,
                position = {
                    x = x,
                    y = y
                }
            })
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
        position = { x = 2, y = 31 },
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
        {
            x = 0,
            y = 30,
        },
        factory.factory_surface_name
    )
end

local function on_init()
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
    events = {
        [defines.events.on_player_created] = on_player_created,
        [defines.events.on_player_respawned] = on_player_respawned,
        [defines.events.on_cutscene_cancelled] = on_cutscene_cancelled,
    },
}

return factory
