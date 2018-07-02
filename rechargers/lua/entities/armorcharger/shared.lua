ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "Armor Charger"
ENT.Author= "NoSharp"
ENT.Contact= ""
ENT.Purpose= "Armor Charger"
ENT.Instructions= "Use wisely"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	
	self:NetworkVar( "Int", 0, "Amount")
	self:NetworkVar( "Int", 1, "UpgradeLevel")
	self:NetworkVar( "Bool", 0, "IsLooking")
	self:NetworkVar( "Bool", 1, "IsActive")
end