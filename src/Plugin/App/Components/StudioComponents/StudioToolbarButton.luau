local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local StudioToolbarContext = require(script.Parent.StudioToolbarContext)

local e = React.createElement

type StudioToolbarButtonProps = {
    name: string,
    tooltip: string?,
    icon: string?,
    onClick: (() -> ())?,
}

local function StudioToolbarButton(props: StudioToolbarButtonProps)
    local toolbar = React.useContext(StudioToolbarContext)

    React.useEffect(function()
        if not toolbar then return end

        local button = toolbar:CreateButton(
            props.name,
            props.tooltip or "",
            props.icon or ""
        )

        local conn = button.Click:Connect(function()
            if props.onClick then
                props.onClick()
            end
        end)

        return function()
            conn:Disconnect()
            button:Destroy()
        end
    end, { toolbar })

    return nil
end

return StudioToolbarButton