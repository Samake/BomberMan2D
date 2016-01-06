--[[
	Name: BomberMan2D
	Filename: PictureQualityShaderC.lua
	Authors: Sam@ke
--]]

PictureQualityShaderC = {}

function PictureQualityShaderC:constructor(parent)
	mainOutput("PictureQualityShaderC was loaded.")
	
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	self.pictureQualityShader = dxCreateShader("res/shaders/pictureQuality.fx")
	
	self.inputTexture = nil
	
	self.brightness = 1.0
	self.saturation = 2.0
	self.contrast = 1.2
	self.flipRotation = 0
	
	self.isLoaded = self.renderTarget and self.pictureQualityShader
end



function PictureQualityShaderC:update()
	if (self.isLoaded) then
		
		if (self.inputTexture) then
			self.pictureQualityShader:setValue("screenSource", self.inputTexture)
			self.pictureQualityShader:setValue("brightness", self.brightness)
			self.pictureQualityShader:setValue("saturation", self.saturation)
			self.pictureQualityShader:setValue("contrast", self.contrast)
			
			self.pictureQualityShader:setTransform(0, self.flipRotation, 0, 0, 0.5, 0, true, 0, 0, false)
				
			
			dxSetRenderTarget(self.renderTarget, true)
			dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.pictureQualityShader)
			dxSetRenderTarget()
		end
	end
end


function PictureQualityShaderC:setInput(inTex)
	if (inTex) then
		self.inputTexture = inTex
	end
end


function PictureQualityShaderC:setBrightness(brightness)
	if (brightness) then
		self.brightness = brightness
	end
end


function PictureQualityShaderC:setSaturation(saturation)
	if (saturation) then
		self.saturation = saturation
	end
end


function PictureQualityShaderC:setContrast(contrast)
	if (contrast) then
		self.contrast = contrast
	end
end


function PictureQualityShaderC:setFlipRotation(flipRotation)
	if (flipRotation) then
		self.flipRotation = flipRotation
	end
end


function PictureQualityShaderC:getQualityRender()
	return self.renderTarget
end


function PictureQualityShaderC:destructor()

	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	if (self.pictureQualityShader) then
		self.pictureQualityShader:destroy()
		self.pictureQualityShader = nil
	end
	
	mainOutput("PictureQualityShaderC was deleted.")
end
