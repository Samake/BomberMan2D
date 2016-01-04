--[[
	Name: BomberMan2D
	Filename: PlayerC.lua
	Authors: Sam@ke
--]]

PlayerC = {}

function PlayerC:constructor(parent)

	self.playerManager = parent
	
	self.postGUI = false
	self.subPixelPositioning = false

	self.isLoaded = self.playerManager
	mainOutput("PlayerC was loaded.")
end


function PlayerC:update()
	if (self.isLoaded) then
		dxSetRenderTarget(self.playerManager.renderTarget, false)
		
		dxSetRenderTarget()
	end
end


function PlayerC:destructor()

	mainOutput("PlayerC was deleted.")
end
