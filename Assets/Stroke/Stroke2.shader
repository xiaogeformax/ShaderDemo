Shader "Custom/Stroke2" {
	Properties{
		_OutlineWidth("OutLineWidth",float) = 0.005
		_OutlineColor("OutlineColor",Color) = (1,0,0,1)
		_Color ("Main Color", Color) = (.5,.5,.5,1)  
		_MainTex ("Base (RGB)", 2D) = "white" { } 
	}
SubShader  
{         
    Tags { "Queue" = "Geometry" "RenderType" = "Opaque"}          
    LOD 200   
  

    Pass  
    {  
        Cull Off  
        ZWrite Off  
          
        CGPROGRAM  
  
            #include "UnityCG.cginc"  
            #pragma vertex vert  
            #pragma fragment frag  
  
            half _OutlineWidth;  
            fixed4 _OutlineColor;  
  
            struct v2f  
            {  
                float4 pos:SV_POSITION;  
            };  
  
            v2f vert(appdata_base IN)  
            {  
                V2F o;  
  
                IN.vertex.xyz += IN.normal * _OutlineWidth;  
                o.pos = mul(UNITY_MATRIX_MVP, IN.vertex);  
                return o;  
            }  
  
            fixed4 frag(V2F IN):COLOR  
            {  
                return _OutlineColor;  
            }   

        ENDCG  
    }     
  /*
    SubShader 
    {

    }*/
}
}
