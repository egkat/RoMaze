local React = require(script.Parent.Parent.Parent.Parent.Packages.React)

local e = React.createElement

local function Home()
	return e("TextLabel", {
        Size = UDim2.fromOffset(200, 100),
        Text = "Home"
    })
end

return Home

