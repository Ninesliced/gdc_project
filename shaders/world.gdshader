shader_type canvas_item;
render_mode unshaded, skip_vertex_transform;

const float curvature = 7.0;
const float vignette_multiplier = 0.12;
const float lines_intensity = 0.032;
const float lines_sharp = 4.0;
const float scan_line_speed = 0.01;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 zoomed_uv = (SCREEN_UV - 0.5) / 1.02 + 0.5;
	vec2 centered_uv = zoomed_uv * 2.0 - 1.0;
	vec2 uv_offset = centered_uv.yx / curvature;
	vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
	vec3 cutoff = vec3(step(abs(warped_uv.x), 1.0) * step(abs(warped_uv.y), 1.0));
	float scanline_offset = mod(TIME * scan_line_speed, 1.0);
	vec3 scanlines = vec3(sin(lines_sharp * (warped_uv.y - scanline_offset) * 180.0) * lines_intensity + 1.02);
	vec3 vignette = vec3(length(pow(abs(centered_uv), vec2(4.0)) / 3.0));

	vec3 screen_color = textureLod(screen_texture, (warped_uv + 1.0) / 2.0, 0.2).rgb * cutoff * scanlines;
	screen_color -= vignette * vignette_multiplier;
	COLOR = vec4(screen_color, 1.0);
}