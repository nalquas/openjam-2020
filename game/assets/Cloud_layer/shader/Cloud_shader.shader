shader_type canvas_item;
//color is #d2bfb1
uniform vec3 color = vec3(0.8234,0.749,0.6941);
uniform int OCTAVES = 16;
uniform float x = 0;
uniform float y = 0;
uniform float density = 0.5;
float rand(vec2 coord){
	return fract(sin(dot(coord, vec2(56,78))*1000.0) * 1000.0);
}
float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	float a = rand(i);
	float b = rand(i+vec2(1.0,0.0));
	float c = rand(i+vec2(0.0,1.0));
	float d = rand(i+vec2(1.0,1.0));
	vec2 cubic = f * f * (3.0 -2.0*f);
	float value = mix(a,b, cubic.x) + (c-a) * cubic.y * (1.0 - cubic.x) + (d-b) * cubic.x * cubic.y;
	return value;
}
float fbm(vec2 coord){
	coord = coord/10.0;
	float value = 0.0;
	float scale = 0.5;
	for (int i=0; i< OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 3.0;
		scale *= 0.5;
	}
	return value;
}
void fragment() {
	vec2 coord = (UV+vec2(x,y))*20.0;
	vec2 motion = vec2(fbm(coord + TIME *0.5));
	float final = fbm(coord+motion);
	if (final > density){
		float opacity = (final-density)/(1.0-density);
		COLOR = vec4(color,opacity);
	}
	else COLOR = vec4(0.0);
}