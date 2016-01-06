--[[
	Name: BomberMan2D
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
	
	if (not self.pictureQualityShader) then
		self.pictureQualityShader = new(PictureQualityShaderC, self)
	end
end


function ShaderManagerC:update()
	if (self.skyShader) then
		self.skyShader:update()
	end
	
	if (self.pictureQualityShader) then
		self.pictureQualityShader:update()
	end
end


function ShaderManagerC:clear()
	if (self.skyShader) then
		delete(self.skyShader)
		self.skyShader = nil
	end
	
	if (self.pictureQualityShader) then
		delete(self.pictureQualityShader)
		self.pictureQualityShader = nil
	end
end


function ShaderManagerC:destructor()

	self:clear()
	
	mainOutput("ShaderManagerC was deleted.")
end
