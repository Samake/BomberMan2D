--[[
	Name: BomberMan2D
	Filename: PlayerManagerC.lua
	Authors: Sam@ke
--]]

PlayerManagerC = {}

function PlayerManagerC:constructor(parent)
	mainOutput("PlayerManagerC was loaded.")
	
	self.mainClass = parent
	
	self.playerPositions = {}
	
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.playerClass = new(PlayerC, self)
	
	self.m_RefreshPlayerPositions = bind(self.refreshPlayerPositions, self)
	addEvent("BM2DREFRESHPLAYERPOSITIONS", true)
	addEventHandler("BM2DREFRESHPLAYERPOSITIONS", root, self.m_RefreshPlayerPositions)
end



function PlayerManagerC:update()
	if (self.renderTarget) and (self.playerClass) and (self.mainClass.mapManager) then
	
		self.mapTileSize = self.mainClass.mapManager.mapTileSize
		self.startX = self.mainClass.mapManager.startX
		self.startY = self.mainClass.mapManager.startY

		dxSetRenderTarget(self.renderTarget, true)
		
			for index, playerPos in pairs(self.playerPositions) do
				if (playerPos) then
					if (playerPos.position) then
		
						if (playerPos.player == self.playerClass.player) then
							self.playerClass.position = playerPos.position
						end

						local offSetX = string.sub(playerPos.position, 1, 2)
						local offSetY = string.sub(playerPos.position, 3, 4)

						if (offSetX) and (offSetY) then
							local x = self.startX + self.mapTileSize * (tonumber(offSetX) - 1)
							local y = self.startY + self.mapTileSize * (tonumber(offSetY) - 1)
							
							dxDrawRectangle(x, y, self.mapTileSize, self.mapTileSize, tocolor(0, 255, 0, 255))
						end
					end
				end
			end
			
		dxSetRenderTarget()
	end
end


function PlayerManagerC:refreshPlayerPositions(playerPositions)
	if (playerPositions) then
		self.playerPositions = playerPositions
	end
end


function PlayerManagerC:getPlayerRender()
	return self.renderTarget
end


function PlayerManagerC:destructor()

	removeEventHandler("BM2DREFRESHPLAYERPOSITIONS", root, self.m_RefreshPlayerPositions)

	if (self.playerClass) then
		delete(self.playerClass)
		self.playerClass = nil
	end
	
	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	mainOutput("PlayerManagerC was deleted.")
end
