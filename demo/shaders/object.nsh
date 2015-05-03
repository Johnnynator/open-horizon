@sampler base_map "diffuse"
@uniform light_dir "light dir":local_rot
@uniform alpha_clip "alpha clip"=-1.0

@all

varying vec2 tc;
varying vec3 normal;

@vertex

void main()
{
    tc = gl_MultiTexCoord0.xy;
	normal = gl_Normal.xyz;
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}

@fragment

uniform sampler2D base_map;
uniform vec4 light_dir;
//uniform vec4 alpha_clip;

void main()
{
    vec4 base = texture2D(base_map, tc);
    //if(base.a < alpha_clip.x) discard;

    vec3 light = vec3(0.7 + 0.3*max(0.0,dot(normal,light_dir.xyz)));
    base.rgb *= light;
    gl_FragColor = base;
}