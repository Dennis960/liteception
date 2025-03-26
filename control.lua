local factory = require("script.factory")
local inputs = require("script.inputs")
local gui = require("script.gui")

local event_handler = require("event_handler")
event_handler.add_libraries{
    factory.lib,
    inputs.lib,
    gui.lib,
}
