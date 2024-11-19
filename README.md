# RNG Module

The `RNG` module provides a utility to generate weighted random selections based on specified rarity percentages. This module is designed for use in Luau (Roblox's Lua dialect) and can be particularly useful in games or systems where probability-based outcomes are required, such as loot tables, random events, or gacha mechanics.

---
Install: [GitHub](https://github.com/lolsdsd2f/RNG)  |  [Studio Model]( [create.roblox.com/store/asset/100536020040174](https://create.roblox.com/store/asset/100536020040174))

---

## Features

* **Rarity-Based Probability**: Define multiple
* **High Precision**: Su
* **Efficient Lookups**: Uses `NumberRange` to map percentages to rarity items for fast retrieval.

---

## API Documentation

### Types

#### `RarityPercents`

A list of rarities and their associated probabilities.


``` lua
export type RarityPercents = {
    { rarity: string, percent: number }
}
```

#### `RandomItems`

A dictionary mapping `NumberRange` objects to rarity strings.


``` lua
export type RandomItems = {
    [NumberRange]: string
}
```

---

### Functions

#### `RNG.new(rarityPercents: RarityPercents): RNG`

Creates a new RNG object.

* **Parameters**:
  * `rarityPercents`: A list of rarity strings and their corresponding percentages. The total of all percentages must equal `100`.
* **Returns**:
  * A new instance of the RNG object.

---

#### `RNG:Roll(): string`

Performs a random roll and returns a rarity based on the defined percentages.

* **Returns**:
  * A string representing the selected rarity.

---

### Usage Example


``` lua
local RNG = require(path.to.RNG)

local rarities = {
    { rarity = "Common", percent = 70 },
    { rarity = "Rare", percent = 20 },
    { rarity = "Legendary", percent = 10 },
}

local rng = RNG.new(rarities)

local result = rng:Roll()
print("You got:", result)
```

---

### Internals

#### `getDecimalPlaces(num: number): number`

Calculates the number of decimal places in a given number.

#### `isNumberInRange(num: number, numRange: NumberRange): boolean`

Checks if a number is within a specified `NumberRange`.

#### `_Initialize(rarityPercents: RarityPercents)`

Initializes the RNG object by calculating the mapping of `NumberRange` to rarity strings based on percentages.

---

### Notes

* The total percentage of all rarities must sum to exactly `100`. If this condition is not met, the module will throw an assertion error.
* Internally, the module handles decimal precision dynamically, so you can use fractional percentages like `33.3` or `66.7` with confidence.

This module ensures a robust and flexible approach to probability-based randomization for your Roblox projects.
