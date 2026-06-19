local Grid = require("../../src/Plugin/Generators/Grid")

local CONFIGS = {
	width = 10,
	height = 10,
}

local grid = Grid.buildGrid(CONFIGS)

-- Check Grid Size
assert(#grid == 100, `[square-grid-test]: Expected 100 cells`)

-- Check Grid Cells
local topLeft = Grid.getCell(grid, CONFIGS, 1, 1)
local topRight = Grid.getCell(grid, CONFIGS, 1, 10)
local bottomLeft = Grid.getCell(grid, CONFIGS, 10, 1)
local bottomRight = Grid.getCell(grid, CONFIGS, 10, 10)
local randomCell = Grid.getCell(grid, CONFIGS, 5, 8)

assert(topLeft and topLeft.row == 1 and topLeft.column == 1, `[square-grid-test]: top-left corner wrong`)
assert(topRight and topRight.row == 1 and topRight.column == 10, `[square-grid-test]: top-right corner wrong`)
assert(bottomLeft and bottomLeft.row == 10 and bottomLeft.column == 1, `[square-grid-test]: bottom-left corner wrong`)
assert(bottomRight and bottomRight.row == 10 and bottomRight.column == 10, `[square-grid-test]: bottom-right corner wrong`)
assert(randomCell and randomCell.row == 5 and randomCell.column == 8, `[square-grid-test]: random-cell wrong`)

-- Check Cell Neighbors
local topLeftNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, topLeft)
local topRightNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, topRight)
local bottomLeftNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, bottomLeft)
local bottomRightNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, bottomRight)
local randomCellNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, randomCell)

assert(#topLeftNeighbors == 2, `[square-grid-test]: top-left should have exactly 2 neighbors`)
assert(#topRightNeighbors == 2, `[square-grid-test]: top-right should have exactly 2 neighbors`)
assert(#bottomLeftNeighbors == 2, `[square-grid-test]: bottom-left should have exactly 2 neighbors`)
assert(#bottomRightNeighbors == 2, `[square-grid-test]: bottom-right should have exactly 2 neighbors`)
assert(#randomCellNeighbors == 4, `[square-grid-test]: interior cell should have exactly 4 neighbors`)

print("[square-grid-test]: All Square Grid Tests Pass!")
