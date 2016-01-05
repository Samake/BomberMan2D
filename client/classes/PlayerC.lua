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
	
	mainOutput("PlayerC was loaded.")
end


function PlayerC:setPlayerDetails(playerSettings)
	if (playerSettings) then
		self.id = playerSettings.id
		self.position = playerSettings.position
	end
end


function PlayerC:update()
	--outputChatBox("Pos: " .. tostring(self.position))
end


function PlayerC:walkUp()
	if (self.position) then
		local offSetX = string.sub(self.position, 1, 2)
		local offSetY = string.sub(self.position, 3, 4)
		
		if (offSetX) and (offSetY) then
			local newPos = string.format("%02d", offSetX) .. string.format("%02d", tonumber(offSetY) - 1)
		
			triggerServerEvent("BM2DMOVEPLAYER", self.player, newPos)
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
		end
	end
end


function PlayerC:destructor()

	removeEventHandler("BM2DSETPLAYERDETAILS", root, self.m_SetPlayerDetails)
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
