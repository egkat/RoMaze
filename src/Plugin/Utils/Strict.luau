-- From https://github.com/rojo-rbx/rojo/blob/master/plugin/src/strict.lua

local function _strict(name, target)
	assert(typeof(name) == "string", "Argument #1 to `strict` must be a string or the table to modify")
	assert(typeof(target) == "table", "Argument #2 to `strict` must be nil or the table to modify")

	setmetatable(target, {
		__index = function(_, key)
			error(("%q is not a valid member of strict table %q"):format(tostring(key), name), 2)
		end,

		__newindex = function()
			error(("Strict table %q is read-only"):format(name), 2)
		end,
	})

	return target
end

return function(nameOrTarget, target)
	if typeof(nameOrTarget) == "string" then
		return _strict(nameOrTarget, target)
	else
		return _strict(`<unnamed table>`, target)
	end
end
