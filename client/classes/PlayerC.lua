--[[
	Name: BomberMan2D
	Filename: PlayerC.lua
	Authors: Sam@ke
--]]

PlayerC = {}

function PlayerC:constructor(parent)

	self.playerManager = parent
	
	self.player = getLocalPlayer()
	self.id = nil
	self.position = nil
	
	self.postGUI = false
	self.subPixelPositioning = false

	self.m_SetPlayerDetails = bind(self.setPlayerDetails, self)
	addEvent("BM2DSETPLAYERDETAILS", true)
	addEventHandler("BM2DSETPLAYERDETAILS", root, self.m_SetPlayerDetails)
	
	self.m_PlaceBomb = bind(self.placeBomb, self)
	bindKey("space", "down", self.m_PlaceBomb)
	
	self.m_WalkUp = bind(self.walkUp, self)
	bindKey("W", "down", self.m_WalkUp)
	bindKey("arrow_u", "down", self.m_WalkUp)
	
	self.m_WalkDown = bind(self.walkDown, self)
	bindKey("S", "down", self.m_WalkDown)
	bindKey("arrow_d", "down", self.m_WalkDown)
	
	self.m_WalkLeft = bind(self.walkLeft, self)
	bindKey("A", "down", self.m_WalkLeft)
	bindKey("arrow_l", "down", self.m_WalkLeft)
	
	self.m_WalkRight = bind(self.walkRight, self)
	bindKey("D", "down", self.m_WalkRight)
	bindKey("arrow_r", "down", self.m_WalkRight)
	
	self.direction = "down"
	self.isWalking = "false"
	
	mainOutput("PlayerC was loaded.")
end


function PlayerC:setPlayerDetails(playerSettings)
	if (playerSettings) then
		self.id = playerSettings.id
		self.position = playerSettings.position
		self.color = playerSettings.color
	end
end


function PlayerC:update()
	if (getKeyState("W") == true) or (getKeyState("arrow_u") == true) or (getKeyState("S") == true) or (getKeyState("arrow_d") == true) or (getKeyState("A") == true) or (getKeyState("arrow_l") == true) or (getKeyState("D") == true) or (getKeyState("arrow_r") == true) then
		self.isWalking = "true"
	else
		self.isWalking = "false"
	end
	
	self.player:setData("BM2DDirection", self.direction, true)
	self.player:setData("BM2DIsWalking", self.isWalking, true)
end


function PlayerC:placeBomb()
	triggerServerEvent("BM2DPLACEBOMB", self.player, self.position)
end


function PlayerC:walkUp()
	if (self.position) then
		local offSetX = string.sub(self.position, 1, 2)
		local offSetY = string.sub(self.position, 3, 4)
		
		if (offSetX) and (offSetY) then
			local newPos = string.format("%02d", offSetX) .. string.format("%02d", tonumber(offSetY) - 1)
		
			triggerServerEvent("BM2DMOVEPLAYER", self.player, newPos)
			
			self.direction = "up"
		end
	end
end


function PlayerC:walkDown()
	if (self.position) then
		local offSetX = string.sub(self.position, 1, 2)
		local offSetY = string.sub(self.position, 3, 4)
		
		if (offSetX) and (offSetY) then
			local newPos = string.format("%02d", offSetX) .. string.format("%02d", tonumber(offSetY) + 1)
		
			triggerServerEvent("BM2DMOVEPLAYER", self.player, newPos)
			
			self.direction = "down"
		end
	end
end


function PlayerC:walkLeft()
	if (self.position) then
		local offSetX = string.sub(self.position, 1, 2)
		local offSetY = string.sub(self.position, 3, 4)
		
		if (offSetX) and (offSetY) then
			local newPos = string.format("%02d", tonumber(offSetX) - 1) .. string.format("%02d", offSetY)
		
			triggerServerEvent("BM2DMOVEPLAYER", self.player, newPos)
			
			self.direction = "left"
		end
	end
end


function PlayerC:walkRight()
	if (self.position) then
		local offSetX = string.sub(self.position, 1, 2)
		local offSetY = string.sub(self.position, 3, 4)
		
		if (offSetX) and (offSetY) then
			local newPos = string.format("%02d", tonumber(offSetX) + 1) .. string.format("%02d", offSetY)
		
			triggerServerEvent("BM2DMOVEPLAYER", self.player, newPos)
			
			self.direction = "right"
		end
	end
end


function PlayerC:destructor()

	removeEventHandler("BM2DSETPLAYERDETAILS", root, self.m_SetPlayerDetails)
	unbindKey("space", "down", self.m_PlaceBomb)
	unbindKey("W", "down", self.m_WalkUp)
	unbindKey("arrow_u", "down", self.m_WalkUp)
	unbindKey("S", "down", self.m_WalkDown)
	unbindKey("arrow_d", "down", self.m_WalkDown)
	unbindKey("A", "down", self.m_WalkLeft)
	unbindKey("arrow_l", "down", self.m_WalkLeft)
	unbindKey("D", "down", self.m_WalkRight)
	unbindKey("arrow_r", "down", self.m_WalkRight)

	mainOutput("PlayerC was deleted.")
end
