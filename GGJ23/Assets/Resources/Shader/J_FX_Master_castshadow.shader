// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FX/J_FX_Master_castshadow"
{
	Properties
	{
		[HDR]_Tint("Tint", Color) = (1,1,1,0)
		[Enum(Blended,10,Additive,1)]_Blend_Mode("Blend_Mode", Float) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_MainPannerXY("Main  Panner X/Y", Vector) = (0,0,0,0)
		_MainRotationAmount("Main Rotation Amount", Float) = 0
		[Toggle]_UseCustomData("Use Custom Data", Float) = 1
		_DistortTex("DistortTex", 2D) = "white" {}
		_DistortPannerXY("Distort Panner X/Y", Vector) = (0,0,0,0)
		_DistortPowerXY("Distort Power X/Y", Vector) = (0,0,0,0)
		_DistortRotationAmount("Distort Rotation Amount", Float) = 0
		[Enum(Step,0,Smooth,1)]_DissolveType("Dissolve Type", Float) = 0
		_DissolveTex("DissolveTex", 2D) = "white" {}
		_DissolvePannerXY("DissolvePanner X/Y", Vector) = (0,0,0,0)
		_DissolveRotationAmount("Dissolve Rotation Amount", Float) = 0
		_DissolveOffset("Dissolve Offset", Range( 0 , 1)) = 0
		_BrightnessOffset("Brightness Offset", Range( 0 , 1)) = 0
		[HDR]_BrightnessColor("Brightness Color", Color) = (0.5019608,0.5019608,0.5019608,0)
		[Enum(Multiply,0,Add,1)]_SubMode("Sub Mode", Float) = 0
		[Enum(UV,0,Screen,1)]_SubType("Sub Type", Float) = 0
		_SubTex("SubTex", 2D) = "white" {}
		_SubPannerXY("Sub Panner X/Y", Vector) = (0,0,0,0)
		_SubRotationAmount("Sub Rotation Amount", Float) = 0
		_SubScaleAmount("Sub Scale Amount", Vector) = (1,1,0,0)
		[HDR]_SubColor("Sub Color", Color) = (1,1,1,0)
		_MaskTex("MaskTex", 2D) = "white" {}
		_MaskPannerXY("Mask Panner X/Y", Vector) = (0,0,0,0)
		_MaskRotationAmount("Mask Rotation Amount", Float) = 0
		[Toggle]_UseBackfaceColor("Use Backface Color", Float) = 0
		[Enum(Back,0,Front,1)]_BackfaceType("Backface Type", Float) = 0
		[HDR]_BackfaceColor("Backface Color", Color) = (1,1,1,0)
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord3( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite Off
		ZTest LEqual
		Blend SrcAlpha [_Blend_Mode] , SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.5
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 uv3_texcoord3;
			float2 uv_texcoord;
			float4 uv2_texcoord2;
			float4 screenPos;
			float4 vertexColor : COLOR;
			half ASEVFace : VFACE;
		};

		uniform float _Blend_Mode;
		uniform float _DissolveType;
		uniform sampler2D _DissolveTex;
		uniform float2 _DissolvePannerXY;
		uniform float _UseCustomData;
		uniform float4 _DissolveTex_ST;
		uniform float _DissolveRotationAmount;
		uniform float _DissolveOffset;
		uniform sampler2D _MainTex;
		uniform float2 _MainPannerXY;
		uniform float4 _MainTex_ST;
		uniform float _MainRotationAmount;
		uniform float2 _DistortPowerXY;
		uniform sampler2D _DistortTex;
		uniform float2 _DistortPannerXY;
		uniform float4 _DistortTex_ST;
		uniform float _DistortRotationAmount;
		uniform float4 _BrightnessColor;
		uniform float _UseBackfaceColor;
		uniform sampler2D _SubTex;
		uniform float2 _SubPannerXY;
		uniform float _SubType;
		uniform float2 _SubScaleAmount;
		uniform float4 _SubTex_ST;
		uniform float _SubRotationAmount;
		uniform float4 _Tint;
		uniform float4 _SubColor;
		uniform float _SubMode;
		uniform float4 _BackfaceColor;
		uniform float _BackfaceType;
		uniform float _BrightnessOffset;
		uniform sampler2D _MaskTex;
		uniform float2 _MaskPannerXY;
		uniform float4 _MaskTex_ST;
		uniform float _MaskRotationAmount;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 temp_cast_0 = (0.0).xxxx;
			half UseCustom81 = (( _UseCustomData )?( 1.0 ):( 0.0 ));
			float4 lerpResult279 = lerp( temp_cast_0 , i.uv3_texcoord3 , UseCustom81);
			float4 break282 = lerpResult279;
			float4 _Custom2 = float4(0,0,0,0);
			float Custom2w263 = ( break282.w + _Custom2.w );
			float2 uv_DissolveTex = i.uv_texcoord * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
			float Custom2z262 = ( break282.z + _Custom2.z );
			float cos284 = cos( ( _DissolveRotationAmount + Custom2z262 ) );
			float sin284 = sin( ( _DissolveRotationAmount + Custom2z262 ) );
			float2 rotator284 = mul( uv_DissolveTex - float2( 0.5,0.5 ) , float2x2( cos284 , -sin284 , sin284 , cos284 )) + float2( 0.5,0.5 );
			float2 panner172 = ( 1.0 * _Time.y * ( _DissolvePannerXY * ( Custom2w263 + 1.0 ) ) + rotator284);
			float4 tex2DNode170 = tex2D( _DissolveTex, panner172 );
			float4 temp_cast_1 = (0.0).xxxx;
			float4 lerpResult80 = lerp( temp_cast_1 , i.uv2_texcoord2 , UseCustom81);
			float4 break77 = lerpResult80;
			float4 _Custom1 = float4(0,0,0,0);
			float Custom1w67 = ( break77.w + _Custom1.w + _DissolveOffset );
			float temp_output_254_0 = ( (-1.0 + (Custom1w67 - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * -1.0 );
			float temp_output_184_0 = ( tex2DNode170.r + temp_output_254_0 );
			float clampResult253 = clamp( temp_output_184_0 , 0.0 , 1.0 );
			float temp_output_186_0 = (-0.1 + (Custom1w67 - 0.0) * (1.0 - -0.1) / (1.0 - 0.0));
			float temp_output_178_0 = step( tex2DNode170.r , temp_output_186_0 );
			float clampResult206 = clamp( ( 1.0 - temp_output_178_0 ) , 0.0 , 1.0 );
			float ifLocalVar237 = 0;
			if( _DissolveType <= 0.0 )
				ifLocalVar237 = clampResult206;
			else
				ifLocalVar237 = clampResult253;
			float Custom1x64 = ( break77.x + _Custom1.x );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float cos165 = cos( _MainRotationAmount );
			float sin165 = sin( _MainRotationAmount );
			float2 rotator165 = mul( uv_MainTex - float2( 0.5,0.51 ) , float2x2( cos165 , -sin165 , sin165 , cos165 )) + float2( 0.5,0.51 );
			float2 panner21 = ( 1.0 * _Time.y * _MainPannerXY + rotator165);
			float2 break63 = panner21;
			float temp_output_69_0 = ( Custom1x64 + break63.x );
			float Custom1y65 = ( break77.y + _Custom1.y );
			float temp_output_71_0 = ( break63.y + Custom1y65 );
			float2 appendResult72 = (float2(temp_output_69_0 , temp_output_71_0));
			float2 break29 = appendResult72;
			float2 uv_DistortTex = i.uv_texcoord * _DistortTex_ST.xy + _DistortTex_ST.zw;
			float Custom2x260 = ( break282.x + _Custom2.x );
			float cos145 = cos( ( _DistortRotationAmount + Custom2x260 ) );
			float sin145 = sin( ( _DistortRotationAmount + Custom2x260 ) );
			float2 rotator145 = mul( uv_DistortTex - float2( 0.5,0.5 ) , float2x2( cos145 , -sin145 , sin145 , cos145 )) + float2( 0.5,0.5 );
			float2 panner149 = ( 1.0 * _Time.y * _DistortPannerXY + (rotator145*1.0 + 0.0));
			float temp_output_31_0 = (-1.0 + (tex2D( _DistortTex, panner149 ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0));
			float Custom2y261 = ( break282.y + _Custom2.y );
			float temp_output_264_0 = ( Custom2y261 + 1.0 );
			float2 appendResult36 = (float2(( break29.x + ( _DistortPowerXY.x * temp_output_31_0 * temp_output_264_0 ) ) , ( break29.y + ( temp_output_31_0 * _DistortPowerXY.y * temp_output_264_0 ) )));
			float4 tex2DNode2 = tex2D( _MainTex, appendResult36 );
			float DistortTerm235 = tex2DNode2.r;
			float temp_output_240_0 = ( ifLocalVar237 * DistortTerm235 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 appendResult307 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
			float2 uv_SubTex = i.uv_texcoord * _SubTex_ST.xy + _SubTex_ST.zw;
			float2 temp_output_330_0 = ( uv_SubTex * _SubScaleAmount );
			float2 ifLocalVar322 = 0;
			if( _SubType <= 0.0 )
				ifLocalVar322 = temp_output_330_0;
			else
				ifLocalVar322 = ( appendResult307 * _SubScaleAmount );
			float cos301 = cos( _SubRotationAmount );
			float sin301 = sin( _SubRotationAmount );
			float2 rotator301 = mul( ifLocalVar322 - float2( 0.5,0.5 ) , float2x2( cos301 , -sin301 , sin301 , cos301 )) + float2( 0.5,0.5 );
			float2 panner297 = ( 1.0 * _Time.y * _SubPannerXY + rotator301);
			float4 tex2DNode296 = tex2D( _SubTex, panner297 );
			float4 temp_output_108_0 = ( i.vertexColor * _Tint * DistortTerm235 );
			float4 temp_cast_2 = (1.0).xxxx;
			float4 lerpResult378 = lerp( temp_cast_2 , ( ( tex2DNode296 * _SubColor ) + float4( 0,0,0,0 ) ) , _SubMode);
			float4 subcolor386 = _SubColor;
			float4 lerpResult372 = lerp( ( tex2DNode296 * temp_output_108_0 * lerpResult378 * subcolor386 ) , ( temp_output_108_0 + lerpResult378 ) , _SubMode);
			float4 MainTerm277 = lerpResult372;
			float switchResult344 = (((i.ASEVFace>0)?(1.0):(0.0)));
			float switchResult358 = (((i.ASEVFace>0)?(0.0):(1.0)));
			float ifLocalVar361 = 0;
			if( _BackfaceType <= 0.0 )
				ifLocalVar361 = switchResult358;
			else
				ifLocalVar361 = switchResult344;
			float4 lerpResult360 = lerp( MainTerm277 , _BackfaceColor , ifLocalVar361);
			float4 backterm363 = (( _UseBackfaceColor )?( lerpResult360 ):( MainTerm277 ));
			float Custom1z66 = ( break77.z + _Custom1.z + _BrightnessOffset );
			float clampResult232 = clamp( ( ( 1.0 - temp_output_184_0 ) - ( tex2DNode170.r + ( temp_output_254_0 + (-0.3 + (( 1.0 - Custom1z66 ) - 0.0) * (1.0 - -0.3) / (1.0 - 0.0)) ) ) ) , 0.0 , 1.0 );
			float ifLocalVar249 = 0;
			if( Custom1z66 <= 0.0 )
				ifLocalVar249 = 1.0;
			else
				ifLocalVar249 = pow( ( 1.0 - clampResult232 ) , 2.0 );
			float clampResult207 = clamp( ( 1.0 - ( step( tex2DNode170.r , ( temp_output_186_0 + (0.0 + (Custom1z66 - 0.0) * (0.1 - 0.0) / (1.0 - 0.0)) ) ) - temp_output_178_0 ) ) , 0.0 , 1.0 );
			float ifLocalVar238 = 0;
			if( _DissolveType <= 0.0 )
				ifLocalVar238 = clampResult207;
			else
				ifLocalVar238 = ifLocalVar249;
			float4 lerpResult239 = lerp( ( temp_output_240_0 * _BrightnessColor ) , backterm363 , ifLocalVar238);
			o.Emission = lerpResult239.rgb;
			float DissolveTerm271 = temp_output_240_0;
			float2 uv_MaskTex = i.uv_texcoord * _MaskTex_ST.xy + _MaskTex_ST.zw;
			float cos299 = cos( _MaskRotationAmount );
			float sin299 = sin( _MaskRotationAmount );
			float2 rotator299 = mul( uv_MaskTex - float2( 0.5,0.5 ) , float2x2( cos299 , -sin299 , sin299 , cos299 )) + float2( 0.5,0.5 );
			float2 panner174 = ( 1.0 * _Time.y * _MaskPannerXY + rotator299);
			float AlphaTerm275 = ( tex2DNode2.a * i.vertexColor.a * DissolveTerm271 * tex2D( _MaskTex, panner174 ).r );
			o.Alpha = AlphaTerm275;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Unlit keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.5
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 customPack1 : TEXCOORD1;
				float2 customPack2 : TEXCOORD2;
				float4 customPack3 : TEXCOORD3;
				float3 worldPos : TEXCOORD4;
				float4 screenPos : TEXCOORD5;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xyzw = customInputData.uv3_texcoord3;
				o.customPack1.xyzw = v.texcoord2;
				o.customPack2.xy = customInputData.uv_texcoord;
				o.customPack2.xy = v.texcoord;
				o.customPack3.xyzw = customInputData.uv2_texcoord2;
				o.customPack3.xyzw = v.texcoord1;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.screenPos = ComputeScreenPos( o.pos );
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv3_texcoord3 = IN.customPack1.xyzw;
				surfIN.uv_texcoord = IN.customPack2.xy;
				surfIN.uv2_texcoord2 = IN.customPack3.xyzw;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.screenPos = IN.screenPos;
				surfIN.vertexColor = IN.color;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
207.2;116.8;1239.2;535;-1458.464;-3448.165;2.382883;True;True
Node;AmplifyShaderEditor.RangedFloatNode;88;-5752.962,369.1292;Inherit;False;Constant;_Float8;Float 8;6;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-5747.962,213.1291;Inherit;False;Constant;_Float7;Float 7;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;86;-5488.962,213.3264;Inherit;False;Property;_UseCustomData;Use Custom Data;6;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;-5200.553,210.1938;Half;True;UseCustom;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;280;-5593.238,1767.753;Inherit;False;81;UseCustom;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;281;-5700.689,1452.802;Inherit;False;Constant;_Float4;Float 4;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-5851.813,1601.431;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;279;-5293.114,1574.923;Inherit;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;282;-5007.955,1575.736;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.Vector4Node;53;-5012.171,1883.605;Inherit;False;Constant;_Custom2;Custom2;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;55;-4522.192,1575.495;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;260;-4130.361,1559.975;Inherit;False;Custom2x;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;163;-5733.494,-329.3217;Inherit;False;Property;_DistortRotationAmount;Distort Rotation Amount;10;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-4928.232,697.8471;Inherit;False;81;UseCustom;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-4971.982,521.6885;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;266;-5697.69,-187.992;Inherit;False;260;Custom2x;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-4927.338,373.5545;Inherit;False;Constant;_Float2;Float 2;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;147;-5282.073,-523.5496;Inherit;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;162;-5453.494,-322.3217;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;80;-4512.375,491.1354;Inherit;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;54;-4160.162,782.3017;Inherit;False;Constant;_Custom1;Custom1;4;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-4525.278,-1258.605;Inherit;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;166;-4398.895,-1072.475;Inherit;False;Property;_MainRotationAmount;Main Rotation Amount;5;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;145;-5002.629,-372.014;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;77;-4153.096,490.6404;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;60;-3661.798,616.6738;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;152;-4698.576,-371.0717;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;95;-3995.716,-972.983;Inherit;False;Property;_MainPannerXY;Main  Panner X/Y;4;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;59;-3670.081,498.1894;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;94;-4134.763,106.1025;Inherit;False;Property;_DistortPannerXY;Distort Panner X/Y;8;0;Create;True;0;0;0;False;0;False;0,0;0,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RotatorNode;165;-4103.188,-1251.946;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.51;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;149;-3850.065,-55.95564;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;2,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-3330.789,584.8961;Inherit;False;Custom1y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-4510.822,1692.802;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;21;-3668.031,-1052.335;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-3316.243,481.303;Inherit;False;Custom1x;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;306;-2056.903,88.06205;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;261;-4132.808,1684.604;Inherit;False;Custom2y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;63;-3353.353,-1049.557;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;23;-3554.49,-70.98204;Inherit;True;Property;_DistortTex;DistortTex;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;70;-3445.062,-823.0401;Inherit;False;65;Custom1y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;-3515.39,-1221.731;Inherit;False;64;Custom1x;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-3043.503,289.1831;Inherit;False;261;Custom2y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;31;-3153.775,-40.245;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-3053.835,-1213.972;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-3050.9,-841.3511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;265;-3021.659,409.3745;Inherit;False;Constant;_Float3;Float 3;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;307;-1718.101,115.1289;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;298;-2204.519,325.2562;Inherit;False;0;296;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;333;-1790.225,494.2218;Inherit;False;Property;_SubScaleAmount;Sub Scale Amount;23;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;331;-1341.676,134.4757;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;330;-1320.62,480.1368;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;93;-2950.97,87.92076;Inherit;False;Property;_DistortPowerXY;Distort Power X/Y;9;0;Create;True;0;0;0;False;0;False;0,0;0.2,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;58;-4510.882,1954.352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;264;-2816.592,392.9092;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;305;-1340.883,28.26809;Inherit;False;Property;_SubType;Sub Type;19;1;[Enum];Create;True;0;2;UV;0;Screen;1;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;72;-2624.086,-1100.748;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-4505.431,1826.678;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;338;-2939.761,8.881104;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;302;-1009.266,388.1689;Inherit;False;Property;_SubRotationAmount;Sub Rotation Amount;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;322;-1079.206,33.83541;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-4127.428,1826.401;Inherit;False;Custom2z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-2583.97,122.7648;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;29;-2558.268,-402.2383;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2603.019,-172.6596;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;263;-4131.516,1945.388;Inherit;False;Custom2w;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;288;-1888.562,3722.866;Inherit;False;263;Custom2w;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-2338.053,-393.8392;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;285;-2249.756,3151.558;Inherit;False;262;Custom2z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-2332.566,-174.5788;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-4192.586,1122.98;Inherit;False;Property;_DissolveOffset;Dissolve Offset;15;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;303;-677.212,379.524;Inherit;False;Property;_SubPannerXY;Sub Panner X/Y;21;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;290;-1838.857,3849.602;Inherit;False;Constant;_Float5;Float 5;21;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4203.776,1028.96;Inherit;False;Property;_BrightnessOffset;Brightness Offset;16;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;287;-2364.014,2978.197;Inherit;False;Property;_DissolveRotationAmount;Dissolve Rotation Amount;14;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;301;-699.7574,77.5094;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;297;-354.2988,247.0705;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-3664.165,733.204;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;173;-1864.371,3529.409;Inherit;False;Property;_DissolvePannerXY;DissolvePanner X/Y;13;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;36;-1982.119,-398.9889;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;171;-2039.256,3278.611;Inherit;False;0;170;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;289;-1671.857,3755.602;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-3659.597,854.116;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;286;-2021.447,3055.908;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-3306.038,732.9724;Inherit;False;Custom1z;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-3303.572,853.5203;Inherit;False;Custom1w;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;335;-87.55152,866.1968;Inherit;False;Property;_SubColor;Sub Color;24;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1764.939,-420.651;Inherit;True;Property;_MainTex;MainTex;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;296;-52.42397,221.6011;Inherit;True;Property;_SubTex;SubTex;20;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;291;-1517.857,3586.602;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;284;-1709.21,3003.24;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;267;-2063.109,4790.158;Inherit;False;66;Custom1z;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;381;242.0017,829.4417;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PannerNode;172;-1334.76,3505.491;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;268;-2091.302,4080.49;Inherit;True;67;Custom1w;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;235;-1286.978,-542.7326;Inherit;False;DistortTerm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;255;-1509.799,4352.67;Inherit;False;Constant;_Float9;Float 9;20;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;258;-1355.754,4955.346;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;385;439.7351,338.3045;Inherit;False;Constant;_Float11;Float 11;32;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;281.0447,-384.5035;Inherit;False;Property;_Tint;Tint;1;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;109;596.9658,-796.9773;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;187;-1284.403,4224.502;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;371;-256.051,-37.9866;Inherit;False;Property;_SubMode;Sub Mode;18;1;[Enum];Create;True;0;2;Multiply;0;Add;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;292;259.6494,-506.647;Inherit;False;235;DistortTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;186;-943.2407,4080.376;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;384;472.063,839.58;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;386;169.8595,1134.86;Inherit;False;subcolor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;170;-1058.843,3474.298;Inherit;True;Property;_DissolveTex;DissolveTex;12;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;387;837.0609,-645.9027;Inherit;False;386;subcolor;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;378;673.1729,418.5919;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;257;-1089.754,4903.346;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-0.3;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;178;-402.2962,3259.435;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;254;-998.5273,4331.467;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;566.9609,-471.6988;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;380;1058.464,372.3878;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;192;-657.5721,4598.32;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;184;-283.2336,4246.026;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;375;1032.058,-504.5644;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;200;81.88884,3557.907;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;206;349.5663,3733.364;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;226;-263.9812,4546.321;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;372;1302.448,-366.1638;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;185;42.3765,4377.36;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;177;942.865,3558.755;Inherit;False;Property;_DissolveType;Dissolve Type;11;1;[Enum];Create;True;0;2;Step;0;Smooth;1;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;259;-1409.157,4513.975;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;253;631.2362,4223.347;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;277;1623.325,-454.0423;Inherit;False;MainTerm;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;300;-915.7978,695.9034;Inherit;False;Property;_MaskRotationAmount;Mask Rotation Amount;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;355;1153.175,-1595.598;Inherit;False;Property;_BackfaceType;Backface Type;29;1;[Enum];Create;True;0;2;Back;0;Front;1;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;228;299.4106,4531.143;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;344;933.9283,-1387.491;Inherit;True;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;358;927.5985,-1134.846;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;236;348.055,4026.329;Inherit;False;235;DistortTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;190;-628.3199,4113.514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;237;1295.732,4190.688;Inherit;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;175;-1108.677,517.1347;Inherit;False;0;169;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;348;1242.943,-1059.33;Inherit;False;Property;_BackfaceColor;Backface Color;30;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ConditionalIfNode;361;1413.46,-1224.884;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;299;-351.926,529.9755;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StepOpNode;195;-364.2011,3587.719;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;176;-356.5818,791.0766;Inherit;False;Property;_MaskPannerXY;Mask Panner X/Y;26;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;232;509.3163,4526.629;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;365;1416.563,-1564.25;Inherit;False;277;MainTerm;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;240;1771.874,4026.51;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;364;1717.664,-1491.581;Inherit;False;277;MainTerm;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;199;58.00267,3242.007;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;360;1669.46,-1281.884;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;248;787.5383,4521.313;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;271;2211.057,3854.645;Inherit;False;DissolveTerm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;174;3.212117,531.7679;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;169;931.855,1123.712;Inherit;True;Property;_MaskTex;MaskTex;25;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;272;319.6824,-20.1135;Inherit;False;271;DissolveTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;208;341.4405,3276.634;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;293;1023.215,4524.117;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;250;1047.781,4960.107;Inherit;False;Constant;_Float6;Float 6;20;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;349;1988.871,-1401.929;Inherit;False;Property;_UseBackfaceColor;Use Backface Color;28;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;207;599.6615,3217.319;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;249;1308.841,4801.722;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;363;2264.56,-1411.372;Inherit;False;backterm;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;269;1769.113,4269.44;Inherit;False;Property;_BrightnessColor;Brightness Color;17;1;[HDR];Create;True;0;0;0;False;0;False;0.5019608,0.5019608,0.5019608,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;1433.989,-58.7036;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;275;1743.673,-67.16655;Inherit;True;AlphaTerm;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;368;2894.771,3639.616;Inherit;False;363;backterm;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;241;2776.514,4237.948;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;132;-5545.974,2697.886;Inherit;False;418;311;Custom Enum;1;139;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ConditionalIfNode;238;1739.601,3558.383;Inherit;True;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;276;3615.984,3898.575;Inherit;True;275;AlphaTerm;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;341;-2833.052,-943.9351;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-11;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;383;283.546,1024.028;Inherit;False;Constant;_Float10;Float 10;32;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-2193.474,4641.978;Inherit;False;Constant;_Float1;Float 1;20;0;Create;True;0;0;0;False;0;False;0.8222067;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-5499.168,2757.543;Inherit;False;Property;_Blend_Mode;Blend_Mode;2;1;[Enum];Create;True;0;2;Blended;10;Additive;1;0;True;0;False;0;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;351;2109.63,-809.3716;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;304;1362.482,256.4893;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;370;-1661.688,4286.823;Inherit;False;Constant;_Float0;Float 0;31;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;343;-2831.938,-1041.882;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;239;3253.093,3477.358;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;398;4116.422,3722.933;Float;False;True;-1;5;ASEMaterialInspector;0;0;Unlit;FX/J_FX_Master_castshadow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;2;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;True;139;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;88;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;86;0;87;0
WireConnection;86;1;88;0
WireConnection;81;0;86;0
WireConnection;279;0;281;0
WireConnection;279;1;49;0
WireConnection;279;2;280;0
WireConnection;282;0;279;0
WireConnection;55;0;282;0
WireConnection;55;1;53;1
WireConnection;260;0;55;0
WireConnection;162;0;163;0
WireConnection;162;1;266;0
WireConnection;80;0;75;0
WireConnection;80;1;48;0
WireConnection;80;2;84;0
WireConnection;145;0;147;0
WireConnection;145;2;162;0
WireConnection;77;0;80;0
WireConnection;60;0;77;1
WireConnection;60;1;54;2
WireConnection;152;0;145;0
WireConnection;59;0;77;0
WireConnection;59;1;54;1
WireConnection;165;0;22;0
WireConnection;165;2;166;0
WireConnection;149;0;152;0
WireConnection;149;2;94;0
WireConnection;65;0;60;0
WireConnection;56;0;282;1
WireConnection;56;1;53;2
WireConnection;21;0;165;0
WireConnection;21;2;95;0
WireConnection;64;0;59;0
WireConnection;261;0;56;0
WireConnection;63;0;21;0
WireConnection;23;1;149;0
WireConnection;31;0;23;1
WireConnection;69;0;68;0
WireConnection;69;1;63;0
WireConnection;71;0;63;1
WireConnection;71;1;70;0
WireConnection;307;0;306;1
WireConnection;307;1;306;2
WireConnection;331;0;307;0
WireConnection;331;1;333;0
WireConnection;330;0;298;0
WireConnection;330;1;333;0
WireConnection;58;0;282;3
WireConnection;58;1;53;4
WireConnection;264;0;158;0
WireConnection;264;1;265;0
WireConnection;72;0;69;0
WireConnection;72;1;71;0
WireConnection;57;0;282;2
WireConnection;57;1;53;3
WireConnection;338;0;31;0
WireConnection;322;0;305;0
WireConnection;322;2;331;0
WireConnection;322;3;330;0
WireConnection;322;4;330;0
WireConnection;262;0;57;0
WireConnection;44;0;338;0
WireConnection;44;1;93;2
WireConnection;44;2;264;0
WireConnection;29;0;72;0
WireConnection;43;0;93;1
WireConnection;43;1;31;0
WireConnection;43;2;264;0
WireConnection;263;0;58;0
WireConnection;41;0;29;0
WireConnection;41;1;43;0
WireConnection;39;0;29;1
WireConnection;39;1;44;0
WireConnection;301;0;322;0
WireConnection;301;2;302;0
WireConnection;297;0;301;0
WireConnection;297;2;303;0
WireConnection;61;0;77;2
WireConnection;61;1;54;3
WireConnection;61;2;122;0
WireConnection;36;0;41;0
WireConnection;36;1;39;0
WireConnection;289;0;288;0
WireConnection;289;1;290;0
WireConnection;62;0;77;3
WireConnection;62;1;54;4
WireConnection;62;2;121;0
WireConnection;286;0;287;0
WireConnection;286;1;285;0
WireConnection;66;0;61;0
WireConnection;67;0;62;0
WireConnection;2;1;36;0
WireConnection;296;1;297;0
WireConnection;291;0;173;0
WireConnection;291;1;289;0
WireConnection;284;0;171;0
WireConnection;284;2;286;0
WireConnection;381;0;296;0
WireConnection;381;1;335;0
WireConnection;172;0;284;0
WireConnection;172;2;291;0
WireConnection;235;0;2;1
WireConnection;258;0;267;0
WireConnection;187;0;268;0
WireConnection;186;0;268;0
WireConnection;384;0;381;0
WireConnection;386;0;335;0
WireConnection;170;1;172;0
WireConnection;378;0;385;0
WireConnection;378;1;384;0
WireConnection;378;2;371;0
WireConnection;257;0;258;0
WireConnection;178;0;170;1
WireConnection;178;1;186;0
WireConnection;254;0;187;0
WireConnection;254;1;255;0
WireConnection;108;0;109;0
WireConnection;108;1;20;0
WireConnection;108;2;292;0
WireConnection;380;0;108;0
WireConnection;380;1;378;0
WireConnection;192;0;254;0
WireConnection;192;1;257;0
WireConnection;184;0;170;1
WireConnection;184;1;254;0
WireConnection;375;0;296;0
WireConnection;375;1;108;0
WireConnection;375;2;378;0
WireConnection;375;3;387;0
WireConnection;200;0;178;0
WireConnection;206;0;200;0
WireConnection;226;0;170;1
WireConnection;226;1;192;0
WireConnection;372;0;375;0
WireConnection;372;1;380;0
WireConnection;372;2;371;0
WireConnection;185;0;184;0
WireConnection;259;0;267;0
WireConnection;253;0;184;0
WireConnection;277;0;372;0
WireConnection;228;0;185;0
WireConnection;228;1;226;0
WireConnection;190;0;186;0
WireConnection;190;1;259;0
WireConnection;237;0;177;0
WireConnection;237;2;253;0
WireConnection;237;3;206;0
WireConnection;237;4;206;0
WireConnection;361;0;355;0
WireConnection;361;2;344;0
WireConnection;361;3;358;0
WireConnection;361;4;358;0
WireConnection;299;0;175;0
WireConnection;299;2;300;0
WireConnection;195;0;170;1
WireConnection;195;1;190;0
WireConnection;232;0;228;0
WireConnection;240;0;237;0
WireConnection;240;1;236;0
WireConnection;199;0;195;0
WireConnection;199;1;178;0
WireConnection;360;0;365;0
WireConnection;360;1;348;0
WireConnection;360;2;361;0
WireConnection;248;0;232;0
WireConnection;271;0;240;0
WireConnection;174;0;299;0
WireConnection;174;2;176;0
WireConnection;169;1;174;0
WireConnection;208;0;199;0
WireConnection;293;0;248;0
WireConnection;349;0;364;0
WireConnection;349;1;360;0
WireConnection;207;0;208;0
WireConnection;249;0;267;0
WireConnection;249;2;293;0
WireConnection;249;3;250;0
WireConnection;249;4;250;0
WireConnection;363;0;349;0
WireConnection;111;0;2;4
WireConnection;111;1;109;4
WireConnection;111;2;272;0
WireConnection;111;3;169;1
WireConnection;275;0;111;0
WireConnection;241;0;240;0
WireConnection;241;1;269;0
WireConnection;238;0;177;0
WireConnection;238;2;249;0
WireConnection;238;3;207;0
WireConnection;238;4;207;0
WireConnection;341;0;71;0
WireConnection;343;0;69;0
WireConnection;239;0;241;0
WireConnection;239;1;368;0
WireConnection;239;2;238;0
WireConnection;398;2;239;0
WireConnection;398;9;276;0
ASEEND*/
//CHKSM=745C3A3E93A92F9A3C0B5BCB81CB0C1B0A52D36A