local AppearanceSlice = require(script.AppearanceSlice)
local Dropdown = require(script.Parent.Parent.Components.PrimitiveComponents.Dropdown)
local TextLabel = require(script.Parent.Parent.Components.PrimitiveComponents.TextLabel)
local Icons = require(script.Parent.Parent.Parent.Assets.Icons)
local Constants = require(script.Parent.Parent.Parent.Data.Constants)
local React = require(script.Parent.Parent.Parent.Parent.Packages.React)
local ReactCharm = require(script.Parent.Parent.Parent.Parent.Packages.ReactCharm)
local GetColorStringFromRGB = require(script.Parent.Parent.Parent.Utils.GetColorStringFromRGB)
local Theme = require(script.Parent.Parent.Theme)

local e = React.createElement

export type AppearanceProps = {
	transparency: number,
}

local function Appearance(props: AppearanceProps)
	local theme = Theme.useTheme()
	local selectedPartMaterial = ReactCharm.useAtom(AppearanceSlice.state.selectedPartMaterial)
	local selectedPartColor = ReactCharm.useAtom(AppearanceSlice.state.selectedPartColor)

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
				BackgroundColor3 = Constants.PAGE_COLORS.APPEARANCE,
			}, {

				InsetFrame = e("Frame", {
					Size = UDim2.new(1, -5, 1, -5),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
				}, {

					AppearanceLabel = e(TextLabel, {
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.fromScale(0, 0.5),
						Size = UDim2.fromScale(1, 1),
						Text = "Appearance",
						TextSize = 24,
						Stroke = {
							Color = Color3.fromRGB(0, 0, 0),
							Thickness = 2,
							Transparency = 0,
						},
						Prefix = {
							Size = UDim2.fromScale(1, 1),
							Image = Icons.SidebarIcons.Appearance,
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

				InsetFrame = e("Frame", {
					Size = UDim2.new(1, -10, 1, -10),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
				}, {
					LeftFrame = e("Frame", {
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.fromScale(0, 0.5),
						Size = UDim2.fromScale(0.4, 1),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
					}, {
						TopFrame = e("Frame", {
							Position = UDim2.fromScale(0.5, 0),
							AnchorPoint = Vector2.new(0.5, 0),
							Size = UDim2.new(1, 0, 0, 30),
							BackgroundColor3 = theme.Brand,
							BorderSizePixel = 0,
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
							PartLabel = e(TextLabel, {
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromScale(1, 1),
								Text = "Part Configuration",
								TextSize = 16,
								Stroke = {
									Color = Color3.fromRGB(0, 0, 0),
									Thickness = 2,
									Transparency = 0,
								},
								Gradient = {
									Rotation = 90,
									Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(208, 208, 208)),
									}),
								},
							}),
							MaterialDropdown = e(Dropdown, {
								Position = UDim2.new(0.5, 0, 0, 40),
								AnchorPoint = Vector2.new(0.5, 0),
								Size = UDim2.new(1, -10, 0, 28),
								placeholderOption = "Material",
								dropdownOptions = Constants.MATERIALS,
								active = selectedPartMaterial,
								onSelect = AppearanceSlice.actions.setSelectedPartMaterial,
							}),

							ColorPickerFrame = e("Frame", {
								Position = UDim2.new(0.5, 0, 0, 80),
								AnchorPoint = Vector2.new(0.5, 0),
								Size = UDim2.new(1, -10, 0, 28),
								BackgroundColor3 = theme.Background,
								BorderSizePixel = 0,
							}, {
								UIStroke = e("UIStroke", {
									Thickness = 1,
									Color = Color3.fromRGB(0, 0, 0),
								}),
								UIGradient = e("UIGradient", {
									Rotation = 90,
									Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(187, 187, 187)),
									}),
								}),
								ColorButton = e("TextButton", {
									Size = UDim2.fromScale(1, 1),
									Position = UDim2.fromScale(0.5, 0.5),
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundTransparency = 1,
									BorderSizePixel = 0,
									Text = "",
									[React.Event.Activated] = function()
										print("activated")
									end,
								}, {
									ColorLabelFrame = e("Frame", {
										AnchorPoint = Vector2.new(0, 0.5),
										Position = UDim2.fromScale(0, 0.5),
										Size = UDim2.new(1, -30, 1, 0),
									}, {
										ColorLabel = e(TextLabel, {
											AnchorPoint = Vector2.new(0.5, 0.5),
											Position = UDim2.fromScale(0.5, 0.5),
											Size = UDim2.new(1, -5, 1, -5),
											Text = GetColorStringFromRGB(selectedPartColor, true),
											TextSize = 14,
											TextColor3 = theme.Foreground,
											TextXAlignment = Enum.TextXAlignment.Center,
										}),
									}),
									ColorPreviewFrame = e("Frame", {
										AnchorPoint = Vector2.new(1, 0.5),
										Position = UDim2.fromScale(1, 0.5),
										Size = UDim2.fromOffset(28, 28),
										BackgroundTransparency = 1,
										BorderSizePixel = 0,
									}, {
										ColorFrame = e("Frame", {
											AnchorPoint = Vector2.new(0.5, 0.5),
											Position = UDim2.fromScale(0.5, 0.5),
											Size = UDim2.new(1, -5, 1, -5),
											BackgroundColor3 = selectedPartColor,
											BorderSizePixel = 0,
										}, {
											UIStroke = e("UIStroke", {
												Thickness = 1,
												Color = Color3.fromRGB(0, 0, 0),
											}),
										}),
									}),
								}),
							}),
						}),
					}),
					RightFrame = e("Frame", {
						AnchorPoint = Vector2.new(1, 0.5),
						Position = UDim2.fromScale(1, 0.5),
						Size = UDim2.fromScale(0.5, 1),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
					}),
				}),

				-- TopFrame = e("Frame", {
				-- 	AnchorPoint = Vector2.new(0.5, 0),
				-- 	Position = UDim2.fromScale(0.5, 0),
				-- 	Size = UDim2.new(1, 0, 0, 25),
				-- }),
			}),
		}),
	})
end

return Appearance
