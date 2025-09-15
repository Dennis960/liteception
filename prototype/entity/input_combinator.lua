local input_combinator = table.deepcopy(data.raw["constant-combinator"]["constant-combinator"])
input_combinator.name = "factory-input-combinator"
input_combinator.minable = nil

data:extend{input_combinator}
