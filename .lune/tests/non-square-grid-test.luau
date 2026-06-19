local Grid = require("@plugin/Generators/Grid")

local CONFIGS = {
	width = 5,
	height = 10,
}

local grid = Grid.buildGrid(CONFIGS)

-- Check Grid Size
assert(#grid == 50, `[non-square-grid-test]: Expected 50 cells`)

-- Check Grid Cells
local topLeft = Grid.getCell(grid, CONFIGS, 1, 1)
local topRight = Grid.getCell(grid, CONFIGS, 1, 5)
local bottomLeft = Grid.getCell(grid, CONFIGS, 10, 1)
local bottomRight = Grid.getCell(grid, CONFIGS, 10, 5)
local randomCell = Grid.getCell(grid, CONFIGS, 5, 3)

assert(topLeft and topLeft.row == 1 and topLeft.column == 1, `[non-square-grid-test]: top-left corner wrong`)
assert(topRight and topRight.row == 1 and topRight.column == 5, `[non-square-grid-test]: top-right corner wrong`)
assert(bottomLeft and bottomLeft.row == 10 and bottomLeft.column == 1, `[non-square-grid-test]: bottom-left corner wrong`)
assert(bottomRight and bottomRight.row == 10 and bottomRight.column == 5, `[non-square-grid-test]: bottom-right corner wrong`)
assert(randomCell and randomCell.row == 5 and randomCell.column == 3, `[non-square-grid-test]: random-cell wrong`)

-- Check Cell Neighbors
local topLeftNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, topLeft)
local topRightNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, topRight)
local bottomLeftNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, bottomLeft)
local bottomRightNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, bottomRight)
local randomCellNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, randomCell)

assert(#topLeftNeighbors == 2, `[non-square-grid-test]: top-left should have exactly 2 neighbors`)
assert(#topRightNeighbors == 2, `[non-square-grid-test]: top-right should have exactly 2 neighbors`)
assert(#bottomLeftNeighbors == 2, `[non-square-grid-test]: bottom-left should have exactly 2 neighbors`)
assert(#bottomRightNeighbors == 2, `[non-square-grid-test]: bottom-right should have exactly 2 neighbors`)
assert(#randomCellNeighbors == 4, `[non-square-grid-test]: interior cell should have exactly 4 neighbors`)

print("[non-square-grid-test]: All Non-Square Grid Tests Pass!")
