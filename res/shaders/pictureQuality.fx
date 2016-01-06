
texture screenSource;
float brightness = 1.0;
float saturation = 1.0;
float contrast = 1.0;

sampler ScreenSourceSampler = sampler_state
{
    Texture = (screenSource);
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};


float4 PixelShaderFunction(float2 TexCoords : TEXCOORD) : COLOR
{	
	float4 mainColor = tex2D(ScreenSourceSampler, TexCoords);
	mainColor.rgb = ((mainColor.rgb - 0.5f) * max(contrast, 0)) + 0.5f;
	
	float3 luminanceWeights = float3(0.299, 0.587, 0.114);
	float luminance = dot(mainColor, luminanceWeights);
	float4 newColor = lerp(luminance, mainColor, saturation);
	newColor.rgb *= brightness;

	return float4(newColor.rgb, mainColor.a);
}


technique PictureSettings
{
    pass Pass0
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}


// Fallback
technique Fallback
{
    pass P0
    {
        // Just draw normally
    }
}