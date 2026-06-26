local useSpring = require(script.Parent.Parent.Parent.Hooks.useSpring)
local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local Theme = require(script.Parent.Parent.Parent.Theme)
local Button = require(script.Parent.Button)
local TextLabel = require(script.Parent.TextLabel)

local e = React.createElement

local ROTATION_STATES = {
	OPEN = 180,
	CLOSED = 0,
}

local TRANSPARENCY_STATES = {
	BASE = 1,
	HOVER = 0.92,
	ACTIVE = 0.85,
}

local BEVEL_STROKE = {
	Color = Color3.fromRGB(0, 0, 0),
	Thickness = 1,
}

local BEVEL_GRADIENT = {
	Rotation = 90,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(187, 187, 187)),
	}),
}

local OPTION_HEIGHT = 26
local MAXIMUM_OPTIONS_VISIBLE = 4
local BASE_SIZE = UDim2.fromOffset(160, 28)

export type DropdownProps = {
	active: string?,
	locked: boolean?,
	dropdownOptions: { string },
	placeholderOption: string?,
	layoutOrder: number?,
	Size: UDim2?,
	Position: UDim2?,
	AnchorPoint: Vector2?,
	onSelect: (selectedOption: string) -> (),
}

export type DropdownElementProps = {
	index: number,
	option: string,
	active: string?,
	theme: any,
	onSelect: (option: string) -> (),
}

local function DropdownElement(props: DropdownElementProps)
	local isActive = props.option == props.active

	local transparency, transparencySpring =
		useSpring(if isActive then TRANSPARENCY_STATES.ACTIVE else TRANSPARENCY_STATES.BASE, { frequency = 8, dampingRatio = 1 })

	React.useEffect(function()
		transparencySpring:setGoal(if isActive then TRANSPARENCY_STATES.ACTIVE else TRANSPARENCY_STATES.BASE)
	end, { isActive })

	return e("TextButton", {
		Text = props.option,
		Font = Enum.Font.BuilderSans,
		TextSize = 14,
		TextColor3 = props.theme.Foreground,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		BackgroundColor3 = props.theme.Brand,
		BackgroundTransparency = transparency,
		Size = UDim2.new(1, 0, 0, OPTION_HEIGHT),
		LayoutOrder = props.index,
		ZIndex = 10,

		[React.Event.MouseEnter] = function()
			if not isActive then
				transparencySpring:setGoal(TRANSPARENCY_STATES.HOVER)
			end
		end,

		[React.Event.MouseLeave] = function()
			if not isActive then
				transparencySpring:setGoal(TRANSPARENCY_STATES.BASE)
			end
		end,

		[React.Event.Activated] = function()
			props.onSelect(props.option)
		end,
	}, {
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, 8),
		}),
	})
end

local function Dropdown(props: DropdownProps)
	local theme = Theme.useTheme()
	local dropdownOpen, setdropdownOpened = React.useState(false)

	local rotation, rotationSpring = useSpring(ROTATION_STATES.CLOSED, { frequency = 6, dampingRatio = 1.1 })

	React.useEffect(function()
		rotationSpring:setGoal(if dropdownOpen then ROTATION_STATES.OPEN else ROTATION_STATES.CLOSED)
	end, { dropdownOpen })

	React.useEffect(function()
		if props.locked and dropdownOpen then
			setdropdownOpened(false)
		end
	end, { props.locked })

	local dropdownListHeight = math.min(#props.dropdownOptions, MAXIMUM_OPTIONS_VISIBLE) * OPTION_HEIGHT

	local optionElements = {
		Layout = e("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			FillDirection = Enum.FillDirection.Vertical,
		}),
	}

	for index, option in props.dropdownOptions do
		optionElements[`Option_{index}`] = e(DropdownElement, {
			index = index,
			option = option,
			active = props.active,
			theme = theme,
			onSelect = function(selectedOption)
				setdropdownOpened(false)
				props.onSelect(selectedOption)
			end,
		})
	end

	return e("Frame", {
		Size = props.Size or BASE_SIZE,
		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		LayoutOrder = props.layoutOrder,
		BackgroundTransparency = 1,
	}, {
		Head = e(Button, {
			Size = UDim2.fromScale(1, 1),
			hoverScale = 1,
			Activated = function()
				if props.locked then
					return
				end

				setdropdownOpened(function(wasOpen)
					return not wasOpen
				end)
			end,
		}, {
			Background = e("Frame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = theme.Background,
				BorderSizePixel = 0,
			}, {
				UIStroke = e("UIStroke", BEVEL_STROKE),
				UIGradient = e("UIGradient", BEVEL_GRADIENT),

				Active = e(TextLabel, {
					Size = UDim2.new(1, -28, 1, 0),
					Position = UDim2.fromScale(0, 0.5),
					AnchorPoint = Vector2.new(0, 0.5),
					Text = props.active or props.placeholderOption or "Select...",
					TextSize = 14,
					TextColor3 = theme.Foreground,
					TextXAlignment = Enum.TextXAlignment.Center,
					OverrideLabelPosition = UDim2.fromScale(0, 0.5),
					OverrideLabelAnchorPoint = Vector2.new(0, 0.5),
				}),

				Arrow = e(TextLabel, {
					Size = UDim2.fromOffset(20, 20),
					Position = UDim2.new(1, -6, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5),
					Text = "v",
					TextSize = 12,
					TextColor3 = theme.SubText,
					Rotation = rotation,
				}),
			}),
		}),

		Options = if dropdownOpen
			then e(React.Fragment, nil, {
				Overlay = e("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Size = UDim2.fromOffset(10000, 10000),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					ZIndex = 9,

					[React.Event.Activated] = function()
						setdropdownOpened(false)
					end,
				}),
				Panel = e("Frame", {
					Position = UDim2.new(0, 0, 1, 4),
					Size = UDim2.new(1, 0, 0, dropdownListHeight),
					BackgroundColor3 = theme.Background,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 10,
				}, {
					UIStroke = e("UIStroke", BEVEL_STROKE),
					UIGradient = e("UIGradient", BEVEL_GRADIENT),

					Scroller = e("ScrollingFrame", {
						Size = UDim2.fromScale(1, 1),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ScrollBarThickness = 4,
						ScrollBarImageColor3 = theme.SubText,
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						CanvasSize = UDim2.fromOffset(0, 0),
						ZIndex = 10,
					}, optionElements),
				}),
			})
			else nil,
	})
end

return Dropdown
