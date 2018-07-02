include('shared.lua')

local starIcon = Material("star.png")

isLooking = false

function ENT:Draw()
	self:DrawModel() 
    local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 90)

	

	cam.Start3D2D(Pos + Ang:Up() * 6, Ang, 0.11)
	--Holy Shit messy code alert! NEE NOOR
		local x = 42 * 0.11
		local y = -90.5 * 0.11
		local w = 62 * 0.11
		local h = 30 * 0.11

		if LocalPlayer():GetEyeTrace().Entity then
			if LocalPlayer():GetEyeTrace().Entity == self then
				localTrace = self:WorldToLocal( LocalPlayer():GetEyeTrace().HitPos ) 
				
			end
		end

		draw.RoundedBox(0, -95, -160, 190, 260, Color(0,0,0,255))
		draw.RoundedBox(0, -90.5, -110, 180, 140, Color(0,0,200,220))
		draw.RoundedBox(0, -90.5, -150, 180, 40, Color(0,0,150,111))
		
		draw.SimpleText( "Armor Charger","Trebuchet24", 0-60, -50-90, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		--draw.SimpleText( self:GetAmount(),"Trebuchet24", 0-60, 5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		draw.RoundedBox(0, -90.5, 42, 180, 30, Color(255,255,255,255))
		draw.RoundedBox(0, -28, 42, 2, 30, Color(0,0,0,255))
		local color = Color(255,255,255,255)
		self:SetIsLooking(false)
		--[[ hover layer ]]--
		if((localTrace.y > y and localTrace.y < y + w ) and (localTrace.x > x and localTrace.x < x + h ) and LocalPlayer():GetEyeTrace().Entity == self) then
			color = Color(0,0,0,105);
			self:SetIsLooking(true)
		end
		draw.RoundedBox(0, -90.5, 42, 62, 30, color)
		
		---------------------

		draw.SimpleText( "UPGRADE","DermaDefaultBold",-84, 48, Color(0,0,0,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

		draw.RoundedBox(0, -90, 30, (self:GetAmount() * 1.8)/self:GetUpgradeLevel(),12, Color(50,50,255,255))
		draw.SimpleText( math.floor((self:GetAmount())/self:GetUpgradeLevel()) .. "%","DermaDefaultBold",-20, 29, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		local lastx = -20

		surface.SetMaterial(starIcon)
		surface.SetDrawColor(255, 255, 0, 255)
		for  i = 1,  self:GetUpgradeLevel() do
			surface.DrawTexturedRect(lastx, 45, 20, 20)
			lastx = lastx + 20
		end

	cam.End3D2D()    
	Ang:RotateAroundAxis(Ang:Right(), 180)
	cam.Start3D2D(Pos + Ang:Up() * 1, Ang, 0.11)
	draw.SimpleText( "Made by NoSharp","Trebuchet18", 0-60, 70, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

	cam.End3D2D()
end

net.Receive("armorcharger.use", function(ply, len) 

	local targetEntity = net.ReadEntity()
	--[[
	

	local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( ScrW()/2 + 150, ScrH()/2+75)
	Frame:SetSize( 300, 150 )
	Frame:SetTitle( "Window Upgrade" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:ShowCloseButton( true )
	Frame:MakePopup()

	local Button = vgui.Create( "DButton", Frame )
	Button:SetText( "Upgrade to:".. targetEntity:GetUpgradeLevel() + 1 )
	Button:SetTextColor( Color( 255, 255, 255 ) )
	Button:SetPos( 100, 75 )
	Button:SetSize( 100, 30 )
	
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
	end
	if(targetEntity:GetUpgradeLevel() == 5) then string = "Fully upgraded";Button:SetText( string ); return end

	Button.DoClick = function()
		local string =  "Upgrade to:".. targetEntity:GetUpgradeLevel() + 1
		
		Button:SetText( string )

		
		
	end
--]]
	net.Start("armorcharger.upgrade")
	--net.WriteEntity(LocalPlayer(),3)
		net.WriteEntity(targetEntity)
		net.WriteInt(1,8)
	net.SendToServer()
end)