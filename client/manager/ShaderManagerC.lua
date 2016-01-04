--[[
	Name: 2DJAR
	Filename: ShaderManagerC.lua
	Authors: Sam@ke
--]]

ShaderManagerC = {}

function ShaderManagerC:constructor(parent)
	mainOutput("ShaderManagerC was loaded.")
	
	self.mainClass = parent
	
	self:init()
end


function ShaderManagerC:init()
	if (not self.skyShader) then
		self.skyShader = new(SkyShaderC, self)
	end
end


function ShaderManagerC:update()
	if (self.skyShader) then
		self.skyShader:update()
	end
end


function ShaderManagerC:clear()
	if (self.skyShader) then
		delete(self.skyShader)
		self.skyShader = nil
	end
end


function ShaderManagerC:destructor()

	self:clear()
	
	mainOutput("ShaderManagerC was deleted.")
end
