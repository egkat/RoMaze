local StudioToolbar = require(script.Components.StudioComponents.StudioToolbar)
local StudioToolbarButton = require(script.Components.StudioComponents.StudioToolbarButton)
local Icons = require(script.Parent.Assets.Icons)
local React = require(script.Parent.Parent.Packages.React)

local e = React.createElement

export type AppProps = {
	plugin: Plugin,
}

local function App(props: AppProps)
	return e(StudioToolbar, {
		plugin = props.plugin,
		name = "RoMaze",
	}, {
		Button = e(StudioToolbarButton, {
			name = "RoMaze",
			tooltip = "Open RoMaze",
            icon = Icons.RoMazePluginIconVersionTwo,
			onClick = function()
                print("Activated")
			end,
		}),
	})
end

return App
