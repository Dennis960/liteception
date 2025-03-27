--[[

    Manages the gui used to configure the factory resource inputs.

]]

local gui = {}

local factory_data = require("static.factory_data.factory_data")
local inputs = require("script.inputs")

local function create_buttons(player)
    local selector_filter = {}
    for _, item in pairs(storage.available_inputs) do
        if item.name and item.amount >= 1 then
            table.insert(selector_filter, { filter = "name", name = item.name })
        end
    end
    if #selector_filter == 0 then
        -- Maybe a dirty hack
        table.insert(selector_filter, { filter = "name", name = "__liteception-nothing__" })
    end

    local function populate_flow(flow, button, direction)
        button.tags.direction = direction
        flow.clear()

        local input_ids = factory_data.gui_inputs[direction]
        local dummy_id = 0
        for _, id in ipairs(input_ids) do
            if id == 0 then
                flow.add { type = "sprite", name = "dummy-buttons-button-" .. dummy_id, sprite = "tile/lab-dark-2" }
                dummy_id = dummy_id + 1
            else
                button.tags.num = id
                local item_name = storage.selected[button.tags.direction][button.tags.num]
                button.item = item_name
                flow.add(button)
                button.item = nil
            end
        end
    end

    local button = {
        type = "choose-elem-button",
        tags = { action = "liteception-select-item" },
        flow = "vertical",
        elem_type = "item",
        elem_filters = selector_filter,
    }

    local content_frame = player.opened.content_frame
    local top_content    = content_frame["top-content"]
    local middle_content = content_frame["middle-content"]
    local bottom_content = content_frame["bottom-content"]

    populate_flow(top_content.children[1],    button, defines.direction.north)
    populate_flow(middle_content.children[1], button, defines.direction.west)
    populate_flow(middle_content.children[3], button, defines.direction.east)
    populate_flow(bottom_content.children[1], button, defines.direction.south)
end

local function create_interface(player)
    local screen = player.gui.screen
    local player_storage = storage.players[player.index]
    if screen["liteception-input-selector"] ~= nil then
        screen["liteception-input-selector"].destroy()
    else
        local main_frame = screen.add{
            type = "frame",
            caption = { "factory-input.title"},
            name = "liteception-input-selector",
        }
        main_frame.auto_center = true

        local content_frame = main_frame.add{
            type = "frame",
            name = "content_frame",
            direction = "vertical",
        }

        local top_content = content_frame.add{
            type = "flow",
            name = "top-content",
            style = "liteception-horizontal-centerflow",
        }
        local middle_content = content_frame.add{
            type = "flow",
            name = "middle-content",
            style = "liteception-horizontal-centerflow",
        }
        local bottom_content = content_frame.add{
            type = "flow",
            name = "bottom-content",
            style = "liteception-horizontal-centerflow",
        }

        local top_buttons_flow = top_content.add{
            type = "flow",
            name = "top-buttons-flow",
            direction = "horizontal",
            style = "liteception-horizontal-centerflow",
        }
        local left_buttons_flow = middle_content.add{
            type = "flow",
            name = "left-buttons-flow",
            direction = "vertical",
        }
        local preview_flow = middle_content.add{
            type = "flow",
            name = "preview-flow",
            direction = "horizontal",
        }
        local right_buttons_flow = middle_content.add{
            type = "flow",
            name = "right-buttons-flow",
            direction = "vertical",
        }
        local bottom_buttons_flow = bottom_content.add{
            type = "flow",
            name = "bottom-buttons-flow",
            direction = "horizontal",
            style = "liteception-horizontal-centerflow",
        }

        local outside_surface = game.get_surface(storage.factory.placed_on_surface_name)
        local entity = outside_surface.find_entity(storage.factory.name, storage.factory.position)
        if entity == nil then
            return
        end
        local preview = preview_flow.add{
            type = "entity-preview",
            tags = { main = "liteception-factory-preview" },
        }
        preview.style.size = { 512, 512 }
        preview.entity = entity

        top_buttons_flow.style.horizontal_align = "center"
        top_buttons_flow.style.horizontally_stretchable = true
        left_buttons_flow.style.vertical_align = "center"
        left_buttons_flow.style.vertically_stretchable = true
        right_buttons_flow.style.vertical_align = "center"
        right_buttons_flow.style.vertically_stretchable = true
        bottom_buttons_flow.style.horizontal_align = "center"
        bottom_buttons_flow.style.horizontally_stretchable = true

        player_storage.elements.main_frame = main_frame
        player.opened = main_frame

        create_buttons(player)
    end
end

local function toggle_interface(player)
    local player_storage = storage.players[player.index]
    local main_frame = player_storage.elements.main_frame

    if main_frame == nil then
        create_interface(player)
    else
        main_frame.destroy()
        player_storage.elements = {}
    end
end

local function on_gui_opened(event)
    if event.entity == nil or event.entity.name ~= "factory-input-combinator" then
        return
    end

    local player = game.get_player(event.player_index)
    toggle_interface(player)
end

local function on_gui_closed(event)
    if not event.element or event.element.name ~= "liteception-input-selector" then
        return
    end

    local player = game.get_player(event.player_index)
    toggle_interface(player)
end

local function on_player_created(event)
    storage.players[event.player_index] = {
        controls_active = false,
        selected_item = nil,
        elements = {},
    }
end

local function on_gui_elem_changed(event)
    if event.element.tags == nil or event.element.tags.action ~= "liteception-select-item" then
        return
    end

    local element = event.element
    inputs.set_input(element.tags.direction, element.tags.num, element.elem_value)
    create_buttons(game.get_player(event.player_index))
end

gui.lib = {
    events = {
        [defines.events.on_gui_opened] = on_gui_opened,
        [defines.events.on_gui_closed] = on_gui_closed,
        [defines.events.on_player_created] = on_player_created,
        [defines.events.on_gui_elem_changed] = on_gui_elem_changed,
    },
}

return gui
