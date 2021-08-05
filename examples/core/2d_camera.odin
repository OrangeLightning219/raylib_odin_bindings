package rl_core
import rl "../../raylib"

MAX_BUILDINGS :: 100;

main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    screen_width  :: 800;
    screen_height :: 450;
	
    init_window(screen_width, screen_height, "raylib [core] example - 2d camera");
	
	player := Rectangle{ 400, 280, 40, 40 };
    buildings: [MAX_BUILDINGS]Rectangle;
    build_colors: [MAX_BUILDINGS]Color;
	
    spacing: int;
	
    for i in 0..<MAX_BUILDINGS
    {
        buildings[i].width = cast(f32)get_random_value(50, 200);
        buildings[i].height = cast(f32)get_random_value(100, 800);
        buildings[i].y = screen_height - 130.0 - buildings[i].height;
        buildings[i].x = -6000.0 + cast(f32)spacing;
		
        spacing += cast(int)buildings[i].width;
		
        build_colors[i] = Color{ cast(u8)get_random_value(200, 240), cast(u8)get_random_value(200, 240), cast(u8)get_random_value(200, 250), 255 };
    }
	
    camera: Camera2d;
    camera.target = Vector2{ player.x + 20.0, player.y + 20.0 };
    camera.offset = Vector2{ screen_width/2.0, screen_height/2.0 };
    camera.rotation = 0.0;
    camera.zoom = 1.0;
	
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------
	
    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
		
        // Player movement
        if is_key_down(.KEY_RIGHT) do player.x += 2;
        else if is_key_down(.KEY_LEFT) do player.x -= 2;
		
        // Camera target follows player
        camera.target = Vector2{ player.x + 20, player.y + 20 };
		
        // Camera rotation controls
        if is_key_down(.KEY_A) do camera.rotation -= 1;
        else if is_key_down(.KEY_S) do camera.rotation += 1;
		
        // Limit camera rotation to 80 degrees (-40 to 40)
        if camera.rotation > 40 do camera.rotation = 40;
        else if camera.rotation < -40 do camera.rotation = -40;
		
        // Camera zoom controls
        camera.zoom += (cast(f32)get_mouse_wheel_move()*0.05);
		
        if camera.zoom > 3.0 do camera.zoom = 3.0;
        else if camera.zoom < 0.1 do camera.zoom = 0.1;
		
        // Camera reset (zoom and rotation)
        if is_key_pressed(.KEY_R)
        {
            camera.zoom = 1.0;
            camera.rotation = 0.0;
        }
        //----------------------------------------------------------------------------------
		
        // Draw
        //----------------------------------------------------------------------------------
        begin_drawing();
		
        clear_background(RAYWHITE);
		
        begin_mode2d(camera);
		
		draw_rectangle(-6000, 320, 13000, 8000, DARKGRAY);
		
		for i in 0..<MAX_BUILDINGS do draw_rectangle_rec(buildings[i], build_colors[i]);
		
		draw_rectangle_rec(player, RED);
		
		draw_line(cast(i32)camera.target.x, -screen_height*10, cast(i32)camera.target.x, screen_height*10, GREEN);
		draw_line(-screen_width*10, cast(i32)camera.target.y, screen_width*10, cast(i32)camera.target.y, GREEN);
		
		end_mode2d();
		
		draw_text("SCREEN AREA", 640, 10, 20, RED);
		
		draw_rectangle(0, 0, screen_width, 5, RED);
		draw_rectangle(0, 5, 5, screen_height - 10, RED);
		draw_rectangle(screen_width - 5, 5, 5, screen_height - 10, RED);
		draw_rectangle(0, screen_height - 5, screen_width, 5, RED);
		
		draw_rectangle( 10, 10, 250, 113, fade(SKYBLUE, 0.5));
		draw_rectangle_lines( 10, 10, 250, 113, BLUE);
		
		draw_text("Free 2d camera controls:", 20, 20, 10, BLACK);
		draw_text("- Right/Left to move Offset", 40, 40, 10, DARKGRAY);
		draw_text("- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY);
		draw_text("- A / S to Rotate", 40, 80, 10, DARKGRAY);
		draw_text("- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY);
		
        end_drawing();
        //----------------------------------------------------------------------------------
    }
	
    // De-Initialization
    //--------------------------------------------------------------------------------------
    close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
