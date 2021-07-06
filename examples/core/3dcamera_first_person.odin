package rl_core

import rl "../../raylib"

MAX_COLUMNS :: 20;

main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    SCREEN_WIDTH  :: 1280;
    SCREEN_HEIGHT :: 720;
    
    init_window(SCREEN_WIDTH, SCREEN_HEIGHT, "third person shooter");
    
    // Define the camera to look into our 3d world (position, target, up vector)
    camera := Camera{};
    camera.position = Vector3{4.0, 2.0, 4.0};
    camera.target = Vector3{0.0, 1.8, 0.0};
    camera.up = Vector3{0.0, 1.0, 0.0};
    camera.fovy = 60.0;
    camera.projection = i32(Camera_Projection.CAMERA_PERSPECTIVE);
    
    // Generates some random columns
    heights: [MAX_COLUMNS]f32;
    positions: [MAX_COLUMNS]Vector3;
    colors: [MAX_COLUMNS]Color;
    
    for i in 0..<MAX_COLUMNS
    {
        heights[i] = f32(get_random_value(1, 12));
        positions[i] = Vector3{f32(get_random_value(-15, 15)), heights[i]/2.0, f32(get_random_value(-15, 15))};
        colors[i] = Color{u8(get_random_value(20, 255)), u8(get_random_value(10, 55)), 30, 255};
    }
    
    set_camera_mode(camera, i32(Camera_Mode.CAMERA_FIRST_PERSON)); // Set a first person camera mode
    
    set_target_fps(60);               // Set our game to run at 60 frames-per-second
    
    //--------------------------------------------------------------------------------------
    
    // Main game loop
    for !window_should_close()    // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        update_camera(&camera);                  // Update camera
        //----------------------------------------------------------------------------------
        
        // Draw
        //----------------------------------------------------------------------------------
        begin_drawing();
        
        clear_background(RAYWHITE);
        
        begin_mode3d(camera);
        
        draw_plane(Vector3{0.0, 0.0, 0.0}, Vector2{32.0, 32.0}, LIGHTGRAY); // Draw ground
        draw_cube(Vector3{-16.0, 2.5, 0.0}, 1.0, 5.0, 32.0, BLUE);     // Draw a blue wall
        draw_cube(Vector3{16.0, 2.5, 0.0}, 1.0, 5.0, 32.0, LIME);      // Draw a green wall
        draw_cube(Vector3{0.0, 2.5, 16.0}, 32.0, 5.0, 1.0, GOLD);      // Draw a yellow wall
        
        // Draw some cubes around
        for i in 0..<MAX_COLUMNS
        {
            draw_cube(positions[i], 2.0, heights[i], 2.0, colors[i]);
            draw_cube_wires(positions[i], 2.0, heights[i], 2.0, MAROON);
        }
        
        end_mode3d();
        
        draw_rectangle( 10, 10, 220, 70, fade(SKYBLUE, 0.5));
        draw_rectangle_lines( 10, 10, 220, 70, BLUE);
        
        draw_text("First person camera default controls:", 20, 20, 10, BLACK);
        draw_text("- Move with keys: W, A, S, D", 40, 40, 10, DARKGRAY);
        draw_text("- Mouse move to look around", 40, 60, 10, DARKGRAY);
        
        end_drawing();
        //----------------------------------------------------------------------------------
    }
    
    // De-Initialization
    //--------------------------------------------------------------------------------------
    close_window();        // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
