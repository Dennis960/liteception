--[[

    Returns only the factory data relevant to the current savefile.

]]

local factory_data = {
    ["factory-1"] = require("static.factory_data.factory_1"),
    ["factory-3"] = require("static.factory_data.factory_3"),
}

if storage.factory_type == nil then
    storage.factory_type = settings.global["liteception-factory-type"].value
end

return factory_data[storage.factory_type]
