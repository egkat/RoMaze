local Builder = require(script.Parent.Parent.Parent.Parent.Builder)
local BuilderTypes = require(script.Parent.Parent.Parent.Parent.Builder.BuilderTypes)
local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local StudioToolbarContext = require(script.Parent.StudioToolbarContext)

type StudioToolbarButtonProps = {
	name: string,
	tooltip: string?,
	icon: string?,
	active: boolean?,
	onClick: (() -> ())?,
}

local RandomizedDepthFirstSearch = require(script.Parent.Parent.Parent.Parent.Generators.Algorithms.RandomizedDepthFirstSearch)

local gridConfigs = { width = 10, height = 10 }
local builderConfigs = {
	cellSize = 6,
	wallHeight = 8,
	wallThickness = 0.5,
	floorThickness = 1,
	parent = workspace,
}

local state = RandomizedDepthFirstSearch.setup(gridConfigs, os.time())

while not state.generationCompleted do
	RandomizedDepthFirstSearch.step(state)
end



local function StudioToolbarButton(props: StudioToolbarButtonProps)
	local toolbar = React.useContext(StudioToolbarContext)
	local button, setButton = React.useState(nil)

	React.useEffect(function()
		if not toolbar then return end

		local newButton = toolbar:CreateButton(
			props.name,
			props.tooltip or "",
			props.icon or ""
		)
		setButton(newButton)

		local conn = newButton.Click:Connect(function()
			if props.onClick then
				props.onClick()
			end

			Builder.build(state.grid, gridConfigs, builderConfigs)

		end)

		return function()
			conn:Disconnect()
			newButton:Destroy()
			setButton(nil)
		end
	end, { toolbar })

	React.useEffect(function()
		if button then
			button:SetActive(props.active or false)
		end
	end, { button, props.active })

	return nil
end

return StudioToolbarButton