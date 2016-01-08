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
	
	self.playerTextures = {}
	self.playerTextures["up"] = {}
	self.playerTextures["up"][1] = dxCreateTexture("res/textures/player_U1.png")
	self.playerTextures["up"][2] = dxCreateTexture("res/textures/player_U2.png")
	self.playerTextures["up"][3] = dxCreateTexture("res/textures/player_U3.png")
	self.playerTextures["up"][4] = dxCreateTexture("res/textures/player_U2.png")
	self.playerTextures["up"][5] = dxCreateTexture("res/textures/player_U2.png")
	
	self.playerTextures["down"] = {}
	self.playerTextures["down"][1] = dxCreateTexture("res/textures/player_D1.png")
	self.playerTextures["down"][2] = dxCreateTexture("res/textures/player_D2.png")
	self.playerTextures["down"][3] = dxCreateTexture("res/textures/player_D3.png")
	self.playerTextures["down"][4] = dxCreateTexture("res/textures/player_D2.png")
	self.playerTextures["down"][5] = dxCreateTexture("res/textures/player_D2.png")
	
	self.playerTextures["left"] = {}
	self.playerTextures["left"][1] = dxCreateTexture("res/textures/player_L1.png")
	self.playerTextures["left"][2] = dxCreateTexture("res/textures/player_L2.png")
	self.playerTextures["left"][3] = dxCreateTexture("res/textures/player_L3.png")
	self.playerTextures["left"][4] = dxCreateTexture("res/textures/player_L2.png")
	self.playerTextures["left"][5] = dxCreateTexture("res/textures/player_L2.png")
	
	self.playerTextures["right"] = {}
	self.playerTextures["right"][1] = dxCreateTexture("res/textures/player_R1.png")
	self.playerTextures["right"][2] = dxCreateTexture("res/textures/player_R2.png")
	self.playerTextures["right"][3] = dxCreateTexture("res/textures/player_R3.png")
	self.playerTextures["right"][4] = dxCreateTexture("res/textures/player_R2.png")
	self.playerTextures["right"][5] = dxCreateTexture("res/textures/player_R2.png")
	
	self.playerMaskTextures = {}
	self.playerMaskTextures["up"] = {}
	self.playerMaskTextures["up"][1] = dxCreateTexture("res/textures/player_U1_Mask.png")
	self.playerMaskTextures["up"][2] = dxCreateTexture("res/textures/player_U2_Mask.png")
	self.playerMaskTextures["up"][3] = dxCreateTexture("res/textures/player_U3_Mask.png")
	self.playerMaskTextures["up"][4] = dxCreateTexture("res/textures/player_U2_Mask.png")
	self.playerMaskTextures["up"][5] = dxCreateTexture("res/textures/player_U2_Mask.png")
	
	self.playerMaskTextures["down"] = {}
	self.playerMaskTextures["down"][1] = dxCreateTexture("res/textures/player_D1_Mask.png")
	self.playerMaskTextures["down"][2] = dxCreateTexture("res/textures/player_D2_Mask.png")
	self.playerMaskTextures["down"][3] = dxCreateTexture("res/textures/player_D3_Mask.png")
	self.playerMaskTextures["down"][4] = dxCreateTexture("res/textures/player_D2_Mask.png")
	self.playerMaskTextures["down"][5] = dxCreateTexture("res/textures/player_D2_Mask.png")
	
	self.playerMaskTextures["left"] = {}
	self.playerMaskTextures["left"][1] = dxCreateTexture("res/textures/player_L1_Mask.png")
	self.playerMaskTextures["left"][2] = dxCreateTexture("res/textures/player_L2_Mask.png")
	self.playerMaskTextures["left"][3] = dxCreateTexture("res/textures/player_L3_Mask.png")
	self.playerMaskTextures["left"][4] = dxCreateTexture("res/textures/player_L2_Mask.png")
	self.playerMaskTextures["left"][5] = dxCreateTexture("res/textures/player_L2_Mask.png")
	
	self.playerMaskTextures["right"] = {}
	self.playerMaskTextures["right"][1] = dxCreateTexture("res/textures/player_R1_Mask.png")
	self.playerMaskTextures["right"][2] = dxCreateTexture("res/textures/player_R2_Mask.png")
	self.playerMaskTextures["right"][3] = dxCreateTexture("res/textures/player_R3_Mask.png")
	self.playerMaskTextures["right"][4] = dxCreateTexture("res/textures/player_R2_Mask.png")
	self.playerMaskTextures["right"][5] = dxCreateTexture("res/textures/player_R2_Mask.png")
	
	self.currentTextureStack = 1
	self.postGUI = false
	
	self.m_RefreshPlayerPositions = bind(self.refreshPlayerPositions, self)
	addEvent("BM2DREFRESHPLAYERPOSITIONS", true)
	addEventHandler("BM2DREFRESHPLAYERPOSITIONS", root, self.m_RefreshPlayerPositions)
	
	self.m_UpdateSlowly = bind(self.updateSlowly, self)
	self.slowUpdateDelta = 200
	self.updateTimer = setTimer(self.m_UpdateSlowly, self.slowUpdateDelta, 0)
