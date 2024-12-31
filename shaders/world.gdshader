shader_type canvas_item;


uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, repeat_disable, filter_nearest;
uniform float crt_brightness: hint_range(0.0, 1.0) = 1.0;
uniform float crt_ghost: hint_range(0.0, 10.0) = 3.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 screen_uv = SCREEN_UV;
	vec3 color = texture(SCREEN_TEXTURE, screen_uv).rgb * (1.0 - crt_brightness * 0.5);
	color += texture(SCREEN_TEXTURE, screen_uv - vec2(SCREEN_PIXEL_SIZE.x * crt_ghost, 0.0)).rgb;
	color += texture(SCREEN_TEXTURE, screen_uv - vec2(SCREEN_PIXEL_SIZE.x * crt_ghost, 0.0)).rgb;
	color *= crt_brightness * 0.50;
	COLOR = vec4(color, 1.0);
	
	float ctr_grid_uv = mod(SCREEN_UV.x / SCREEN_UV.x, 3.0);
	
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
