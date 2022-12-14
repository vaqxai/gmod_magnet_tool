ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Spawnable = false 

ENT.PrintName		= "Magnet pull"
ENT.Author			= "Vaqxai"
ENT.Contact			= "Don't"
ENT.Purpose			= "Pulls stuff"
ENT.Instructions	= "None"

function ENT:SetupDataTables()

    self:NetworkVar("Bool", 0, "Enabled")
    self:NetworkVar("Float", 0, "MagnetStrength")
    self:NetworkVar("Int", 0, "AttachedObjNum")
    self:NetworkVar("Int", 1, "AttachedObjMax")

    if SERVER then
        self:SetEnabled(false)
    end

end