AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:Initialize()
  self:SetModel( "models/props_interiors/BathTub01a.mdl" )
  self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
  self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
  self:SetSolid( SOLID_VPHYSICS )         -- Toolbox

        local phys = self:GetPhysicsObject()
  if (phys:IsValid()) then
    phys:Wake()
  end
end

hook.Add("AcceptInput", "Magnet_OnOff", function(ent, input, activator, caller, value)

  if ent:GetClass() == "phys_magnet" and (input == "TurnOn" or input == "TurnOff") then
    for i,child_ent in ipairs(ent:GetChildren()) do
      if child_ent:GetClass() == "magnet_pull" then
        child_ent:MagnetInput(input, value)
      end
    end
  end

end)

function ENT:MagnetInput( input, value )
  if input == "TurnOn" then
    self:SetEnabled(true)
  elseif input == "TurnOff" then
    self:SetEnabled(false)
    self:MagnetAttach(0) // 0 means detach all
  end
end

function ENT:IsFull()
  if self:GetAttachedObjNum() < self:GetMaxObjNum() then return false else return true end
end

function ENT:AcceptInput(name, activator, caller, data)
  if name == "Attach" then
    self:MagnetAttach(1)
  elseif name == "Detach" then
    self:MagnetAttach(-1)
  end
end

function ENT:MagnetAttach(value)

  if value == 0 then
    self:SetAttachedObjNum(0)
  else
    self:SetAttachedObjNum(self:GetAttachedObjNum() + value)
  end

end

function ENT:Think()

  if self:GetEnabled() and !self:IsFull() then

    local ent = self:GetParent()

    local nearby_ents = ents.FindInSphere( ent:GetPos(), (self:GetMagnetStrength() / 1000) )
    for i,nearby_ent in ipairs(nearby_ents) do

      if (nearby_ent == self:GetParent()) then continue end
      if (nearby_ent == self) then continue end

      local surf = nearby_ent:GetBoneSurfaceProp(0)
      local i = 5
      if nearby_ent:IsValid() and string.match(surf, ".*metal.*") != nil and (nearby_ent != ent) and (nearby_ent:GetClass() != "magnet_pull") then
        local nearby_pos = nearby_ent:GetPos()

        local offset = Vector(0,0,-50) 

        local this_pos = ent:LocalToWorld(offset)

        local crossAng = (this_pos - nearby_pos):Angle()

        local dist = this_pos:Distance(nearby_pos)

        forceVec = (crossAng:Forward() * (20 * self:GetMagnetStrength())) / ( dist / 2 )

        local physObj = nearby_ent:GetPhysicsObject()

        if dist > 100 then
          physObj:ApplyForceCenter(forceVec)
        end

      end
    end

  end
end
