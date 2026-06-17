local Constants = require(script.Parent.Parent.Parent.Parent.Data.Constants)
local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local ReactRoblox = require(script.Parent.Parent.Parent.Parent.Parent.Packages.ReactRoblox)

local StudioPluginContext = require(script.Parent.StudioPluginContext)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

export type StudioPluginGuiProps = {
	initDockState: Enum.InitialDockState?,
	active: boolean?,
	overridePreviousState: boolean?,
	zIndexBehavior: Enum.ZIndexBehavior?,
	floatingSize: Vector2?,
	minimumSize: Vector2?,
	onInitialState: ((initialState: boolean) -> ())?,
	onClose: (() -> ())?,
	children: React.ReactNode,
}

local DefaultProps = {
	initDockState = Enum.InitialDockState.Right,
	active = false,
	overridePreviousState = false,
	zIndexBehavior = Enum.ZIndexBehavior.Sibling,
	floatingSize = Constants.WIDGET_DEFAULT_SIZE,
	minimumSize = Constants.WIDGET_MIN_SIZE,
}

local function StudioPluginGui(props: StudioPluginGuiProps)
	local studioPlugin: Plugin = React.useContext(StudioPluginContext)
	local theme = Theme.useTheme()
	local pluginGui, setPluginGui = React.useState(nil)
	local isFirstActiveSync = React.useRef(true)

	React.useEffect(function()
		if not studioPlugin then return end

		local floatingSize = props.floatingSize or DefaultProps.floatingSize
		local minimumSize = props.minimumSize or DefaultProps.minimumSize

		local dockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(
			props.initDockState or DefaultProps.initDockState,
			if props.active == nil then DefaultProps.active else props.active,
			if props.overridePreviousState == nil then DefaultProps.overridePreviousState else props.overridePreviousState,
			floatingSize.X,
			floatingSize.Y,
			minimumSize.X,
			minimumSize.Y
		)

		local newPluginGui = studioPlugin:CreateDockWidgetPluginGuiAsync(Constants.WIDGET_ID, dockWidgetPluginGuiInfo)
		newPluginGui.Name = Constants.WIDGET_ID
		newPluginGui.Title = Constants.WIDGET_TITLE
		newPluginGui.ZIndexBehavior = props.zIndexBehavior or DefaultProps.zIndexBehavior

		if props.onInitialState then
			props.onInitialState(newPluginGui.Enabled)
		end

		newPluginGui:BindToClose(function()
			if props.onClose then
				props.onClose()
			else
				newPluginGui.Enabled = false
			end
		end)

		setPluginGui(newPluginGui)

		return function()
			newPluginGui:Destroy()
			setPluginGui(nil)
		end
	end, { studioPlugin })

	React.useEffect(function()
		if not pluginGui then return end

		if isFirstActiveSync.current then
			isFirstActiveSync.current = false
			return
		end

		local active = props.active or false

		pluginGui.Enabled = active
		pluginGui.Enabled = not active
		pluginGui.Enabled = active
	end, { pluginGui, props.active })

	if not pluginGui then
		return nil
	end

	return ReactRoblox.createPortal(
		e("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = theme.Background,
			BorderSizePixel = 0,
			ZIndex = 0,
		}, props.children),
		pluginGui
	)
end

return StudioPluginGui
