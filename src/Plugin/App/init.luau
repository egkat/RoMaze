local StudioPluginContext = require(script.Components.StudioComponents.StudioPluginContext)
local StudioPluginGui = require(script.Components.StudioComponents.StudioPluginGui)
local StudioToolbar = require(script.Components.StudioComponents.StudioToolbar)
local StudioToolbarButton = require(script.Components.StudioComponents.StudioToolbarButton)
local Theme = require(script.Components.Theme)
local Icons = require(script.Parent.Assets.Icons)
local Constants = require(script.Parent.Data.Constants)
local React = require(script.Parent.Parent.Packages.React)

local e = React.createElement

export type AppProps = {
	plugin: Plugin,
}

local function App(props: AppProps)
	local guiEnabled, setGuiEnabled = React.useState(false)

	return e(StudioPluginContext.Provider, { value = props.plugin }, {
		Theme = e(Theme.Provider, nil, {
			StudioToolbar = e(StudioToolbar, {
				name = Constants.PLUGIN_NAME,
			}, {
				StudioToolbarButton = e(StudioToolbarButton, {
					name = Constants.PLUGIN_NAME,
					tooltip = Constants.TOOLBAR_TOOLTIP,
					icon = Icons.RoMazePluginIcon.VersionTwo,
					active = guiEnabled,
					onClick = function()
						setGuiEnabled(function(previousState)
							return not previousState
						end)
					end,
				}),
			}),
			StudioPluginGui = e(StudioPluginGui, {
				active = guiEnabled,
				onInitialState = function(initialState)
					setGuiEnabled(initialState)
				end,
				onClose = function()
					setGuiEnabled(false)
				end,
			}),
		}),
	})
end

return App
