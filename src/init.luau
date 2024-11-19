-- @My6974
export type RarityPercents = {
	{ rarity: string, percent: number }
}

export type RandomItems = {
	[NumberRange]: string
}

-- Get the number of decimal places
local function getDecimalPlaces(num: number): number
	local decimalPlaces = 0
	while num % 1 ~= 0 do
		num = num * 10
		decimalPlaces = decimalPlaces + 1
	end
	return decimalPlaces
end

-- Check if the number is within the NumberRange
local function isNumberInRange(num: number, numRange: NumberRange): boolean
	return num <= numRange.Max and num >= numRange.Min
end

local RNG = {}
RNG.__index = RNG

function RNG:_Initialize(rarityPercents: RarityPercents)
	local previousPercent = 0
	local totalPercent = 0
	for _, rarityPercent in ipairs(rarityPercents) do
		do -- Find the maximum decimal places
			local decimalPlaces = getDecimalPlaces(rarityPercent.percent)
			if self._maxDecimalPlaces < decimalPlaces then
				self._maxDecimalPlaces = decimalPlaces
			end
		end

		do -- Calculate the random items
			local multiplier = 10 ^ self._maxDecimalPlaces
			local newPercent = previousPercent + (rarityPercent.percent * multiplier)
			self._randomItems[NumberRange.new(previousPercent, newPercent)] = rarityPercent.rarity
			previousPercent = newPercent
		end

		totalPercent += rarityPercent
	end
	assert(totalPercent == 100, "The total percentage must always be 100.")
end

function RNG.new(rarityPercents: RarityPercents)
	local self = setmetatable({}, RNG)

	self._randomItems = {} :: RandomItems
	self._maxDecimalPlaces = 0 :: number

	self:_Initialize(rarityPercents)
	return self
end

function RNG:Roll(): string
	local randomNumber = math.random(1, (100 * (10 ^ self._maxDecimalPlaces)))
	for numberRange: NumberRange, randomItem in pairs(self._randomItems) do
		if isNumberInRange(randomNumber, numberRange) then
			return randomItem
		end
	end
end

return RNG
