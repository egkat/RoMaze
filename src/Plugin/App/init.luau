local StudioPluginContext = require(script.Components.StudioComponents.StudioPluginContext)
local StudioPluginGui = require(script.Components.StudioComponents.StudioPluginGui)
local StudioToolbar = require(script.Components.StudioComponents.StudioToolbar)
local StudioToolbarButton = require(script.Components.StudioComponents.StudioToolbarButton)
local Page = require(script.Page)
local Icons = require(script.Parent.Assets.Icons)
local Constants = require(script.Parent.Data.Constants)
local React = require(script.Parent.Parent.Packages.React)
local Sift = require(script.Parent.Parent.Packages.Sift)
local Strict = require(script.Parent.Utils.Strict)
local Theme = require(script.Theme)
local StatusPages = require(script.StatusPages)

local e = React.createElement

export type AppProps = {
	plugin: Plugin,
}

local AppStatus = Strict("AppStatus", {
	Generation = "Generation",
	Appearance = "Appearance",
	Settings = "Settings",
})

local function App(props: AppProps)
	local guiEnabled, setGuiEnabled = React.useState(false)
	local appStatus, setAppStatus = React.useState("Generation")

	local function createPage(_appStatus, extraProps)
		
		local mergedProps = Sift.Dictionary.merge(extraProps, {
			component = StatusPages[_appStatus],
			active = appStatus == _appStatus
		})

		return e(Page, mergedProps)

	end

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
				floatingSize = Vector2.new(320, 210),
				minimumSize = Vector2.new(300, 210),
				onInitialState = function(initialState)
					setGuiEnabled(initialState)
				end,
				onClose = function()
					setGuiEnabled(false)
				end,
			}, {
				GenerationPage = createPage(AppStatus.Generation)
			}),
		}),
	})
end

return App
