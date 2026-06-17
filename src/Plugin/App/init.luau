local StudioPluginContext = require(script.Components.StudioComponents.StudioPluginContext)
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
	local isActive, setIsActive = React.useState(false)

	return e(StudioPluginContext.Provider, { value = props.plugin }, {
		Theme = e(Theme.Provider, nil, {
			StudioToolbar = e(StudioToolbar, {
				name = Constants.PLUGIN_NAME,
			}, {
				StudioToolbarButton = e(StudioToolbarButton, {
					name = Constants.PLUGIN_NAME,
					tooltip = Constants.TOOLBAR_TOOLTIP,
					icon = Icons.RoMazePluginIcon.VersionTwo,
					active = isActive,
					onClick = function()
						setIsActive(function(previousActivity)
							return not previousActivity
						end)
					end,
				}),
			}),
		}),
	})

end

return App
