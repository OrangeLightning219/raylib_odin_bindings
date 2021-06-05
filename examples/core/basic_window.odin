package rl_core
import rl "../../raylib"

main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width := 800;
    screen_height := 450;

    init_window(screen_width, screen_height, "raylib [core] example - basic window");
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        begin_drawing();

        clear_background(RAYWHITE);

        draw_text("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

        end_drawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}