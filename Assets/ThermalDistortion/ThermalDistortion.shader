Shader "Custom/ThermalDistortion"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MaskTex ("Mask Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha
		ZWrite Off

		GrabPass {}

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{			
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvGrab : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _MaskTex;
			sampler2D _GrabTexture;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				//简单来说，TRANSFORM_TEX主要作用是拿顶点的uv去和材质球的tiling和offset作运算，确保材质球里的缩放和偏移设置是正确的。
				o.uv = TRANSFORM_TEX(v.uv, _MainTex); 
				o.uvGrab = ComputeGrabScreenPos(o.vertex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 mainCol = tex2D(_MainTex, i.uv);
				fixed4 maskCol = tex2D(_MaskTex, i.uv);

				fixed4 grabCol = tex2D(_GrabTexture, i.uvGrab);
				fixed4 grabColOffset = tex2D(_GrabTexture, i.uvGrab + float2(sin(_Time.y) * 0.01, sin(_Time.y) * 0.01));

				//使用遮罩
				if(mainCol.a > 0) return mainCol;
				else if(maskCol.a > 0) return grabColOffset;
				else return grabCol;

				//不使用遮罩
				//if(mainCol.a > 0) return mainCol;
				//else return grabColOffset;
			}
			ENDCG
		}
	}
}
