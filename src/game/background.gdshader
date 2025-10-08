shader_type canvas_item;

uniform vec3 horizon_color= vec3(0, 0, 1);
uniform vec3 atmo_color= vec3(0, 0, 0);
uniform float max_height;

uniform float current_height;



void fragment()
{
	COLOR= vec4(mix(horizon_color, atmo_color, max(0, current_height / max_height)), 1.0);
}
	