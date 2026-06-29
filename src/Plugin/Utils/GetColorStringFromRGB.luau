return function(color: Color3, withParens: boolean?): string
	local r = math.round(color.R * 255)
	local g = math.round(color.G * 255)
	local b = math.round(color.B * 255)

	local result = string.format("%d, %d, %d", r, g, b)

	if withParens then
		return string.format("(%s)", result)
	end

	return result
end
