shader_type spatial;
render_mode unshaded;
uniform vec4 color_in;
varying float sh;

void vertex() {
	vec3 light_direction = normalize(vec3(-1.0,-1.0,-1.0));
	sh = dot(NORMAL,light_direction);
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	ALBEDO = - sh * NORMAL;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
