shader_type canvas_item;
uniform float water_h = 0.01;
uniform float low_lands_h = 0.1;
uniform float middle_lands_h = 0.2;
uniform float high_lands_h = 0.5;
uniform vec3 water_c = vec3(0.0,0.0,1);
uniform vec3 low_lands_c = vec3(0.8234,0.749,0.6941);
uniform vec3 middle_lands_c = vec3(0.8234,0.749,0.6941);
uniform vec3 high_lands_c = vec3(0.8234,0.749,0.6941);
uniform vec3 mountaintop = vec3(0.0,0.0,0.0);
uniform int OCTAVES = 8;
uniform float x = 0;
uniform float y = 0;
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
	float value = 0.0;
	float scale = 0.5;
	for (int i=0; i< OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 1.5;
		scale *= 0.5;
	}
	return value;
}

void fragment() {
	vec2 coord = (UV+vec2(x,y))*1.0;
	float final = fbm(coord);
	if (final<water_h-0.001){
		COLOR = vec4(water_c,1.0);
	}else if (final<water_h+0.001){
		float gra = (water_h+0.001-final)*500.0;
		COLOR = (vec4(water_c,1.0)*gra+vec4(low_lands_c,1.0)*(1.0-gra));
	}
	else if(final<low_lands_h-0.001){
		COLOR = vec4(low_lands_c,1.0);
	}else if (final<low_lands_h+0.001){
		float gra = (low_lands_h+0.001-final)*500.0;
		COLOR = (vec4(low_lands_c,1.0)*gra+vec4(middle_lands_c,1.0)*(1.0-gra));
	}
	else if(final<middle_lands_h-0.001){
		COLOR = vec4(middle_lands_c,1.0);
	}else if (final<middle_lands_h+0.001){
		float gra = (middle_lands_h+0.001-final)*500.0;
		COLOR = (vec4(middle_lands_c,1.0)*gra+vec4(high_lands_c,1.0)*(1.0-gra));
	}
	else if(final<high_lands_h-0.001){
		COLOR = vec4(high_lands_c,1.0);
	}else if (final<high_lands_h+0.001){
		float gra = (high_lands_h+0.001-final)*500.0;
		COLOR = (vec4(high_lands_c,1.0)*gra+vec4(mountaintop,1.0)*(1.0-gra));
	}
	else{
		COLOR = vec4(mountaintop,1.0);
	}
}