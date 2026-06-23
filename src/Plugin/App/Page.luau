local useSpring = require(script.Parent.Hooks.useSpring)
local React = require(script.Parent.Parent.Parent.Packages.React)

local e = React.createElement

export type PageProps = {
	component: any,
	active: boolean,
}

local function Page(props: PageProps)
	local transparency, transparencySpring = useSpring(props.active and 1 or 0)

	local pos = transparency:map(function(value)
		value = props.active and value or -value
		return UDim2.fromOffset(value * 30, 0)
	end)

	if not props.active then
		return nil
	end

	return e("Frame", {
		Position = pos,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
	}, {
        Component = e(props.component, {
            transparency = transparency
        })
    })
end

return Page
