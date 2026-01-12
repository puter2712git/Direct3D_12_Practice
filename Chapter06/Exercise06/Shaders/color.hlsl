cbuffer cbPerObject : register(b0)
{
    float4x4 gWorldViewProj;
    float gTime;
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

VertexOut VS(VertexIn vin)
{
    VertexOut vout;
    
    vin.Pos.xy += 0.5f * sin(vin.Pos.x) * sin(3.0f * gTime);
    vin.Pos.z *= 0.6f + 0.4f * sin(2.0f * gTime);
    
    vout.PosH = mul(float4(vin.Pos, 1.0f), gWorldViewProj);
    
    vout.Color = vin.Color;
    
    return vout;
}

float4 PS(VertexOut pin) : SV_Target
{
    return pin.Color;
}