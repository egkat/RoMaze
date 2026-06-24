local useSpring = require(script.Parent.Parent.Parent.Hooks.useSpring)
local React = require(script.Parent.Parent.Parent.Parent.Parent.Packages.React)
local Sift = require(script.Parent.Parent.Parent.Parent.Parent.Packages.Sift)

local e = React.createElement

export type ImageLabelProps = {
    Active: boolean?,
    AnchorPoint: Vector2?,
    AutomaticSize: Enum.AutomaticSize?,
    BackgroundColor3: Color3?,
    BackgroundTransparency: number?,
    ClipsDescendants: boolean?,
    Image: string?,
    ImageColor3: Color3?,
    ImageRectOffset: Vector2?,
    ImageRectSize: Vector2?,
    ImageTransparency: number?,
    LayoutOrder: number?,
    Position: UDim2?,
    Rotation: number?,
    ScaleType: Enum.ScaleType?,
    Size: UDim2?,
    SizeConstraint: Enum.SizeConstraint?,
    SliceCenter: Rect?,
    Visible: boolean?,
    ZIndex: number?,
}

export type ButtonProps = ImageLabelProps & {
    hoverScale: number?,
    children: React.ReactNode?,
    Activated: (() -> ())?,
    OnEnter: (() -> ())?,
    OnLeave: (() -> ())?,
    OnDown: (() -> ())?,
    OnUp: (() -> ())?,
}

type ButtonConstructor = (props: ButtonProps) -> React.ReactNode?

local CUSTOM_PROPS = { "hoverScale", "Activated", "OnEnter", "OnLeave", "OnDown", "OnUp"}

local DEFAULTS = {
    BackgroundTransparency = 1,
    HoverScale = 1.2,
    AutoButtonColor = false,
}

local Button = React.forwardRef(function(props: ButtonProps, ref: any)

    local hoverScale = props.hoverScale or DEFAULTS.HoverScale
    local scale, scaleMotion = useSpring(1, { frequency = 5, dampingRatio = 0.7 })
    local safeProps = Sift.Dictionary.removeKeys(props, table.unpack(CUSTOM_PROPS))

    safeProps.ref = ref
    safeProps.BackgroundTransparency = safeProps.BackgroundTransparency or DEFAULTS.BackgroundTransparency
    safeProps.AutoButtonColor = safeProps.AutoButtonColor or DEFAULTS.AutoButtonColor
    safeProps.children = nil

    safeProps[React.Event.MouseEnter] = function()

        scaleMotion:setGoal(hoverScale)

        if props.OnEnter then
            props.OnEnter()
        end

    end

    safeProps[React.Event.MouseLeave] = function()
   
        scaleMotion:setGoal(1)

        if props.OnLeave then
            props.OnLeave()
        end

    end

    safeProps[React.Event.MouseButton1Down] = function()
  
        if props.OnDown then
            props.OnDown()
        end

    end

    safeProps[React.Event.MouseButton1Up] = function()

        if props.OnUp then
            props.OnUp()
        end

    end

    safeProps[React.Event.Activated] = function()
        if props.Activated then
            props.Activated()
        end
    end
    
    return e("ImageButton", safeProps, e("UIScale", { Scale = scale }), props.children)

end)

return (Button :: any) :: ButtonConstructor