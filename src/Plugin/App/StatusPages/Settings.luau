local React = require(script.Parent.Parent.Parent.Parent.Packages.React)

local e = React.createElement

local function Settings()
	return e("TextLabel", {
        Size = UDim2.fromOffset(200, 100),
        Text = "Settings"
    })
end

return Settings
