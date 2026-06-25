local TextLabel = require(script.Parent.Parent.Components.PrimitiveComponents.TextLabel)
local Icons = require(script.Parent.Parent.Parent.Assets.Icons)
local Constants = require(script.Parent.Parent.Parent.Data.Constants)
local React = require(script.Parent.Parent.Parent.Parent.Packages.React)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

export type HomeProps = {
	transparency: number,
}

local function Home(props: HomeProps)
	local theme = Theme.useTheme()

	return e(React.Fragment, nil, {

		InnerFrame = e("Frame", {
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, -10, 1, -26),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
		}, {
			TopFrame = e("Frame", {
				AnchorPoint = Vector2.new(0.5, 0),
				Position = UDim2.fromScale(0.5, 0),
				Size = UDim2.new(1, 0, 0, 35),
				BorderSizePixel = 0,
				BackgroundColor3 = Constants.PAGE_COLORS.HOME,
			}, {

				InsetFrame = e("Frame", {
					Size = UDim2.new(1, -5, 1, -5),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
				}, {

					HomeLabel = e(TextLabel, {
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.fromScale(0, 0.5),
						Size = UDim2.fromScale(1, 1),
						Text = "Home",
						TextSize = 24,
						Stroke = {
							Color = Color3.fromRGB(0, 0, 0),
							Thickness = 2,
							Transparency = 0,
						},
						Prefix = {
							Size = UDim2.fromScale(1, 1),
							Image = Icons.SidebarIcons.Home,
							HorizontalAlignment = Enum.HorizontalAlignment.Left,
						},
						Gradient = {
							Rotation = 90,
							Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(208, 208, 208)),
							}),
						},
					}),
				}),

				UIStroke = e("UIStroke", {
					Color = Color3.fromRGB(0, 0, 0),
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

			BottomFrame = e("Frame", {
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.fromScale(0.5, 1),
				Size = UDim2.new(1, 0, 1, -35),
				BorderSizePixel = 0,
				BackgroundColor3 = theme.Background,
			}, {
				UIStroke = e("UIStroke", {
					Color = Color3.fromRGB(0, 0, 0),
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
		}),

		-- Frame = e("Frame", {
		-- 	Position = UDim2.fromScale(0.5, 0.5),
		-- 	AnchorPoint = Vector2.new(0.5, 0.5),
		-- 	Size = UDim2.fromOffset(100, 100)
		-- })

		-- Accent = e("Frame", {
		-- 	Size = UDim2.new(0, 4, 1, 0),
		-- 	Position = UDim2.fromScale(0, 0.5),
		-- 	AnchorPoint = Vector2.new(0, 0.5),
		-- 	BackgroundColor3 = Constants.PAGE_COLORS.HOME,
		-- 	BackgroundTransparency = props.transparency,
		-- 	BorderSizePixel = 0,
		-- }),

		-- Title = e("TextLabel", {
		-- 	Text = "Home",
		-- 	Font = Enum.Font.SourceSansBold,
		-- 	TextSize = 18,
		-- 	TextColor3 = theme.Foreground,
		-- 	TextTransparency = props.transparency,
		-- 	TextXAlignment = Enum.TextXAlignment.Left,
		-- 	Position = UDim2.fromOffset(12, 8),
		-- 	Size = UDim2.new(1, -20, 0, 24),
		-- 	BackgroundTransparency = 1,
		-- }),
	})
end

return Home
