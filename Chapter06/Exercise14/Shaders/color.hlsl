cbuffer cbPerObject : register(b0)
{
    float4x4 gWorldViewProj;
    float gTotalTime;
};

struct VertexIn
{
    float3 Pos : POSITION;
    float4 Color : COLOR;
};

struct VertexOut
{
    float4 PosH : SV_POSITION;
    float4 Color : COLOR;
};

float EaseInOutCubic(float t)
{
    return t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2;
}

VertexOut VS(VertexIn vin)
{
    VertexOut vout;
    
    vout.PosH = mul(float4(vin.Pos, 1.0f), gWorldViewProj);
    
    vout.Color = vin.Color;
    
    return vout;
}

float4 PS(VertexOut pin) : SV_Target
{
    float t = sin(gTotalTime + pin.Color.g) * 0.5f + 0.5f;
    float easedT = EaseInOutCubic(t);
    
    return lerp(pin.Color, float4(1, 1, 1, 1), easedT);

}