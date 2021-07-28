package raylib_bindings

import "core:fmt"

procedure_argument_type_exceptions := map[[2]string]string {
    {"is_key_pressed", "key"} = "Keyboard_Key",
    {"is_key_down", "key"} = "Keyboard_Key",
    {"is_key_released", "key"} = "Keyboard_Key",
    {"is_key_up", "key"} = "Keyboard_Key",
    {"set_exit_key", "key"} = "Keyboard_Key",

    {"is_gamepad_button_pressed", "button"} = "Gamepad_Button",
    {"is_gamepad_button_down", "button"} = "Gamepad_Button",
    {"is_gamepad_button_released", "button"} = "Gamepad_Button",
    {"is_gamepad_button_up", "button"} = "Gamepad_Button",

    {"is_mouse_button_pressed", "button"} = "Mouse_Button",
    {"is_mouse_button_down", "button"} = "Mouse_Button",
    {"is_mouse_button_released", "button"} = "Mouse_Button",
    {"is_mouse_button_up", "button"} = "Mouse_Button",
    
    // NOTE(BigChungusShrek): Not completely sure about these.

    {"set_config_flags", "flags"} = "Config_Flags",

    {"trace_log", "log_level"} = "Trace_Log_Level",

    {"set_mouse_cursor", "cursor"} = "Mouse_Cursor",

    {"get_gamepad_axis_movement", "axis"} = "Gamepad_Axis",

    {"set_material_texture", "map_type"} = "Material_Map_Index",

    {"set_shader_value", "loc_index"} = "Shader_Location_Index",
    {"set_shader_value_v", "loc_index"} = "Shader_Location_Index",
    {"set_shader_value_matrix", "loc_index"} = "Shader_Location_Index",
    {"set_shader_value_texture", "loc_index"} = "Shader_Location_Index",

    {"set_shader_value", "uniform_type"} = "Shader_Uniform_Data_Type",
    {"set_shader_value_v", "uniform_type"} = "Shader_Uniform_Data_Type",

    // TODO(BigChungusShrek): Which procs use Shader_Attribute_Data_Type???

    {"get_pixel_color", "format"} = "Pixel_Format",
    {"set_pixel_color", "format"} = "Pixel_Format",
    {"get_pixel_data_size", "format"} = "Pixel_Format",

    {"set_texture_filter", "filter"} = "Texture_Filter",

    {"set_texture_wrap", "wrap"} = "Texture_Wrap",

    {"load_texture_cubemap", "layout"} = "Cubemap_Layout",

    // TODO(BigChungusShrek): Which procs use Font_Type???

    {"set_texture_wrap", "wrap"} = "Texture_Wrap",

    {"begin_blend_mode", "mode"} = "Blend_Mode",

    // NOTE(BigChungusShrek): Right here I'm assuming that gesture's type is Gesture and not flags.
    {"is_gesture_detected", "gesture"} = "Gesture",

    {"set_camera_mode", "mode"} = "Camera_Mode",

    // TODO(BigChungusShrek): Which procs use N_Patch_Layout???
};

struct_member_exceptions := map[[2]string]string {
    {"Image", "format"} = "Pixel_Format",

    {"Texture", "format"} = "Pixel_Format",

    {"Camera3d", "projection"} = "Camera_Projection",

    // TODO(BigChungusShrek): What is the type for this? It just says audio filetype. Or is it just i32?
    //struct_member_type_exceptions{"Music", "ctx_type"} = "",
};
