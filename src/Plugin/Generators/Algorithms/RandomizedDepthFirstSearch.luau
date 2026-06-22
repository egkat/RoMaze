--!strict
local Grid = require(script.Parent.Parent.Grid)
local GridTypes = require(script.Parent.Parent.GridTypes)
local Stack = require(script.Parent.Parent.Parent.Classes.Stack)

type Cell = GridTypes.Cell
type GridConfigs = GridTypes.GridConfigs
type NeighborEntry = GridTypes.NeighborEntry

export type RandomizedDepthFirstSearchState = {
	grid: { Cell },
	configs: GridConfigs,
	random: Random,
	currentCell: Cell,
	cellStack: Stack.Stack<Cell>,
	generationCompleted: boolean,
}

local RandomizedDepthFirstSearch = {}

function RandomizedDepthFirstSearch.setup(configs: GridConfigs, seed: number): RandomizedDepthFirstSearchState
	assert(typeof(configs) == "table", `[RandomizedDepthFirstSearch]: configs must be a table`)
	assert(typeof(seed) == "number", `[RandomizedDepthFirstSearch]: seed must be a number`)

	local random = Random.new(seed)
	local grid = Grid.buildGrid(configs)

	local startingCellIndex = random:NextInteger(1, configs.height * configs.width)
	local startingCell = grid[startingCellIndex]

	startingCell.visited = true

	local stack: Stack.Stack<Cell> = Stack.new()
	stack:push(startingCell)

	return {
		grid = grid,
		configs = configs,
		random = random,
		currentCell = startingCell,
		cellStack = stack,
		generationCompleted = false,
	}
end

function RandomizedDepthFirstSearch.step(state: RandomizedDepthFirstSearchState)
	assert(typeof(state) == "table", `[RandomizedDepthFirstSearch]: state must be a table`)

	if state.generationCompleted then
		return
	end

	if state.cellStack:isEmpty() then
		state.generationCompleted = true
		return
	end

	local topCell = state.cellStack:peek()

	if not topCell then
		state.generationCompleted = true
		return
	end

	local unvisitedNeighbors = Grid.getUnvisitedCellNeighbors(state.grid, state.configs, topCell)

	if #unvisitedNeighbors == 0 then

		state.cellStack:pop()
		state.currentCell = state.cellStack:peek() or topCell

		return

	end

	local selectedUnvisitedNeighborEntryIndex = state.random:NextInteger(1, #unvisitedNeighbors)
	local selectedUnvisitedNeighborEntry: NeighborEntry = unvisitedNeighbors[selectedUnvisitedNeighborEntryIndex]

	Grid.removeWall(topCell, selectedUnvisitedNeighborEntry.neighborCell, selectedUnvisitedNeighborEntry.direction)
	Grid.markVisited(selectedUnvisitedNeighborEntry.neighborCell)

	state.cellStack:push(selectedUnvisitedNeighborEntry.neighborCell)
	state.currentCell = selectedUnvisitedNeighborEntry.neighborCell

end

return RandomizedDepthFirstSearch
