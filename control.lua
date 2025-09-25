local factory = require("script.factory")
local inputs = require("script.inputs")
local gui = require("script.gui")
local spawner_placer = require("script.spawner_placer")
local lava_pit = require("script.lava_pit")

local event_handler = require("event_handler")
event_handler.add_libraries {
    factory.lib,
    inputs.lib,
    lava_pit.lib,
    gui.lib,
    spawner_placer.lib,
}
