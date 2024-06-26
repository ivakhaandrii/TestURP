Shader "Andrii/Test1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        // _Specular ("Specular", Range(0.0, 1.1)) = 0.3
        // _Factor ("Color Factor", Float) = 0.3
        // _Cid ("Color id", Int) = 2
        // _VPos ("Vertex Position", Vector) = (0, 0, 0, 1)
        // _Reflection ("Reflection", Cube) = "black" {}
        // _3DTexture ("3D Texture", 3D) = "white" {}
        _Color ("Color", Color) = (1, 1, 1, 1)
        //[Toggle] _PropertyName ("Display Name", Float) = 0
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
            // make fog work
            //#pragma multi_compile_fog
            //#include "UnityCG.cginc"
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
                //UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;

            v2f vert (appdata v)
            {
                v2f o;
                // o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertex = TransformObjectToHClip(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // // sample the texture
                // fixed4 col = tex2D(_MainTex, i.uv);
                // // apply fog
                // //UNITY_APPLY_FOG(i.fogCoord, col);
                // return col;
                half4 col = tex2D(_MainTex, i.uv);
                return col * _Color;
            }
            ENDHLSL
        }
    }
}
