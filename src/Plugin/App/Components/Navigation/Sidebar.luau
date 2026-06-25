local Icons = require(script.Parent.Parent.Parent.Parent.Assets.Icons)
local Constants = require(script.Parent.Parent.Parent.Parent.Data.Constants)
local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local Theme = require(script.Parent.Parent.Parent.Theme)
local SidebarButton = require(script.Parent.SidebarButton)

local e = React.createElement

export type SidebarProps = {
	activeStatus: string,
	onSelect: (string) -> (),
}

local SIDEBAR_BUTTON_CONFIGS = {
	{ id = "Home", label = "Home", color = Constants.PAGE_COLORS.HOME, icon = Icons.RoMazePluginIcon.VersionOne },
	{ id = "Structure", label = "Structure", color = Constants.PAGE_COLORS.STRUCTURE, icon = Icons.SidebarIcons.Structure },
	{ id = "Appearance", label = "Appearance",  color = Constants.PAGE_COLORS.APPEARANCE, icon = Icons.SidebarIcons.Appearance},
	{ id = "Build", label = "Build",  color = Constants.PAGE_COLORS.BUILD, icon = Icons.SidebarIcons.Build},
	{ id = "Settings", label = "Settings", color = Constants.PAGE_COLORS.SETTINGS, icon = Icons.SidebarIcons.Settings },
}
local function Sidebar(props: SidebarProps)
	local theme = Theme.useTheme()

	local children = {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
		}),
	}

	for index, item in SIDEBAR_BUTTON_CONFIGS do
		children[item.id] = e(SidebarButton, {
			label = item.label,
			monogram = item.monogram,
			active = props.activeStatus == item.id,
			layoutOrder = index,
            color = item.color,
            icon = item.icon,
			onClick = function()
				props.onSelect(item.id)
			end,
		})
	end

	return e("Frame", {
		Size = UDim2.new(0, Constants.SIDEBAR_WIDTH, 1, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.fromScale(0, 0.5),
		BackgroundColor3 = theme.Background,
		BorderSizePixel = 0,
		ZIndex = 1,
	}, {
		Divider = e("Frame", {
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.fromScale(1, 0),
			Size = UDim2.new(0, 1, 1, 0),
			BackgroundColor3 = theme.Border,
			BorderSizePixel = 0,
			ZIndex = 2,
		}),
		ButtonsFrame = e("Frame", {
			Size = UDim2.new(1, -2, 1, -2),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, children),
	})
end

return Sidebar
