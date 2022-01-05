CreateItemTable("AirDropCrate");

-- Called when the crate is initially dropped
--function AirDropCrate:OnDropped()
	--Log("AirDropCrate - OnDropped")
--end

-- Called when the crate is close to landing - about 10m above the ground
-- This is when the crate is physicalized and falls due to gravity
--function AirDropCrate:OnLanding()
	--Log("AirDropCrate - OnLanding")
--end

-- Called when the crate is about to land - about 2.5m above the ground
-- This is when the lading particle effects and audio are played
function AirDropCrate:OnLanded()
        Log("AirDropCrate - OnLanded")
        Script.SetTimerForFunction(1000, "SpawnAISingle", self)
end

SpawnAISingle = function(self)

	local vForwardOffset = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
	local vSpawnPos = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

	AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)

end
