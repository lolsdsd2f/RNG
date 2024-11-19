local RNG = require(script.Parent)

local RAIRTY_PERCENTAGES = {
	{ rairty = "Common", percent = 60.3 },
	{ rairty = "Rare", percent = 25.5 },
	{ rairty = "Legendary", percent = 14.2 },
}

local rng = RNG.new(RAIRTY_PERCENTAGES)

for i=1, 100 do
	print(rng:Roll())
end