﻿Shader "Custom/Cooling"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Speed ("Speed", Range(1, 10)) = 1
		_Color ("Color", Color) = (0, 0, 0, 1)
	}
	SubShader
	{		
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			#define PI 3.142

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{			
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			half _Speed;
			fixed4 _Color;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);

				//以正中间为中心，所以将uv范围映射到(-0.5, 0.5)
				float2 uv = i.uv - float2(0.5, 0.5);
				//atan2(y, x)：反正切，y/x的反正切范围在[-π, π]内
				//-1用于控制方向
				float radian = atan2(uv.y, uv.x) * -1 + PI;

				float2 radian2 = fmod(_Time.y * _Speed, 2 * PI);
				fixed v = step(radian, radian2);

				
				if(v > 0) return col;
				else return col * _Color;


			}
			ENDCG
		}
	}
}
