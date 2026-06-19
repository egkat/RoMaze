export type Wall = "North" | "South" | "East" | "West"

export type Cell = {
	row: number,
	column: number,
	walls: { [Wall]: boolean },
	visited: boolean,
}

export type GridConfigs = {
	width: number,
	height: number,
}

export type NeighborEntry = {
	neighborCell: Cell,
	direction: Wall,
}

return {}