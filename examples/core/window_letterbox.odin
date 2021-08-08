package rl_core
import rl "../../raylib"
import "core:fmt"
// NOTE(BigChungusShrek): max, min, and clamp are not defined because they are builtin procedures in odin.

main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width  :: 800;
    screen_height :: 450;
	
	// Enable config flags for resizable window and vertical synchro
    set_config_flags(.FLAG_WINDOW_RESIZABLE);
    // set_config_flags(.FLAG_WINDOW_RESIZABLE | .FLAG_VSYNC_HINT);
    init_window(screen_width, screen_height, "raylib [core] example - window scale letterbox");
	set_window_min_size(320, 240);
	
	game_screen_width := 640;
	game_screen_height := 480;

    // Render texture initialization, used to hold the rendering result so we can easily resize it
    target := load_render_texture(cast(i32)game_screen_width, cast(i32)game_screen_height);
    set_texture_filter(target.texture, .TEXTURE_FILTER_BILINEAR);  // Texture scale filter to use

    colors: [10]Color;
    for i in 0..<10 do colors[i] = Color{ cast(u8)get_random_value(100, 250), cast(u8)get_random_value(50, 150), cast(u8)get_random_value(10, 100), 255 };
	
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
	
    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // Compute required framebuffer scaling
        scale := min(cast(f32)get_screen_width()/cast(f32)game_screen_width, cast(f32)get_screen_height()/cast(f32)game_screen_height);
		
        if (is_key_pressed(.KEY_SPACE))
        {
            // Recalculate random colors for the bars
            for i in 0..<10 do colors[i] = Color{ cast(u8)get_random_value(100, 250), cast(u8)get_random_value(50, 150), cast(u8)get_random_value(10, 100), 255 };
        }
		
        // Update virtual mouse (clamped mouse value behind game screen)
        mouse := get_mouse_position();
        virtual_mouse: Vector2;
        virtual_mouse.x = (mouse.x - (cast(f32)get_screen_width() - (cast(f32)game_screen_width*scale))*0.5)/scale;
        virtual_mouse.y = (mouse.y - (cast(f32)get_screen_height() - (cast(f32)game_screen_height*scale))*0.5)/scale;
        virtual_mouse.x = clamp(virtual_mouse.x, 0, cast(f32)game_screen_width);
		virtual_mouse.y = clamp(virtual_mouse.y, 0, cast(f32)game_screen_height);
		
		// Apply the same transformation as the virtual mouse to the real mouse (i.e. to work with raygui)
		//set_mouse_offset(-(get_screen_width() - (game_screen_width*scale))*0.5, -(get_screen_height() - (game_screen_height*scale))*0.5);
		//set_mouse_scale(1/scale, 1/scale);
		//----------------------------------------------------------------------------------
		
		// Draw
		//----------------------------------------------------------------------------------
		begin_texture_mode(target);
		clear_background(RED);  // Clear render texture background color
		
		for i in 0..<10 do draw_rectangle(0, cast(i32)((game_screen_height/10)*i), cast(i32)game_screen_width, cast(i32)(game_screen_height/10), colors[i]);
		
		draw_text("If executed inside a window,\nyou can resize the window,\nand see the screen scaling!", 10, 25, 20, WHITE);
		draw_text(text_format("Default Mouse: [%i , %i]", cast(int)mouse.x, cast(int)mouse.y), 350, 25, 20, GREEN);
		draw_text(text_format("Virtual Mouse: [%i , %i]", cast(int)virtual_mouse.x, cast(int)virtual_mouse.y), 350, 55, 20, YELLOW);
		end_texture_mode();
		
		begin_drawing();
		clear_background(BLACK);     // Clear screen background
		
		// Draw render texture to screen, properly scaled
		draw_texture_pro(target.texture, Rectangle{ 0.0, 0.0, cast(f32)target.texture.width, cast(f32)-target.texture.height },
						 Rectangle{ (cast(f32)get_screen_width() - (cast(f32)game_screen_width*scale))*0.5, (cast(f32)get_screen_height() - (cast(f32)game_screen_height*scale))*0.5,
							 cast(f32)game_screen_width*scale, cast(f32)game_screen_height*scale }, Vector2{0, 0}, 0.0, WHITE);
		end_drawing();
		//----------------------------------------------------------------------------------
	}
	
	// De-Initialization
	//--------------------------------------------------------------------------------------
	unload_render_texture(target);        // Unload render texture
	
	close_window();        // Close window and OpenGL context
	//--------------------------------------------------------------------------------------
}