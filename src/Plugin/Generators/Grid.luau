--!strict
local GridTypes = require(script.Parent.GridTypes)

type Wall = GridTypes.Wall
type Cell = GridTypes.Cell
type GridConfigs = GridTypes.GridConfigs
type NeighborEntry = GridTypes.NeighborEntry

local Grid = {}

local OPPOSITE_MAPPING: { [Wall]: Wall } = {
	North = "South",
	South = "North",
	East = "West",
	West = "East",
}

local DIRECTION_VECTORS: { { direction: Wall, deltaX: number, deltaY: number } } = {
	{ direction = "North", deltaX = 0, deltaY = -1 },
	{ direction = "South", deltaX = 0, deltaY = 1 },
	{ direction = "East", deltaX = 1, deltaY = 0 },
	{ direction = "West", deltaX = -1, deltaY = 0 },
}

Grid.OPPOSITE_MAPPING = OPPOSITE_MAPPING
Grid.DIRECTION_VECTORS = DIRECTION_VECTORS

function Grid.buildCell(row: number, column: number): Cell
	return {
		row = row,
		column = column,
		walls = { North = true, South = true, East = true, West = true },
		visited = false,
	}
end

function Grid.buildGrid(configs: GridConfigs): { Cell }
	assert(typeof(configs.width) == "number", `Grid: Width must be a number`)
	assert(typeof(configs.height) == "number", `Grid: Height must be a number`)
	assert(configs.width % 1 == 0, `Grid: Width must be a positive integer [1, 2, 3, ...]`)
	assert(configs.height % 1 == 0, `Grid: Height must be a positive integer [1, 2, 3, ...]`)

	local grid = {}

	for row = 1, configs.height do
		for column = 1, configs.width do
			table.insert(grid, Grid.buildCell(row, column))
		end
	end

	return grid
end

function Grid.getCell(grid: { Cell }, configs: GridConfigs, row: number, column: number): Cell?
	assert(typeof(grid) == "table", `Grid: grid must be a table`)
	assert(typeof(configs.width) == "number", `Grid: Width must be a number`)
	assert(typeof(configs.height) == "number", `Grid: Height must be a number`)
	assert(typeof(row) == "number", `Grid: row must be a number`)
	assert(typeof(column) == "number", `Grid: column must be a number`)
	assert(column >= 1 and column <= configs.width, `Grid: Column accessed must be between 1 and maze width`)
	assert(row >= 1 and row <= configs.height, `Grid: Row accessed must be between 1 and maze height`)

	local cellIndex = (row - 1) * configs.width + column

	return grid[cellIndex]
end

function Grid.getAllCellNeighbors(grid: { Cell }, configs: GridConfigs, cell: Cell): { NeighborEntry }
	assert(typeof(grid) == "table", `Grid: grid must be a table`)
	assert(typeof(cell) == "table", `Grid: cell must be a table`)
	assert(typeof(configs.width) == "number", `Grid: Width must be a number`)
	assert(typeof(configs.height) == "number", `Grid: Height must be a number`)

	local neighborCells = {}

	for _, directionVector in Grid.DIRECTION_VECTORS do
		local neighborCell =
			Grid.getCell(grid, configs, cell.row + directionVector.deltaY, cell.column + directionVector.deltaX)

		if not neighborCell then
			continue
		end

		table.insert(neighborCells, {
			neighborCell = neighborCell,
			direction = directionVector.direction,
		})
	end

	return neighborCells
end

function Grid.getUnvisitedCellNeighbors(grid: { Cell }, configs: GridConfigs, cell: Cell): { NeighborEntry }
	local unvisitedCellNeighbors = {}

	for _, neighborEntry in Grid.getAllCellNeighbors(grid, configs, cell) do
		if neighborEntry.neighborCell.visited then
			continue
		end

		table.insert(unvisitedCellNeighbors, neighborEntry)
	end

	return unvisitedCellNeighbors
end

function Grid.removeWall(cellOne: Cell, cellTwo: Cell, direction: Wall)
	assert(typeof(cellOne) == "table", `Grid: cell one must be a table`)
	assert(typeof(cellTwo) == "table", `Grid: cell two must be a table`)
    assert(typeof(direction) == "string", `Grid: direction must be a string`)

    local oppositeDirection: Wall = OPPOSITE_MAPPING[direction]

    cellOne.walls[direction] = false
    cellTwo.walls[oppositeDirection] = false

end

function Grid.setVisited(cell: Cell, state: boolean)
	
	cell.visited = state

end

function Grid.markVisited(cell: Cell)
	
	Grid.setVisited(cell, true)

end

return Grid
