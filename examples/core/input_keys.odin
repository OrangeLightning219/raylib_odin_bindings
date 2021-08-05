package rl_core
import rl "../../raylib"

main :: proc()
{
	using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
	screen_width :: 800;
	screen_height :: 450;
	
    init_window(screen_width, screen_height, "raylib [core] example - keyboard input");
	
	ball_position := Vector2{ cast(f32)screen_width/2, cast(f32)screen_height/2 };
	
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
	
    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if is_key_down(.KEY_RIGHT) do ball_position.x += 2.0;
        if is_key_down(.KEY_LEFT) do ball_position.x -= 2.0;
        if is_key_down(.KEY_UP) do ball_position.y -= 2.0;
        if is_key_down(.KEY_DOWN) do ball_position.y += 2.0;
        //----------------------------------------------------------------------------------
		
        // Draw
        //----------------------------------------------------------------------------------
        begin_drawing();
		
		clear_background(RAYWHITE);
		
		draw_text("move the ball with arrow keys", 10, 10, 20, DARKGRAY);
		
		draw_circle_v(ball_position, 50, MAROON);
		
        end_drawing();
        //----------------------------------------------------------------------------------
    }
	
    // De-Initialization
    //--------------------------------------------------------------------------------------
    close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
