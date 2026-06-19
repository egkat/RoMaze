local stdio = require("@lune/stdio")
local Grid = require("@plugin/Generators/Grid")


local widthInput, heightInput

repeat
	widthInput = stdio.prompt("text", "Enter a width:")
	heightInput = stdio.prompt("text", "Enter a height:")
until typeof(tonumber(widthInput)) == "number" and typeof(tonumber(heightInput)) == "number"

local width = tonumber(widthInput)
local height = tonumber(heightInput)

local CONFIGS = {
	width = width,
	height = height,
}

local grid = Grid.buildGrid(CONFIGS)

-- Check Grid Size
assert(#grid == width * height, `[nxn-grid-test]: Expected {width * height} cells`)

-- Check Grid Cells

local topLeft = Grid.getCell(grid, CONFIGS, 1, 1)
local topRight = Grid.getCell(grid, CONFIGS, 1, width)
local bottomLeft = Grid.getCell(grid, CONFIGS, height, 1)
local bottomRight = Grid.getCell(grid, CONFIGS, height, width)

local randomRow = math.random(2, height - 1)
local randomColumn = math.random(2, width - 1)

local randomCell = Grid.getCell(grid, CONFIGS, randomRow, randomColumn)

assert(topLeft and topLeft.row == 1 and topLeft.column == 1, `[nxn-grid-test]: top-left corner wrong`)
assert(topRight and topRight.row == 1 and topRight.column == width, `[nxn-grid-test]: top-right corner wrong`)
assert(bottomLeft and bottomLeft.row == height and bottomLeft.column == 1, `[nxn-grid-test]: bottom-left corner wrong`)
assert(
	bottomRight and bottomRight.row == height and bottomRight.column == width,
	`[nxn-grid-test]: bottom-right corner wrong`
)
assert(
	randomCell and randomCell.row == randomRow and randomCell.column == randomColumn,
	`[nxn-grid-test]: random-cell wrong`
)

-- Check Cell Neighbors

local topLeftNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, topLeft)
local topRightNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, topRight)
local bottomLeftNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, bottomLeft)
local bottomRightNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, bottomRight)
local randomCellNeighbors = Grid.getAllCellNeighbors(grid, CONFIGS, randomCell)

assert(#topLeftNeighbors == 2, `[nxn-grid-test]: top-left should have exactly 2 neighbors`)
assert(#topRightNeighbors == 2, `[nxn-grid-test]: top-right should have exactly 2 neighbors`)
assert(#bottomLeftNeighbors == 2, `[nxn-grid-test]: bottom-left should have exactly 2 neighbors`)
assert(#bottomRightNeighbors == 2, `[nxn-grid-test]: bottom-right should have exactly 2 neighbors`)
assert(#randomCellNeighbors == 4, `[nxn-grid-test]: interior cell should have exactly 4 neighbors`)

print("[nxn-grid-test]:: All Square Grid Tests Pass!")