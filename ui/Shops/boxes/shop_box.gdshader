shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float line_effect = mod(UV.y * 2.0, 0.2);
	vec4 base_color = texture(TEXTURE,UV);
	vec3 final_color = mix(vec3(0,0,0),base_color.rgb, 1.0 - line_effect);
	//
	COLOR = vec4(final_color.rgb, base_color.a);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
