local Sidebar = require(script.Components.Navigation.Sidebar)
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
	Home = "Home",
	Structure = "Structure",
	Appearance = "Appearance",
	Build = "Build",
	Settings = "Settings",
})

local function App(props: AppProps)
	local guiEnabled, setGuiEnabled = React.useState(false)
	local appStatus, setAppStatus = React.useState(AppStatus.Home)

	local function createPage(_appStatus, extraProps)
		local mergedProps = Sift.Dictionary.merge(extraProps, {
			component = StatusPages[_appStatus],
			active = appStatus == _appStatus,
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

				SideBar = e(Sidebar, {
					activeStatus = appStatus,
					onSelect = setAppStatus,
				}),

				Pages = e("Frame", {
					Position = UDim2.new(0, Constants.SIDEBAR_WIDTH, 0.5, 0),
					Size = UDim2.new(1, -Constants.SIDEBAR_WIDTH, 1, 0),
					BackgroundTransparency = 1,
					AnchorPoint = Vector2.new(0, 0.5),
					BorderSizePixel = 0,
					ClipsDescendants = true,
				}, {
					HomePage = createPage(AppStatus.Home),
					StructurePage = createPage(AppStatus.Structure),
				}),
			}),
		}),
	})
end

return App
