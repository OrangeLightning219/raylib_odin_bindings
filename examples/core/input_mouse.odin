package rl_core
import rl "../../raylib"

main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width  :: 800;
    screen_height :: 450;
	
    init_window(screen_width, screen_height, "raylib [core] example - basic window");
	
	ball_position := Vector2{ -100.0, -100.0 };
    ball_color := DARKBLUE;
	
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
	
    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        ball_position = get_mouse_position();
		
        if is_mouse_button_pressed(.MOUSE_BUTTON_LEFT) do ball_color = MAROON;
        else if is_mouse_button_pressed(.MOUSE_BUTTON_MIDDLE) do ball_color = LIME;
        else if is_mouse_button_pressed(.MOUSE_BUTTON_RIGHT) do ball_color = DARKBLUE;
        else if is_mouse_button_pressed(.MOUSE_BUTTON_SIDE) do ball_color = PURPLE;
        else if is_mouse_button_pressed(.MOUSE_BUTTON_EXTRA) do ball_color = YELLOW;
        else if is_mouse_button_pressed(.MOUSE_BUTTON_FORWARD) do ball_color = ORANGE;
        else if is_mouse_button_pressed(.MOUSE_BUTTON_BACK) do ball_color = BEIGE;
        //----------------------------------------------------------------------------------
		
        // Draw
        //----------------------------------------------------------------------------------
        begin_drawing();
		
        clear_background(RAYWHITE);
		
		draw_circle_v(ball_position, 40, ball_color);
		
		draw_text("move ball with mouse and click mouse button to change color", 10, 10, 20, DARKGRAY);
		
        end_drawing();
        //----------------------------------------------------------------------------------
    }
	
    // De-Initialization
    //--------------------------------------------------------------------------------------
    close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
