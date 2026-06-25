local useSpring = require(script.Parent.Hooks.useSpring)
local React = require(script.Parent.Parent.Parent.Packages.React)

local e = React.createElement

export type PageProps = {
	component: any,
	active: boolean,
}

local function Page(props: PageProps)
	local rendered, setRendered = React.useState(props.active)
	local value, valueSpring = useSpring(props.active and 1 or 0, { frequency = 6, dampingRatio = 1 })

	React.useEffect(function()
		valueSpring:setGoal(props.active and 1 or 0)
	end, { props.active })

	React.useEffect(function()
		return valueSpring:onChange(function(current)
			setRendered(current > 0)
		end)
	end, {})

	if not rendered then
		return nil
	end

	local transparency = value:map(function(current)
		return 1 - current
	end)

	local position = transparency:map(function(current)
		current = props.active and current or -current
		return UDim2.fromOffset(current * 30, 0)
	end)

	return e("Frame", {
		Position = position,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {
		Component = e(props.component, {
			transparency = transparency,
		}),
	})
end

return Page
