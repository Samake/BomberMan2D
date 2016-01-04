--[[
	Name: BomberMan2D
	Filename: PlayerManagerC.lua
	Authors: Sam@ke
--]]

PlayerManagerC = {}

function PlayerManagerC:constructor(parent)
	mainOutput("PlayerManagerC was loaded.")
	
	self.mainClass = parent
	
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.player = new(PlayerC, self)
end



function PlayerManagerC:update()
	if (self.renderTarget) and (self.player) then
		dxSetRenderTarget(self.renderTarget, true)

		
		dxSetRenderTarget()
	end
end


function PlayerManagerC:getPlayerRender()
	return self.renderTarget
end


function PlayerManagerC:destructor()

	if (self.player) then
		delete(self.player)
		self.player = nil
	end
	
	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	mainOutput("PlayerManagerC was deleted.")
end
