ENT.Base = "base_gmodentity"
ENT.Type = "point"
ENT.Spawnable = false 

function ENT:Think()

    local ent = self:GetParent()

    local nearby_ents = ents.FindInSphere( ent:GetPos(), 500 )
    print("Dupaa")
    for i,nearby_ent in ipairs(nearby_ents) do
      if nearby_ent:IsValid() and nearby_ent:GetBoneSurfaceProp(0) == "solidmetal" and (nearby_ent != ent) then
        local nearby_pos = nearby_ent:GetPos()
        local this_pos = ent:GetPos()

        local cross = this_pos:Cross(nearby_pos)

        debugoverlay.Axis(nearby_pos, cross:Angle(), 10, 1, true)

      end
    end
end
