Shader "Custom/Rain"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Opaque("Opaque",float) = 0.02
    }
    SubShader
    {
        Tags{
            "RenderType" = "Opaque"
            "Queue" = "Transparent"
        }
        LOD 100

        Blend SrcAlpha OneMinusSrcAlpha
        GrabPass{ "GrabTexture" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 vertex:SV_POSITION;
                float2 uv:TEXCOORD0;
                float4 screenuv:TEXCOORD1;
            };

            sampler2D _MainTex;
            sampler2D GrabTexture;
            float4 _MainTex_ST;
            float _Opaque;

            v2f vert(appdata v) {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.screenuv = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                float2 suv = i.screenuv / i.screenuv.w;
                //512和128是测试出来比较正常的魔数。
                //越大则扰动越剧烈。
                float2 distort = float2(sin(suv.x * 512 + _Time.y * 10),sin(suv.y * 128 + _Time.y * 10)) / 128;
                col = _Opaque + tex2D(GrabTexture, suv + distort);
                col.a = tex2D(_MainTex, i.uv).a;
                return col;
            }
            ENDCG
        }
    }
}
