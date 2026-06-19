-- From https://create.roblox.com/docs/luau/stacks
-- With added generic types

local Stack = {}
Stack.__index = Stack

export type Stack<T> = typeof(setmetatable({} :: { _stack: { T } }, Stack))

function Stack.new<T>(): Stack<T>
	local self = setmetatable({}, Stack)

	self._stack = {}

	return (self :: any) :: Stack<T>
end

-- Check if the stack is empty
function Stack.isEmpty<T>(self: Stack<T>): boolean
	return #self._stack == 0
end

-- Put a new value onto the stack
function Stack.push<T>(self: Stack<T>, value: T)
	table.insert(self._stack, value)
end

-- Take a value off the stack
function Stack.pop<T>(self: Stack<T>): T?
	if self:isEmpty() then
		return nil
	end

	return table.remove(self._stack, #self._stack)
end

-- Check value at top off stack without removing it
function Stack.peek<T>(self: Stack<T>): T?
	if self:isEmpty() then
		return nil
	end

	return self._stack[#self._stack]
end

return Stack
