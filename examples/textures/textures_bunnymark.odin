package rl_textures
import rl "../../raylib"

MAX_BUNNIES :: 50000;    // 50K bunnies limit

// This is the maximum amount of elements (quads) per batch
// NOTE: This value is defined in [rlgl] module and can be changed there
MAX_BATCH_ELEMENTS :: 8192;

Bunny :: struct 
{
    position: rl.Vector2, 
    speed: rl.Vector2,
    color: rl.Color,
};

main :: proc()
{
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width := 800;
    screen_height := 450;

    rl.init_window(screen_width, screen_height, "raylib [textures] example - bunnymark");

    // Load bunny texture
    tex_bunny := rl.load_texture("resources/wabbit_alpha.png");

    // // Bunny *bunnies = (Bunny *)malloc(MAX_BUNNIES*sizeof(Bunny));    // Bunnies array
    // bunnies := [MAX_BUNNIES]Bunny{};
    bunnies := make([]Bunny, MAX_BUNNIES);

    bunnies_count := 0;           // Bunnies counter

    rl.set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    for !rl.window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        if rl.is_mouse_button_down(cast(int)rl.Mouse_Button.MOUSE_BUTTON_LEFT)
        {
            // Create more bunnies
            for i in 0..<100
            {
                if bunnies_count < MAX_BUNNIES
                {
                    bunnies[bunnies_count].position = rl.get_mouse_position();
                    bunnies[bunnies_count].speed.x = cast(f32)rl.get_random_value(-250, 250)/60.0;
                    bunnies[bunnies_count].speed.y = cast(f32)rl.get_random_value(-250, 250)/60.0;
                    bunnies[bunnies_count].color = rl.Color{ cast(u8) rl.get_random_value(50, 240),
                                                             cast(u8) rl.get_random_value(80, 240),
                                                             cast(u8) rl.get_random_value(100, 240), 
                                                             255 };
                    bunnies_count += 1;
                }
            }
        }

        // Update bunnies
        for i in 0..<bunnies_count
        {
            bunnies[i].position.x += bunnies[i].speed.x;
            bunnies[i].position.y += bunnies[i].speed.y;

            if (bunnies[i].position.x + cast(f32)tex_bunny.width/2.0) > cast(f32)rl.get_screen_width() || (bunnies[i].position.x + cast(f32)tex_bunny.width/2.0) < 0 
            {
                bunnies[i].speed.x *= -1;
            }
            if (bunnies[i].position.y + cast(f32)tex_bunny.height/2.0) > cast(f32)rl.get_screen_height() || (bunnies[i].position.y + cast(f32)tex_bunny.height/2.0) - 40 < 0 
            {
                bunnies[i].speed.y *= -1;
            }
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.begin_drawing();

        rl.clear_background(rl.RAYWHITE); //RAYWHITE

        for i in 0..<bunnies_count
        {
            // NOTE: When internal batch buffer limit is reached (MAX_BATCH_ELEMENTS),
            // a draw call is launched and buffer starts being filled again;
            // before issuing a draw call, updated vertex data from internal CPU buffer is send to GPU...
            // Process of sending data is costly and it could happen that GPU data has not been completely
            // processed for drawing while new data is tried to be sent (updating current in-use buffers)
            // it could generates a stall and consequently a frame drop, limiting the number of drawn bunnies
            rl.draw_texture(tex_bunny, cast(int)bunnies[i].position.x, cast(int)bunnies[i].position.y, bunnies[i].color);
        }

        rl.draw_rectangle(0, 0, screen_width, 40, rl.BLACK); //BLACK
        rl.draw_text(rl.text_format("bunnies: %i", bunnies_count), 120, 10, 20, rl.GREEN); //GREEN
        rl.draw_text(rl.text_format("batched draw calls: %i", 1 + bunnies_count/MAX_BATCH_ELEMENTS), 320, 10, 20, rl.MAROON); //MAROON

        rl.draw_fps(10, 10);

        rl.end_drawing();
        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    // delete(bunnies);              // Unload bunnies data array

    rl.unload_texture(tex_bunny);    // Unload bunny texture

    rl.close_window();              // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
