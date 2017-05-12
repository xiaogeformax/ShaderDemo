Shader "Custom/AlphaBlend"
{
	Properties
	{
		_RGB ("颜色", Color) = (1, 0, 0, 1)
		_Alpha ("透明度", Range(0, 1)) = 0.5
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{			
				float4 vertex : SV_POSITION;
			};

			fixed4 _RGB;
			fixed _Alpha;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                return fixed4(_RGB.rgb, _Alpha);
			}
			ENDCG
		}
	}
}
