 include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
function ENT:Draw()
   debugoverlay.Axis(self:GetPos(), self:GetAngles(), 100, 0.1)
   debugoverlay.Line(self:GetPos(), self:GetPos() + self:GetAngles():Up() * -1 * (self:GetMagnetStrength() / 2000), 0.1)
   debugoverlay.Text(self:GetPos(), self:GetAttachedObjNum() .. "/" .. self:GetAttachedObjMax(), 0.1)
end
 