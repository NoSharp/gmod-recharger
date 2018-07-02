local ent = getmetatable("Entity ")


AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside

AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

ArmorCharger = {}



function ENT:UpdateArmor()
    local amount = tonumber(self:GetAmount())
    
    
    if(!IsValid(self)) then return end
    if(self:GetAmount() == 0) then 
        self:SetIsActive(false)
        timer.Simple(3, function() 
            self:SetIsActive(true) 
            self:SetAmount(amount + 1) 
        end)
        return
    end
    if(not (amount == 100*self:GetUpgradeLevel())) then 
        self:SetAmount(amount + 1) 
    else
        return
    end
    
    
end

function ENT:Initialize()
    self.index = self:EntIndex()
    --print(ArmorCharger.index)
    self:SetAmount(100);
    self:SetUpgradeLevel(1);
    self:SetIsLooking(false);
    self:SetIsActive(true) 

    self:SetOwner(self.Owner)
    self:SetModel( "models/props_c17/consolebox05a.mdl" )
       
    self:SetColor(Color(90, 90, 255, 255))
    
    self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
    
    self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
    
    self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
   

    local phys = self:GetPhysicsObject()
    
    if (phys:IsValid()) then
        
        phys:Wake()
    
    end
    
end
 

function ENT:Think() 
    if(!IsValid(self)) then return end
    
    if(self:GetIsActive() == false) then return end

    

    if(self:UpdateArmor() == nil) then return end
    timer.Simple(0.5, function () self:UpdateArmor() end)
end

function ENT:AddUpgradeLevel(amount)
    if(self:GetUpgradeLevel() == 5) then return end
    self:SetUpgradeLevel(self:GetUpgradeLevel() + amount)
end

function ENT:Use( activator, caller )
    local x = 42 * 0.11
    local y = -90.5 * 0.11
    local w = 62 * 0.11
    local h = 30 * 0.11
    if caller:GetEyeTrace().Entity then
        if caller:GetEyeTrace().Entity == self then
            localTrace = self:WorldToLocal( caller:GetEyeTrace().HitPos ) 
            
        end
    end
    self:SetUseType(CONTINUOUS_USE)
    if((localTrace.y > y and localTrace.y < y + w ) and (localTrace.x > x and localTrace.x < x + h )) then
        self:SetUseType( SIMPLE_USE )
        net.Start("armorcharger.use")
            net.WriteEntity(self,1)
        net.Send(caller)
        return
    end
    
    if(self:GetAmount() == 0) then return end
    if(!IsValid(activator)) then return end

    if(activator:Health()>= 100) then return end

    

    if(self:GetAmount() > 1 or self:GetAmount() == 1) then
        activator:SetHealth(activator:Health() + 1)
        local amount = self:GetAmount()
        self:SetAmount(amount - 1)
    else
        activator:SetHealth(activator:Health() + self:GetAmount())
        local amount = self:GetAmount()
        self:SetAmount(0)
    end

end
 