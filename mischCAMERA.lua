local v2 = Vector2.new		-- (Vertical, Longitudinal)
local v3 = Vector3.new		-- (Horizontal, Vertical, Longitudinal)

return {
	-- Spring 
	Damping		= v3(12 /2, 24 /2, 48 /2),			-- Resistance to oscillation
	Stiffness	= v3(84, 168, 336),			-- Resistance to movement
	Attenuation	= v3(6, 12, 24),			-- Output reduction
	Mass		= v3(6, 12, 24),			-- Movement weight
	Limit		= v3(12, 12, 12),			-- Travel limit (Studs)

	camMouseMax			= 180,				-- Maximum rotation from mouse
	camMouseScale		= 5,				-- Rotation scale on right click
	camMouseDecay		= 25,				-- Rotation decay on release
	
	camLookAngleBase	= 12,				-- Base camera pitch angle
	camPosOffsetBase	= v2(3, 6),			-- Base offset (Y, Z)
	camMovementScale	= v3(1, 1, 1),		-- Movement scale 
	camPitchSpring		= v3(1.2, 40, 24),	-- Pitch angle spring (Mass, Stiffness, Damping)
}
