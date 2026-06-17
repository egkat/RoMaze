local React = require(script.Parent.Parent.Parent.Parent.Packages.React)
local GetStudioSetting = require(script.Parent.Parent.Parent.Utils.GetStudioSetting)

local e = React.createElement

local ThemeContext = React.createContext(nil)

local function buildTheme()
	local studioTheme: StudioTheme = GetStudioSetting("Theme")

	local function get(styleGuideItem: Enum.StudioStyleGuideColor, modifier: Enum.StudioStyleGuideModifier?): Color3
		return studioTheme:GetColor(styleGuideItem, modifier)
	end

	return {
		Background = get(Enum.StudioStyleGuideColor.MainBackground),
		Foreground = get(Enum.StudioStyleGuideColor.MainText),
		Border = get(Enum.StudioStyleGuideColor.Border),
		SubText = get(Enum.StudioStyleGuideColor.SubText),
		Brand = Color3.fromHex("4F8EF7"),
	}
end

local function ThemeProvider(props)
	local theme, setTheme = React.useState(buildTheme)

	React.useEffect(function()
		local conn = GetStudioSetting("ThemeChanged"):Connect(function()
			setTheme(buildTheme())
		end)

		return function()
			conn:Disconnect()
		end
	end, {})

	return e(ThemeContext.Provider, { value = theme }, props.children)
end

local function useTheme()
	return React.useContext(ThemeContext)
end

return {
	Provider = ThemeProvider,
	useTheme = useTheme,
}
