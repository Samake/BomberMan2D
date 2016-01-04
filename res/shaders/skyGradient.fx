
float4 skyColor = float4(0, 0, 0, 1);

float4 PixelShaderFunction(float2 texCoords : TEXCOORD) : COLOR
{	
	float4 finalColor = lerp(float4(skyColor.rgb * 0.3, 1), float4(skyColor.rgb, 1), texCoords.y);
	
	return finalColor;
}


technique SkyGradient
{
    pass Pass0
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}