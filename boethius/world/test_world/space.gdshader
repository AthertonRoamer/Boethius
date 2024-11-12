shader_type canvas_item;

uniform float speed = 100.0;
uniform sampler2D noise;
uniform vec4 color: source_color = vec4(1,1,1,1);
uniform vec4 color2: source_color = vec4(1,1,1,1);
uniform float intensity = 1;
uniform float alpha: hint_range(0.0, 1.0, 0.1) = 0;
uniform float brightness = 2;
//
void fragment()
{
	// image texture
	vec4 base = texture(TEXTURE, UV);
	// noise texture
	base *= color;
	//vec4 blend = texture(noise, UV + ( direction * speed * TIME));
	vec3 noisy = texture(noise, UV + (vec2( sin(TIME), -sin(TIME) ) / speed)).rbg;
	noisy *= color2.rbg;
	//vec2 noise_mix = mix(UV, noisy.xy, 1);
	COLOR = vec4((base.rbg) * (noisy * ( (sin(TIME) / intensity) + brightness)), base.a - alpha);
}