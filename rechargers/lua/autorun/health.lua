if SERVER then
    util.AddNetworkString( "armorcharger.use" )
    util.AddNetworkString("armorcharger.upgrade")

    net.Receive("armorcharger.upgrade", function(len,ply) 

        local player = ply
        local targetentity = net.ReadEntity()
        local upgradeamount = net.ReadInt(8)    

        if(!IsValid(player)) then return end
        if(!IsValid(targetentity)) then return end
        if(targetentity:GetUpgradeLevel() == 5) then
            player:PrintMessage( HUD_PRINTTALK, "You're fully upgraded!")
            return
        end
        
        if(not player:canAfford( (upgradeamount +  targetentity:GetUpgradeLevel()) * 1500)) then 
            player:PrintMessage( HUD_PRINTTALK, "You can't afford this upgrade.")
            return
        end

        player:addMoney(-(upgradeamount +  targetentity:GetUpgradeLevel() * 1500))
        targetentity:AddUpgradeLevel(upgradeamount)
    end)

        

end