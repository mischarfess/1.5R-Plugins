-- !native
-- !optimize 2
local physics = {}

type state = {
	current: (number | Vector3)?,
	velocity: (number | Vector3)?,
	acceleration: (number | Vector3)?,
}

--[[
	a = state: table
	b = target: number | Vector3
	c = smoothness: number | Vector3
	d = deltaTime: number
]]

function physics.velocity(
	a: state,
	b: number | Vector3,
	c: number | Vector3,
	d: number
): number | Vector3
	
	local target: Vector3 = typeof(b) == "number" and Vector3.new(b, b, b) or b
	local smoothTime: Vector3 = typeof(c) == "number" and Vector3.new(c, c, c) or c

	smoothTime = Vector3.new(0.001, 0.001, 0.001):Max(smoothTime)

	if a.current == nil then
		a.current = target
		a.velocity = Vector3.zero
		return typeof(b) == "number" and (a.current :: Vector3).X or a.current
	end

	local currentPos: Vector3 = typeof(a.current) == "number" and Vector3.new(a.current, a.current, a.current) or a.current

	local alphaX = 1 - math.exp(-d / smoothTime.X)
	local alphaY = 1 - math.exp(-d / smoothTime.Y)
	local alphaZ = 1 - math.exp(-d / smoothTime.Z)

	local newPos = Vector3.new(
		currentPos.X + (target.X - currentPos.X) * alphaX,
		currentPos.Y + (target.Y - currentPos.Y) * alphaY,
		currentPos.Z + (target.Z - currentPos.Z) * alphaZ
	)

	a.current = newPos

	if typeof(b) == "number" then
		return (a.current :: Vector3).X
	end

	return a.current
end

--[[
	a = state: table
	b = target: number | Vector3
	c = mass: number | Vector3
	d = stiffness: number | Vector3
	e = damping: number | Vector3
	f = deltaTime: number
]]

function physics.spring(
	a: state,
	b: number | Vector3,
	c: number | Vector3,
	d: number | Vector3,
	e: number | Vector3,
	f: number
): number | Vector3
	
	local isVec = typeof(b) == "Vector3"

	local mass = isVec 
		and Vector3.new(0.001, 0.001, 0.001):Max(c) 
		or math.max(c, 0.001)

	if a.current == nil then
		a.current = b
		a.velocity = isVec and Vector3.zero or 0
		return a.current
	end

	local displacement = a.current - b
	local springForce = displacement * -d
	local dampingForce = (a.velocity :: any) * -e

	local totalForce = springForce + dampingForce
	local acceleration = totalForce / mass

	a.velocity = (a.velocity :: any) + (acceleration * f)
	a.current = (a.current :: any) + (a.velocity * f)

	return a.current
end

return physics
