local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local StudioPluginContext = require(script.Parent.StudioPluginContext)
local StudioToolbarContext = require(script.Parent.StudioToolbarContext)

local e = React.createElement

type StudioToolbarProps = {
	name: string,
	children: { [string]: React.ReactElement }?,
}

local function StudioToolbar(props: StudioToolbarProps)
	local studioPlugin = React.useContext(StudioPluginContext)
	local toolbar, setToolbar = React.useState(nil)

	React.useEffect(function()
		if not studioPlugin then return end

		local newToolbar = studioPlugin:CreateToolbar(props.name)
		setToolbar(newToolbar)

		return function()
			newToolbar:Destroy()
		end
	end, { studioPlugin })

	return e(StudioToolbarContext.Provider, {
		value = toolbar,
	}, props.children)
end

return StudioToolbar