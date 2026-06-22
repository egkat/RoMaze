local PartFactory = {}

function PartFactory.createPart(name: string, cFrame: CFrame, size: Vector3, parent: Instance): BasePart
	local part = Instance.new("Part")

	part.Name = name
	part.Anchored = true
	part.CFrame = cFrame
	part.Size = size
	part.Parent = parent

	return part
end

return PartFactory