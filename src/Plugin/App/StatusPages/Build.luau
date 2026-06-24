local React = require(script.Parent.Parent.Parent.Parent.Packages.React)

local e = React.createElement

local function Build()
	return e("TextLabel", {
        Size = UDim2.fromOffset(200, 100),
        Text = "Build"
    })
end

return Build
