local ReactRoblox = require(script.Parent.Packages.ReactRoblox)
local App = require(script.App)
local React = require(script.Parent.Packages.React)

if not plugin then
    warn(`[RoMaze]: Plugin not found.`)
    return
end

local root = ReactRoblox.createRoot(game:GetService("CoreGui"))
root:render(React.createElement(App, { plugin = plugin }))

plugin.Unloading:Connect(function()
    root:unmount()
end)
