local useSpring = require(script.Parent.Parent.Parent.Hooks.useSpring)
local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local Button = require(script.Parent.Parent.PrimitiveComponents.Button)
local TextLabel = require(script.Parent.Parent.PrimitiveComponents.TextLabel)

local e = React.createElement

export type SidebarButtonProps = {
	icon: string,
	active: boolean,
	label: string,
	color: Color3,
	layoutOrder: number,
	onClick: () -> (),
}

local function SidebarButton(props: SidebarButtonProps)
	local transparency, transparencySpring = useSpring(1)
	local hovered, setHovered = React.useState(false)

	React.useEffect(function()
		local goal = if props.active then 0 elseif hovered then 0.5 else 0.8
		transparencySpring:setGoal(goal)
	end, { props.active, hovered })

	return e(Button, {
		LayoutOrder = props.layoutOrder,
		Size = UDim2.fromOffset(35, 35),
		AnchorPoint = Vector2.new(0.5, 0.5),
		hoverScale = 1.05,
		Activated = function()
			props.onClick()
		end,
		OnEnter = function()
			setHovered(true)
		end,
		OnLeave = function()
			setHovered(false)
		end,
	}, {
		CoreFrame = e("Frame", {
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = transparency,
			BackgroundColor3 = props.color,
		}, {
			Caption = e(TextLabel, {
				Size = UDim2.new(1, -6, 0, 24),
				Position = UDim2.new(0.5, 0, 1, -2),
				AnchorPoint = Vector2.new(0.5, 1),
				TextYAlignment = Enum.TextYAlignment.Bottom,
				TextSize = 6,
				Text = props.label,
				Stroke = {
					Color = Color3.fromRGB(0, 0, 0),
					Thickness = 1,
					Transparency = 0,
				},
			}),

			UIStroke = e("UIStroke", {
				Color = props.active and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(0, 0, 0),
				Thickness = 1,
			}),
			UIGradient = e("UIGradient", {
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(187, 187, 187)),
				}),
			}),
		}),
	})
end

return SidebarButton
