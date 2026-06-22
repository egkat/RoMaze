local Grid = require(script.Parent.Generators.Grid)
local GridTypes = require(script.Parent.Generators.GridTypes)
local BuilderTypes = require(script.BuilderTypes)
local PartFactory = require(script.PartFactory)

type Cell = GridTypes.Cell
type Wall = GridTypes.Wall
type GridConfigs = GridTypes.GridConfigs
type BuilderConfigs = BuilderTypes.BuilderConfigs
type BuildHandle = BuilderTypes.BuildHandle
local Builder = {}

function Builder.calculateCellCenter(cell: Cell, config: BuilderConfigs)
	return Vector3.new((cell.column - 1) * config.cellSize, 0, (cell.row - 1) * config.cellSize)
end

function Builder.buildWall(
	cell: Cell,
	direction: Wall,
	cellCenter: Vector3,
	builderConfigs: BuilderConfigs,
	parent: Instance
)
	local correctDirectionVector = nil

	for _, directionVector in Grid.DIRECTION_VECTORS do
		if directionVector.direction == direction then
			correctDirectionVector = directionVector
			break
		end
	end

	assert(correctDirectionVector, `[Builder:] unknown direction {correctDirectionVector}`)

	local offset = Vector3.new(correctDirectionVector.deltaX, 0, correctDirectionVector.deltaY)
		* (builderConfigs.cellSize / 2)
	local position = cellCenter + offset + Vector3.new(0, builderConfigs.wallHeight / 2, 0)

	local size = nil

	if correctDirectionVector.deltaX ~= 0 then
		size = Vector3.new(builderConfigs.wallThickness, builderConfigs.wallHeight, builderConfigs.cellSize)
	elseif correctDirectionVector.deltaY ~= 0 then
		size = Vector3.new(builderConfigs.cellSize, builderConfigs.wallHeight, builderConfigs.wallThickness)
	end

	assert(size, `[Builder:] unknown wall size {size}`)

	return PartFactory.createPart(`Wall_{cell.row}_{cell.column}_{direction}`, CFrame.new(position), size, parent)
end

function Builder.buildFloor(gridConfigs: GridConfigs, builderConfigs: BuilderConfigs, parent: Instance)
	local size = Vector3.new(
		gridConfigs.width * builderConfigs.cellSize,
		builderConfigs.floorThickness,
		gridConfigs.height * builderConfigs.cellSize
	)

	local position = Vector3.new(
		(gridConfigs.width - 1) * builderConfigs.cellSize / 2,
		-builderConfigs.floorThickness / 2,
		(gridConfigs.height - 1) * builderConfigs.cellSize / 2
	)

	return PartFactory.createPart("FloorPart", CFrame.new(position), size, parent)
end

function Builder.build(grid: { Cell }, gridConfigs: GridConfigs, builderConfigs: BuilderConfigs): BuildHandle
	assert(typeof(grid) == "table", `[Builder]: grid must be a table`)
	assert(typeof(gridConfigs) == "table", `[Builder]: gridConfigs must be a table`)
	assert(typeof(builderConfigs) == "table", `[Builder]: builderConfigs must be a table`)

	local container = Instance.new("Model")
	container.Name = "Maze"
	container.Parent = builderConfigs.parent or workspace

	Builder.buildFloor(gridConfigs, builderConfigs, container)

	for _, cell in grid do
		local cellCenter = Builder.calculateCellCenter(cell, builderConfigs)

		-- Let south walls always generate over north walls
		if cell.walls.North and cell.row == 1 then
			Builder.buildWall(cell, "North", cellCenter, builderConfigs, container)
		end

		if cell.walls.South then
			Builder.buildWall(cell, "South", cellCenter, builderConfigs, container)
		end

		-- Let east walls always generate over west walls
		if cell.walls.East then
			Builder.buildWall(cell, "East", cellCenter, builderConfigs, container)
		end

		if cell.walls.West and cell.column == 1 then
			Builder.buildWall(cell, "West", cellCenter, builderConfigs, container)
		end
	end

	return {
		container = container,
	}
end

function Builder.destroyMaze() end

return Builder
