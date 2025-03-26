local input_combinator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
input_combinator.name = "factory-input-combinator"
input_combinator.item_slot_count = 8
input_combinator.minable = nil

data:extend{input_combinator}
