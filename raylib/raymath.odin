package raylib

foreign import raylib "raylib.lib"

@(default_calling_convention="c")
foreign raylib
{
    @(link_name="Vector2Add")
	vector2_add :: proc(v1: Vector2, v2: Vector2) -> Vector2 ---;
}