end


function PlayerManagerC:updateSlowly()
	self.currentTextureStack = self.currentTextureStack + 1
	
	if (self.currentTextureStack > 4) then
		self.currentTextureStack = 1
	end
end



function PlayerManagerC:update()
	if (self.renderTarget) and (self.playerClass) and (self.mainClass.mapManager) then
		
		self.playerClass:update()
		
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

							
							local direction = getLocalPlayer():getData("BM2DDirection", self.direction)
							local isWalking = playerPos.player:getData("BM2DIsWalking", self.isWalking)
							local color = self.playerClass.color or {r = 255, g = 255, b = 255}
							
							if (self.playerTextures[direction]) and ((self.playerMaskTextures[direction])) then
								if (isWalking == "true") then
									if (self.playerTextures[direction][self.currentTextureStack]) and (self.playerMaskTextures[direction][self.currentTextureStack]) then
										dxDrawImage(x, y - self.mapTileSize, self.mapTileSize, self.mapTileSize * 2, self.playerTextures[direction][self.currentTextureStack], 0, 0, 0, tocolor(255, 255, 255, 255), self.postGUI)
										dxDrawImage(x, y - self.mapTileSize, self.mapTileSize, self.mapTileSize * 2, self.playerMaskTextures[direction][self.currentTextureStack], 0, 0, 0, tocolor(color.r, color.g, color.b, 255), self.postGUI)
									end
								else
									if (self.playerTextures[direction][5]) and (self.playerMaskTextures[direction][5]) then
										dxDrawImage(x, y - self.mapTileSize, self.mapTileSize, self.mapTileSize * 2, self.playerTextures[direction][5], 0, 0, 0, tocolor(255, 255, 255, 255), self.postGUI)
										dxDrawImage(x, y - self.mapTileSize, self.mapTileSize, self.mapTileSize * 2, self.playerMaskTextures[direction][5], 0, 0, 0, tocolor(color.r, color.g, color.b, 255), self.postGUI)
									end
								end
							else
								dxDrawRectangle(x, y, self.mapTileSize, self.mapTileSize, tocolor(0, 255, 0, 255))
							end

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
	
	if (self.updateTimer) then
		self.updateTimer:destroy()
		self.updateTimer = nil
	end
	
	for index, textureStack in pairs(self.playerTextures) do
		for _, texture in pairs(textureStack) do
			if (texture) then
				texture:destroy()
				texture = nil
			end
		end
	end
	
	for index, textureStack in pairs(self.playerMaskTextures) do
		for _, texture in pairs(textureStack) do
			if (texture) then
				texture:destroy()
				texture = nil
			end
		end
	end

	mainOutput("PlayerManagerC was deleted.")
end
