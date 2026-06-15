local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local StudioToolbarContext = require(script.Parent.StudioToolbarContext)

local e = React.createElement

type StudioToolbarProps = {
    plugin: Plugin,
    name: string,
    children: { [string]: React.ReactElement }?,
}

local function StudioToolbar(props: StudioToolbarProps)

    local toolbar, setToolbar = React.useState(nil)

    React.useEffect(function()
        local newToolbar = props.plugin:CreateToolbar(props.name)
        setToolbar(newToolbar)

        return function()
            newToolbar:Destroy()
        end
    end, {})

    return e(StudioToolbarContext.Provider, {
        value = toolbar,
    }, props.children)
end

return StudioToolbar