package rl_models
import rl "../../raylib"
import "core:mem"
import "core:fmt"
main :: proc()
{
    using rl;
    // Initialization
    //--------------------------------------------------------------------------------------
    screenWidth  :: 800;
    screenHeight :: 450;

    init_window(screenWidth, screenHeight, "raylib [models] example - model animation");

    // Define the camera to look into our 3d world
    camera: Camera;
    camera.position   = Vector3{ f32(0.0), f32(15.0), f32(-20.0) }; // Camera position
    camera.target     = Vector3{ f32(0.0), f32(2.0), f32(0.0) };      // Camera looking at point
    camera.up         = Vector3{ f32(0.0), f32(1.0), f32(0.0) };          // Camera up vector (rotation towards target)
    camera.fovy       = f32(45.0);                                      // Camera field-of-view Y
    camera.projection = .CAMERA_PERSPECTIVE;                      // Camera mode type

    model := load_model("resources/guy/guy.iqm");                      // Load the animated model mesh and basic data
    defer unload_model(model);

    texture := load_texture("resources/guy/guytex.png");               // Load model texture and set material
    defer unload_texture(texture);

    set_material_texture(mem.ptr_offset(model.materials, 0), .MATERIAL_MAP_ALBEDO, texture);  // Set model material map texture

    position := Vector3{ f32(0.0), f32(0.0), f32(0.0) };               // Set model position

    // Load animation data
    anims_count: i32 = 0;
    anims_ptr := load_model_animations("resources/guy/guyanim.iqm", &anims_count);
    anims     := mem.slice_ptr(anims_ptr, int(anims_count));
    defer unload_model_animations(&anims[0], u32(anims_count));

    anim_frame_counter: i32 = 0;

    set_camera_mode(camera, .CAMERA_FREE); // Set free camera mode

    set_target_fps(60);                   // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    for !window_should_close()        // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        update_camera(&camera);

        // Play animation when spacebar is held down
        if is_key_down(.KEY_SPACE)
        {
            anim_frame_counter += 1;
            update_model_animation(model, anims[0], anim_frame_counter);
            if anim_frame_counter >= anims[0].frame_count
            {
                anim_frame_counter = 0;
            } 
        }
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        begin_drawing();
        defer end_drawing();
     
        clear_background(RAYWHITE);

        begin_mode3d(camera);

            draw_model_ex(model, position, Vector3{ f32(1.0), f32(0.0), f32(0.0) }, f32(-90.0), Vector3{ f32(1.0), f32(1.0), f32(1.0) }, WHITE);

            for i in 0..<model.bone_count
            {
                transform := mem.ptr_offset(mem.ptr_offset(anims[0].frame_poses, int(anim_frame_counter))^, int(i))^;
                draw_cube(transform.translation, f32(0.2), f32(0.2), f32(0.2), RED);
            }

            draw_grid(i32(10), f32(1.0));         // Draw a grid

        end_mode3d();

        draw_text("PRESS SPACE to PLAY MODEL ANIMATION", 10, 10, 20, MAROON);
        draw_text("SHIFT + MMB to MOVE AROUND", 10, 30, 20, MAROON);
        draw_text("ALT + MMB to ROTATE", 10, 50, 20, MAROON);
        draw_text("(c) Guy IQM 3D model by @culacant", screenWidth - 200, screenHeight - 20, 10, GRAY);

        //----------------------------------------------------------------------------------
    }

    // De-Initialization
    //--------------------------------------------------------------------------------------
    close_window();              // Close window and OpenGL context
    //--------------------------------------------------------------------------------------
}
