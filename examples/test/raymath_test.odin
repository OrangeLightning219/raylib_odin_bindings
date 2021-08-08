package rl_core
import rl "../../raylib"

main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width  :: 800;
    screen_height :: 450;

    // set_config_flags(.FLAG_WINDOW_RESIZABLE | .FLAG_VSYNC_HINT);
    init_window(screen_width, screen_height, "raylib [core] example - window scale letterbox");
	
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
	
    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
		
        // Update virtual mouse (clamped mouse value behind game screen)
        mouse := get_mouse_position();
		
		// Draw
		//----------------------------------------------------------------------------------
		begin_drawing();
		clear_background(DARKGRAY);     // Clear screen background

		draw_text(text_format("Mouse: [%i , %i]", cast(int)mouse.x, cast(int)mouse.y), 10, 25, 20, GREEN);
        new_mouse := vector2_add(mouse, Vector2{10, 10});
		draw_text(text_format("Mouse + 10: [%i , %i]", cast(int)new_mouse.x, cast(int)new_mouse.y), 10, 55, 20, YELLOW);

		end_drawing();
		//----------------------------------------------------------------------------------
	}
	
	// De-Initialization
	//--------------------------------------------------------------------------------------
	close_window();        // Close window and OpenGL context
	//--------------------------------------------------------------------------------------
}