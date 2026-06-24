local React = require(script.Parent.Parent.Parent.Parent.Packages.React)

local e = React.createElement

local function Appearance()
	return e("TextLabel", {
        Size = UDim2.fromOffset(200, 100),
        Text = "Appearance"
    })
end

return Appearance
