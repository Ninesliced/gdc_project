shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = mix(COLOR, flash_color, COLOR.a * flash_color.a);
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
