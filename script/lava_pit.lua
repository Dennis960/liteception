--[[

    Lava Pit - Automatically deletes all items inside the "liteception-lava-pit" container

]]

local lava_pit = {}

--- Deletes all items in the liteception-lava-pit container when items are inserted
--- @param event EventData.on_tick
local function on_tick(event)
    if event.tick % 30 == 0 then -- every half second
        for _, surface in pairs(game.surfaces) do
            for _, chest in pairs(surface.find_entities_filtered{name = "liteception-lava-pit"}) do
                if chest.valid then
                    local inventory = chest.get_inventory(defines.inventory.chest)
                    if inventory and not inventory.is_empty() then
                        inventory.clear()
                    end
                end
            end
        end
    end
end


--- @param event EventData.on_gui_opened
local function on_gui_opened(event)
    if event.entity and event.entity.name == "liteception-lava-pit" then
        game.players[event.player_index].opened = nil
    end
end

lava_pit.lib = {
    events = {
        [defines.events.on_gui_opened] = on_gui_opened,
        [defines.events.on_tick] = on_tick,
    },
}

return lava_pit
