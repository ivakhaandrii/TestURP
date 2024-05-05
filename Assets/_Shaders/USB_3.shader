Shader "Andrii/USB_3"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Tint", Color) = (1, 1, 1 , 1)
    }
    SubShader
    {
        Tags 
        { 
            "RenderType"="Transparent"
            "Queue"="Transparent"
            "RenderPipeline"="UniversalRenderPipeline" 
        }
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog
            //#include "UnityCG.cginc"
            #include "HLSLSupport.cginc"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct appdata
            {
                float4 vertPos : POSITION;
                float2 texCoord : TEXCOORD0;
                float3 normal : NORMAL0;
                float3 tangent : TANGENT0;
                float3 vertColor: COLOR0;
            };

            struct v2f
            {
                float4 vertPos : SV_POSITION;
                float2 texCoord : TEXCOORD0;
                float3 tangentWorld : TEXCOORD1;
                float3 binormalWorld : TEXCOORD2;
                float3 normalWorld : TEXCOORD3;
                float3 vertColor: COLOR0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;

            half3 FakeLight_float (float3 Normal)
            {
                float3 operation = Normal;
                return operation;
            }

            v2f vert (appdata v)
            {
                v2f o;
                // o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertPos = TransformObjectToHClip(v.vertPos);
                o.texCoord = TRANSFORM_TEX(v.texCoord, _MainTex);
                //UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // half4 col = tex2D(_MainTex, i.uv);
                // return col * _Color;

                // declare normals
                float3 n = i.normalWorld;
                float3 col = FakeLight_float (n);
                return float4(col.rgb, 1);

            }


            ENDHLSL
        }
    }
    Fallback "Andrii/USB_simple_color_URP"
}
