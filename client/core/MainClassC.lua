--[[
	Name: BomberMan2D
	Filename: MainClassC.lua
	Authors: Sam@ke
--]]

local Instance = nil

MainClassC = {}

function MainClassC:constructor()
	mainOutput("MainClassC was loaded.")
	
	setDevelopmentMode(true, false)
	setCameraMatrix(0, 0, 100, 0, 0, 200)
	
	self.hour = 0
	self.minute = 0
	
	self.m_Update = bind(self.update, self)
	addEventHandler("onClientPreRender", root, self.m_Update)
	
	self:init()
end


function MainClassC:init()
	if (not self.shaderManager) then
		self.shaderManager = new(ShaderManagerC, self)
	end
	
	if (not self.mapManager) then
		self.mapManager = new(MapManagerC, self)
	end
	
	if (not self.playerManager) then
		self.playerManager = new(PlayerManagerC, self)
	end
	
	if (not self.renderClass) then
		self.renderClass = new(RenderClassC, self)
	end
end


function MainClassC:update()
	setPlayerHudComponentVisible("all", false)

	if (self.shaderManager) then
		self.shaderManager:update()
	end
	
	if (self.mapManager) then
		self.mapManager:update()
	end
	
	if (self.playerManager) then
		self.playerManager:update()
	end
	
	if (self.renderClass) then
		self.renderClass:update()
	end
end


function MainClassC:clear()
	if (self.shaderManager) then
		delete(self.shaderManager)
		self.shaderManager = nil
	end
	
	if (self.mapManager) then
		delete(self.mapManager)
		self.mapManager = nil
	end
	
	if (self.playerManager) then
		delete(self.playerManager)
		self.playerManager = nil
	end
	
	if (self.renderClass) then
		delete(self.renderClass)
		self.renderClass = nil
	end
end


function MainClassC:destructor()
	removeEventHandler("onClientPreRender", root, self.m_Update)
	
	self:clear()
	
	setPlayerHudComponentVisible("all", true)
	setDevelopmentMode(false, false)
	setCameraTarget(getLocalPlayer())
	
	mainOutput("MainClassC was deleted.")
end


addEventHandler("onClientResourceStart", resourceRoot,
function()
	Instance = new(MainClassC)
end)


addEventHandler("onClientResourceStop", resourceRoot,
function()
	if (Instance) then
		delete(Instance)
		Instance = nil
	end
end)