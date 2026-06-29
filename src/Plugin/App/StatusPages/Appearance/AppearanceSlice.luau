local Charm = require(script.Parent.Parent.Parent.Parent.Parent.Packages.Charm)

local atom = Charm.atom
type Atom<T> = Charm.Atom<T>

local selectedPartMaterial: Atom<string> = atom("Plastic")
local selectedPartColor: Atom<Color3> = atom(Color3.fromRGB(163, 162, 165))
local selectedPartTransparency: Atom<number> = atom(0)

local actions = {
	setSelectedPartMaterial = function(material: string)
		selectedPartMaterial(function(_oldMaterial: string)
			return material
		end)
	end,
	setSelectedPartColor = function(color: Color3)
		selectedPartColor(function(_oldColor: Color3)
			return color
		end)
	end,
	setSelectedPartTransparency = function(transparency: number)
		selectedPartTransparency(function(_oldTransparency: number)
			return transparency
		end)
	end,
}

return {
	actions = actions,
	state = {
		selectedPartMaterial = selectedPartMaterial,
		selectedPartColor = selectedPartColor,
		selectedPartTransparency = selectedPartTransparency,
	},
}
