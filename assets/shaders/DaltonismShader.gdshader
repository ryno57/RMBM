shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform int mode = 0; // 0 = normal, 1 = protanopie, 2 = deutéranopie, 3 = tritanopie

void fragment() {
    vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV);

    if (mode == 1) {
        // Protanopie : atténuer les rouges
        col.r = col.g;
    } else if (mode == 2) {
        // Deutéranopie : atténuer les verts
        col.g = col.r;
    } else if (mode == 3) {
        // Tritanopie : atténuer les bleus
        col.b = col.g;
    }

    COLOR = col;
}