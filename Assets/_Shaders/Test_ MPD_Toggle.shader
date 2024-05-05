Shader "Andrii/Test_MPD_Toggle"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        //_Color ("Color", Color) = (1, 1, 1, 1)
        [KeywordEnum(StateOff, State01, etc...)] _PropertyName ("Display name", Float) = 0
    }
    SubShader
    {
        Tags 
        { 
            "RenderType"="Transparent"
            "Queue"="Transparent"
            "RenderPipeline"="UniversalRenderPipeline" 
        }
        LOD 100

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //#pragma shader_feature _ENABLE_ON
            #pragma multi_compile _OPTIONS_OFF _OPTIONS_RED _OPTIONS_BLUE
            #include "HLSLSupport.cginc"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            //float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = TransformObjectToHClip(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 col = tex2D(_MainTex, i.uv);
#if _OPTIONS_OFF
                return col;
#elif _OPTIONS_RED
                return col * float4(1, 0, 0, 1);
#elif _OPTIONS_BLUE
                return col * float4(0, 0, 1, 1);
#endif
            }
            ENDHLSL
        }
    }
}
