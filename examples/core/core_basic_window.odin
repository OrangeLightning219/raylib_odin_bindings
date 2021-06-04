package rl_core
import rl "../../raylib"

main :: proc()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width := 800;
    screen_height := 450;

    rl.init_window(screen_width, screen_height, "raylib [core] example - basic window");
    rl.set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    for !rl.window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.begin_drawing();

        rl.clear_background(rl.Color{255, 255, 255, 255});

        rl.draw_text("Congrats! You created your first window!", 190, 200, 20, rl.Color{200, 200, 200, 255});

        rl.end_drawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    rl.close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}