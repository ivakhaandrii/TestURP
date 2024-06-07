Shader "Andrii/USB_7_1"
{
     Properties
    {
        _Density ("Density", Range(2,50)) = 10 // Lower range for thicker stripes
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
 
            struct v2f
            {
                float4 pos : SV_POSITION;
                float4 screenPos : TEXCOORD0;
            };
 
            float _Density;
 
            v2f vert (float4 pos : POSITION)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(pos);
                o.screenPos = ComputeScreenPos(o.pos); // Use ComputeScreenPos for correct screen coordinates
                return o;
            }
            
            fixed4 frag (v2f i) : SV_Target
            {
                // Use the y coordinate from screen space for horizontal stripes
                float2 screenUV = i.screenPos.xy / i.screenPos.w; // Normalize screen coordinates
                float stripe = step(0.5, frac(screenUV.y * _Density));
                return fixed4(stripe, stripe, stripe, 1.0); // Return grayscale stripe pattern
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}