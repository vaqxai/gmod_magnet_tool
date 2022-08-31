TOOL.Category = "Construction"
TOOL.Name = "Magnet"
TOOL.Command = nil 
TOOL.ConfigName = ""

if CLIENT then

	TOOL.Information = {

		{ name = "left" }

	}

	language.Add( "tool.magnet.left", "Create a magnet" )

end

TOOL.ClientConVar[ "strength" ] = 1000
TOOL.ClientConVar[ "key" ] = KEY_PAD_0
TOOL.ClientConVar[ "maxobjects" ] = 1
TOOL.ClientConVar[ "toggle" ] = 0

if SERVER then
  util.AddNetworkString("magnet_setStrength")
end

function TOOL:LeftClick( trace )
  if SERVER then

    local key = self:GetClientNumber("key", KEY_PAD_0)
    local maxobjects = self:GetClientNumber("maxobjects", 1)
    local strength = self:GetClientNumber("strength", 1000)
    local toggle = self:GetClientNumber("toggle", 0)

    local ent = construct.Magnet(
      self:GetOwner(),
      Vector(trace.HitPos.x, trace.HitPos.y, trace.HitPos.z + 100),
      Angle(0,0,0),
      "models/props_wasteland/cranemagnet01a.mdl",
      nil,
      key,
      maxobjects,
      strength,
      0, // nopull
      0, // allowrot
      0, // starton
      toggle
    )

    local pull_ent = ents.Create("magnet_pull")
    pull_ent:SetPos(ent:GetPos())
    pull_ent:SetAngles(ent:GetAngles())
    pull_ent:SetParent(ent)

    undo.Create("Magnet")
      undo.AddEntity(ent)
      undo.SetPlayer(self:GetOwner())
    undo.Finish()

  end
end

function TOOL:RightClick ( trace )

end

function TOOL.BuildCPanel( panel )
  panel:Help("Magnet Tool")
  panel:NumSlider("Strength", "magnet_strength", 1, 10000)
  panel:NumSlider("Max. Objects", "magnet_maxobjects", 1, 100, 0)
  panel:KeyBinder("Activation Key", "magnet_key")
  panel:CheckBox("Toggle", "magnet_toggle")
end