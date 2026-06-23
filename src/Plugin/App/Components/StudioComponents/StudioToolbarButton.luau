local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local StudioToolbarContext = require(script.Parent.StudioToolbarContext)

type StudioToolbarButtonProps = {
	name: string,
	tooltip: string?,
	icon: string?,
	active: boolean?,
	onClick: (() -> ())?,
}

local function StudioToolbarButton(props: StudioToolbarButtonProps)
	local toolbar = React.useContext(StudioToolbarContext)
	local button, setButton = React.useState(nil)

	React.useEffect(function()
		if not toolbar then return end

		local newButton = toolbar:CreateButton(
			props.name,
			props.tooltip or "",
			props.icon or ""
		)
		setButton(newButton)

		local conn = newButton.Click:Connect(function()
			if props.onClick then
				props.onClick()
			end

		end)

		return function()
			conn:Disconnect()
			newButton:Destroy()
			setButton(nil)
		end
	end, { toolbar })

	React.useEffect(function()
		if button then
			button:SetActive(props.active or false)
		end
	end, { button, props.active })

	return nil
end

return StudioToolbarButton