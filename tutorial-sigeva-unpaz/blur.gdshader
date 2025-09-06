shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

/**
* Cuanto desenfoque querés que haya, mientrás más alto sea el valor, más desenfocado se va a ver
todo lo que haya detras del nodo en el que se utilice el shader, en este caso, un ColorRect.
*/
uniform float blur: hint_range(0.0, 8.0) = 0.0;

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, blur);
	COLOR = color;
}
