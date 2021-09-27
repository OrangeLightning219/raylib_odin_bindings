package raylib

foreign import raylib "raylib.lib"

Quaternion :: Vector4;
Texture2d :: Texture;
Texture_Cubemap :: Texture;
Render_Texture2d :: Render_Texture;
Camera :: Camera3d;
Trace_Log_Callback :: proc(log_level: Trace_Log_Level, text: cstring, args: ..any);
Load_File_Data_Callback :: proc(filename: cstring, bytes_read: ^u8) -> ^u8;
Save_File_Data_Callback :: proc(filename: cstring, data: rawptr, bytes_to_write: u8) -> bool;
Load_File_Text_Callback :: proc(filename: cstring) -> ^u8;
Save_File_Text_Callback :: proc(filename: cstring, text: ^u8) -> bool;
LIGHTGRAY :: Color {200, 200, 200, 255};
GRAY      :: Color{ 130, 130, 130, 255 };
DARKGRAY  :: Color{ 80, 80, 80, 255 };
YELLOW    :: Color{ 253, 249, 0, 255 };
GOLD      :: Color{ 255, 203, 0, 255 };
ORANGE    :: Color{ 255, 161, 0, 255 };
PINK      :: Color{ 255, 109, 194, 255 };
RED       :: Color{ 230, 41, 55, 255 };
MAROON    :: Color{ 190, 33, 55, 255 };
GREEN     :: Color{ 0, 228, 48, 255 };
LIME      :: Color{ 0, 158, 47, 255 };
DARKGREEN :: Color{ 0, 117, 44, 255 };
SKYBLUE   :: Color{ 102, 191, 255, 255 };
BLUE      :: Color{ 0, 121, 241, 255 };
DARKBLUE  :: Color{ 0, 82, 172, 255 };
PURPLE    :: Color{ 200, 122, 255, 255 };
VIOLET    :: Color{ 135, 60, 190, 255 };
DARKPURPLE:: Color{ 112, 31, 126, 255 };
BEIGE     :: Color{ 211, 176, 131, 255 };
BROWN     :: Color{ 127, 106, 79, 255 };
DARKBROWN :: Color{ 76, 63, 47, 255 };
WHITE     :: Color{ 255, 255, 255, 255 };
BLACK     :: Color{ 0, 0, 0, 255 };
BLANK     :: Color{ 0, 0, 0, 0 };
MAGENTA   :: Color{ 255, 0, 255, 255 };
RAYWHITE  :: Color{ 245, 245, 245, 255 };
r_Audio_Buffer :: struct {};

Vector2 :: struct
{
	x: f32, // Vector x component
	y: f32, // Vector y component
};

Vector3 :: struct
{
	x: f32, // Vector x component
	y: f32, // Vector y component
	z: f32, // Vector z component
};

Vector4 :: struct
{
	x: f32, // Vector x component
	y: f32, // Vector y component
	z: f32, // Vector z component
	w: f32, // Vector w component
};

Matrix :: struct
{
	m0: f32, // Matrix first row (4 components)
	m4: f32, // Matrix first row (4 components)
	m8: f32, // Matrix first row (4 components)
	m12: f32, // Matrix first row (4 components)
	m1: f32, // Matrix second row (4 components)
	m5: f32, // Matrix second row (4 components)
	m9: f32, // Matrix second row (4 components)
	m13: f32, // Matrix second row (4 components)
	m2: f32, // Matrix third row (4 components)
	m6: f32, // Matrix third row (4 components)
	m10: f32, // Matrix third row (4 components)
	m14: f32, // Matrix third row (4 components)
	m3: f32, // Matrix fourth row (4 components)
	m7: f32, // Matrix fourth row (4 components)
	m11: f32, // Matrix fourth row (4 components)
	m15: f32, // Matrix fourth row (4 components)
};

Color :: struct
{
	r: u8, // Color red value
	g: u8, // Color green value
	b: u8, // Color blue value
	a: u8, // Color alpha value
};

Rectangle :: struct
{
	x: f32, // Rectangle top-left corner position x
	y: f32, // Rectangle top-left corner position y
	width: f32, // Rectangle width
	height: f32, // Rectangle height
};

Image :: struct
{
	data: rawptr, // Image raw data
	width: i32, // Image base width
	height: i32, // Image base height
	mipmaps: i32, // Mipmap levels, 1 by default
	format: Pixel_Format, // Data format (PixelFormat type)
};

Texture :: struct
{
	id: u32, // OpenGL texture id
	width: i32, // Texture base width
	height: i32, // Texture base height
	mipmaps: i32, // Mipmap levels, 1 by default
	format: Pixel_Format, // Data format (PixelFormat type)
};

Render_Texture :: struct
{
	id: u32, // OpenGL framebuffer object id
	texture: Texture, // Color buffer attachment texture
	depth: Texture, // Depth buffer attachment texture
};

N_Patch_Info :: struct
{
	source: Rectangle, // Texture source rectangle
	left: i32, // Left border offset
	top: i32, // Top border offset
	right: i32, // Right border offset
	bottom: i32, // Bottom border offset
	layout: i32, // Layout of the n-patch: 3x3, 1x3 or 3x1
};

Glyph_Info :: struct
{
	value: i32, // Character value (Unicode)
	offset_x: i32, // Character offset X when drawing
	offset_y: i32, // Character offset Y when drawing
	advance_x: i32, // Character advance position X
	image: Image, // Character image data
};

Font :: struct
{
	base_size: i32, // Base size (default chars height)
	glyph_count: i32, // Number of glyph characters
	glyph_padding: i32, // Padding around the glyph characters
	texture: Texture2d, // Texture atlas containing the glyphs
	recs: ^Rectangle, // Rectangles in texture for the glyphs
	glyphs: ^Glyph_Info, // Glyphs info data
};

Camera3d :: struct
{
	position: Vector3, // Camera position
	target: Vector3, // Camera target it looks-at
	up: Vector3, // Camera up vector (rotation over its axis)
	fovy: f32, // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
	projection: Camera_Projection, // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
};

Camera2d :: struct
{
	offset: Vector2, // Camera offset (displacement from target)
	target: Vector2, // Camera target (rotation and zoom origin)
	rotation: f32, // Camera rotation in degrees
	zoom: f32, // Camera zoom (scaling), should be 1.0f by default
};

Mesh :: struct
{
	vertex_count: i32, // Number of vertices stored in arrays
	triangle_count: i32, // Number of triangles stored (indexed or not)
	vertices: ^f32, // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	texcoords: ^f32, // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	texcoords2: ^f32, // Vertex second texture coordinates (useful for lightmaps) (shader-location = 5)
	normals: ^f32, // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
	tangents: ^f32, // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
	colors: ^u8, // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
	indices: ^u16, // Vertex indices (in case vertex data comes indexed)
	anim_vertices: ^f32, // Animated vertex positions (after bones transformations)
	anim_normals: ^f32, // Animated normals (after bones transformations)
	bone_ids: ^i32, // Vertex bone ids, up to 4 bones influence by vertex (skinning)
	bone_weights: ^f32, // Vertex bone weight, up to 4 bones influence by vertex (skinning)
	vao_id: u32, // OpenGL Vertex Array Object id
	vbo_id: ^u32, // OpenGL Vertex Buffer Objects id (default vertex data)
};

Shader :: struct
{
	id: u32, // Shader program id
	locs: ^i32, // Shader locations array (RL_MAX_SHADER_LOCATIONS)
};

Material_Map :: struct
{
	texture: Texture2d, // Material map texture
	color: Color, // Material map color
	value: f32, // Material map value
};

Material :: struct
{
	shader: Shader, // Material shader
	maps: ^Material_Map, // Material maps array (MAX_MATERIAL_MAPS)
	params: [4]f32, // Material generic parameters (if required)
};

Transform :: struct
{
	translation: Vector3, // Translation
	rotation: Quaternion, // Rotation
	scale: Vector3, // Scale
};

Bone_Info :: struct
{
	name: [32]u8, // Bone name
	parent: i32, // Bone parent
};

Model :: struct
{
	transform: Matrix, // Local transform matrix
	mesh_count: i32, // Number of meshes
	material_count: i32, // Number of materials
	meshes: ^Mesh, // Meshes array
	materials: ^Material, // Materials array
	mesh_material: ^i32, // Mesh material number
	bone_count: i32, // Number of bones
	bones: ^Bone_Info, // Bones information (skeleton)
	bind_pose: ^Transform, // Bones base transformation (pose)
};

Model_Animation :: struct
{
	bone_count: i32, // Number of bones
	frame_count: i32, // Number of animation frames
	bones: ^Bone_Info, // Bones information (skeleton)
	frame_poses: ^^Transform, // Poses array by frame
};

Ray :: struct
{
	position: Vector3, // Ray position (origin)
	direction: Vector3, // Ray direction
};

Ray_Collision :: struct
{
	hit: bool, // Did the ray hit something?
	distance: f32, // Distance to nearest hit
	point: Vector3, // Point of nearest hit
	normal: Vector3, // Surface normal of hit
};

Bounding_Box :: struct
{
	min: Vector3, // Minimum vertex box-corner
	max: Vector3, // Maximum vertex box-corner
};

Wave :: struct
{
	frame_count: u32, // Total number of frames (considering channels)
	sample_rate: u32, // Frequency (samples per second)
	sample_size: u32, // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	channels: u32, // Number of channels (1-mono, 2-stereo, ...)
	data: rawptr, // Buffer data pointer
};

Audio_Stream :: struct
{
	buffer: ^r_Audio_Buffer, // Pointer to internal data used by the audio system
	sample_rate: u32, // Frequency (samples per second)
	sample_size: u32, // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	channels: u32, // Number of channels (1-mono, 2-stereo, ...)
};

Sound :: struct
{
	stream: Audio_Stream, // Audio stream
	frame_count: u32, // Total number of frames (considering channels)
};

Music :: struct
{
	stream: Audio_Stream, // Audio stream
	frame_count: u32, // Total number of frames (considering channels)
	looping: bool, // Music looping enable
	ctx_type: i32, // Type of music context (audio filetype)
	ctx_data: rawptr, // Audio context data, depends on type
};

Vr_Device_Info :: struct
{
	h_resolution: i32, // Horizontal resolution in pixels
	v_resolution: i32, // Vertical resolution in pixels
	h_screen_size: f32, // Horizontal size in meters
	v_screen_size: f32, // Vertical size in meters
	v_screen_center: f32, // Screen center in meters
	eye_to_screen_distance: f32, // Distance between eye and display in meters
	lens_separation_distance: f32, // Lens separation distance in meters
	interpupillary_distance: f32, // IPD (distance between pupils) in meters
	lens_distortion_values: [4]f32, // Lens distortion constant parameters
	chroma_ab_correction: [4]f32, // Chromatic aberration correction parameters
};

Vr_Stereo_Config :: struct
{
	projection: [2]Matrix, // VR projection matrices (per eye)
	view_offset: [2]Matrix, // VR view offset matrices (per eye)
	left_lens_center: [2]f32, // VR left lens center
	right_lens_center: [2]f32, // VR right lens center
	left_screen_center: [2]f32, // VR left screen center
	right_screen_center: [2]f32, // VR right screen center
	scale: [2]f32, // VR distortion scale
	scale_in: [2]f32, // VR distortion scale in
};

Config_Flags :: enum u32
{
	FLAG_VSYNC_HINT = 64,
	FLAG_FULLSCREEN_MODE = 2,
	FLAG_WINDOW_RESIZABLE = 4,
	FLAG_WINDOW_UNDECORATED = 8,
	FLAG_WINDOW_HIDDEN = 128,
	FLAG_WINDOW_MINIMIZED = 512,
	FLAG_WINDOW_MAXIMIZED = 1024,
	FLAG_WINDOW_UNFOCUSED = 2048,
	FLAG_WINDOW_TOPMOST = 4096,
	FLAG_WINDOW_ALWAYS_RUN = 256,
	FLAG_WINDOW_TRANSPARENT = 16,
	FLAG_WINDOW_HIGHDPI = 8192,
	FLAG_MSAA_4X_HINT = 32,
	FLAG_INTERLACED_HINT = 65536,
};

Trace_Log_Level :: enum u32
{
	LOG_ALL = 0,
	LOG_TRACE = 1,
	LOG_DEBUG = 2,
	LOG_INFO = 3,
	LOG_WARNING = 4,
	LOG_ERROR = 5,
	LOG_FATAL = 6,
	LOG_NONE = 7,
};

Keyboard_Key :: enum u32
{
	KEY_NULL = 0,
	KEY_APOSTROPHE = 39,
	KEY_COMMA = 44,
	KEY_MINUS = 45,
	KEY_PERIOD = 46,
	KEY_SLASH = 47,
	KEY_ZERO = 48,
	KEY_ONE = 49,
	KEY_TWO = 50,
	KEY_THREE = 51,
	KEY_FOUR = 52,
	KEY_FIVE = 53,
	KEY_SIX = 54,
	KEY_SEVEN = 55,
	KEY_EIGHT = 56,
	KEY_NINE = 57,
	KEY_SEMICOLON = 59,
	KEY_EQUAL = 61,
	KEY_A = 65,
	KEY_B = 66,
	KEY_C = 67,
	KEY_D = 68,
	KEY_E = 69,
	KEY_F = 70,
	KEY_G = 71,
	KEY_H = 72,
	KEY_I = 73,
	KEY_J = 74,
	KEY_K = 75,
	KEY_L = 76,
	KEY_M = 77,
	KEY_N = 78,
	KEY_O = 79,
	KEY_P = 80,
	KEY_Q = 81,
	KEY_R = 82,
	KEY_S = 83,
	KEY_T = 84,
	KEY_U = 85,
	KEY_V = 86,
	KEY_W = 87,
	KEY_X = 88,
	KEY_Y = 89,
	KEY_Z = 90,
	KEY_LEFT_BRACKET = 91,
	KEY_BACKSLASH = 92,
	KEY_RIGHT_BRACKET = 93,
	KEY_GRAVE = 96,
	KEY_SPACE = 32,
	KEY_ESCAPE = 256,
	KEY_ENTER = 257,
	KEY_TAB = 258,
	KEY_BACKSPACE = 259,
	KEY_INSERT = 260,
	KEY_DELETE = 261,
	KEY_RIGHT = 262,
	KEY_LEFT = 263,
	KEY_DOWN = 264,
	KEY_UP = 265,
	KEY_PAGE_UP = 266,
	KEY_PAGE_DOWN = 267,
	KEY_HOME = 268,
	KEY_END = 269,
	KEY_CAPS_LOCK = 280,
	KEY_SCROLL_LOCK = 281,
	KEY_NUM_LOCK = 282,
	KEY_PRINT_SCREEN = 283,
	KEY_PAUSE = 284,
	KEY_F1 = 290,
	KEY_F2 = 291,
	KEY_F3 = 292,
	KEY_F4 = 293,
	KEY_F5 = 294,
	KEY_F6 = 295,
	KEY_F7 = 296,
	KEY_F8 = 297,
	KEY_F9 = 298,
	KEY_F10 = 299,
	KEY_F11 = 300,
	KEY_F12 = 301,
	KEY_LEFT_SHIFT = 340,
	KEY_LEFT_CONTROL = 341,
	KEY_LEFT_ALT = 342,
	KEY_LEFT_SUPER = 343,
	KEY_RIGHT_SHIFT = 344,
	KEY_RIGHT_CONTROL = 345,
	KEY_RIGHT_ALT = 346,
	KEY_RIGHT_SUPER = 347,
	KEY_KB_MENU = 348,
	KEY_KP_0 = 320,
	KEY_KP_1 = 321,
	KEY_KP_2 = 322,
	KEY_KP_3 = 323,
	KEY_KP_4 = 324,
	KEY_KP_5 = 325,
	KEY_KP_6 = 326,
	KEY_KP_7 = 327,
	KEY_KP_8 = 328,
	KEY_KP_9 = 329,
	KEY_KP_DECIMAL = 330,
	KEY_KP_DIVIDE = 331,
	KEY_KP_MULTIPLY = 332,
	KEY_KP_SUBTRACT = 333,
	KEY_KP_ADD = 334,
	KEY_KP_ENTER = 335,
	KEY_KP_EQUAL = 336,
	KEY_BACK = 4,
	KEY_MENU = 82,
	KEY_VOLUME_UP = 24,
	KEY_VOLUME_DOWN = 25,
};

Mouse_Button :: enum u32
{
	MOUSE_BUTTON_LEFT = 0,
	MOUSE_BUTTON_RIGHT = 1,
	MOUSE_BUTTON_MIDDLE = 2,
	MOUSE_BUTTON_SIDE = 3,
	MOUSE_BUTTON_EXTRA = 4,
	MOUSE_BUTTON_FORWARD = 5,
	MOUSE_BUTTON_BACK = 6,
};

Mouse_Cursor :: enum u32
{
	MOUSE_CURSOR_DEFAULT = 0,
	MOUSE_CURSOR_ARROW = 1,
	MOUSE_CURSOR_IBEAM = 2,
	MOUSE_CURSOR_CROSSHAIR = 3,
	MOUSE_CURSOR_POINTING_HAND = 4,
	MOUSE_CURSOR_RESIZE_EW = 5,
	MOUSE_CURSOR_RESIZE_NS = 6,
	MOUSE_CURSOR_RESIZE_NWSE = 7,
	MOUSE_CURSOR_RESIZE_NESW = 8,
	MOUSE_CURSOR_RESIZE_ALL = 9,
	MOUSE_CURSOR_NOT_ALLOWED = 10,
};

Gamepad_Button :: enum u32
{
	GAMEPAD_BUTTON_UNKNOWN = 0,
	GAMEPAD_BUTTON_LEFT_FACE_UP = 1,
	GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2,
	GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3,
	GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4,
	GAMEPAD_BUTTON_RIGHT_FACE_UP = 5,
	GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6,
	GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7,
	GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8,
	GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9,
	GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10,
	GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11,
	GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12,
	GAMEPAD_BUTTON_MIDDLE_LEFT = 13,
	GAMEPAD_BUTTON_MIDDLE = 14,
	GAMEPAD_BUTTON_MIDDLE_RIGHT = 15,
	GAMEPAD_BUTTON_LEFT_THUMB = 16,
	GAMEPAD_BUTTON_RIGHT_THUMB = 17,
};

Gamepad_Axis :: enum u32
{
	GAMEPAD_AXIS_LEFT_X = 0,
	GAMEPAD_AXIS_LEFT_Y = 1,
	GAMEPAD_AXIS_RIGHT_X = 2,
	GAMEPAD_AXIS_RIGHT_Y = 3,
	GAMEPAD_AXIS_LEFT_TRIGGER = 4,
	GAMEPAD_AXIS_RIGHT_TRIGGER = 5,
};

Material_Map_Index :: enum u32
{
	MATERIAL_MAP_ALBEDO = 0,
	MATERIAL_MAP_METALNESS = 1,
	MATERIAL_MAP_NORMAL = 2,
	MATERIAL_MAP_ROUGHNESS = 3,
	MATERIAL_MAP_OCCLUSION = 4,
	MATERIAL_MAP_EMISSION = 5,
	MATERIAL_MAP_HEIGHT = 6,
	MATERIAL_MAP_CUBEMAP = 7,
	MATERIAL_MAP_IRRADIANCE = 8,
	MATERIAL_MAP_PREFILTER = 9,
	MATERIAL_MAP_BRDG = 10,
};

Shader_Location_Index :: enum u32
{
	SHADER_LOC_VERTEX_POSITION = 0,
	SHADER_LOC_VERTEX_TEXCOORD01 = 1,
	SHADER_LOC_VERTEX_TEXCOORD02 = 2,
	SHADER_LOC_VERTEX_NORMAL = 3,
	SHADER_LOC_VERTEX_TANGENT = 4,
	SHADER_LOC_VERTEX_COLOR = 5,
	SHADER_LOC_MATRIX_MVP = 6,
	SHADER_LOC_MATRIX_VIEW = 7,
	SHADER_LOC_MATRIX_PROJECTION = 8,
	SHADER_LOC_MATRIX_MODEL = 9,
	SHADER_LOC_MATRIX_NORMAL = 10,
	SHADER_LOC_VECTOR_VIEW = 11,
	SHADER_LOC_COLOR_DIFFUSE = 12,
	SHADER_LOC_COLOR_SPECULAR = 13,
	SHADER_LOC_COLOR_AMBIENT = 14,
	SHADER_LOC_MAP_ALBEDO = 15,
	SHADER_LOC_MAP_METALNESS = 16,
	SHADER_LOC_MAP_NORMAL = 17,
	SHADER_LOC_MAP_ROUGHNESS = 18,
	SHADER_LOC_MAP_OCCLUSION = 19,
	SHADER_LOC_MAP_EMISSION = 20,
	SHADER_LOC_MAP_HEIGHT = 21,
	SHADER_LOC_MAP_CUBEMAP = 22,
	SHADER_LOC_MAP_IRRADIANCE = 23,
	SHADER_LOC_MAP_PREFILTER = 24,
	SHADER_LOC_MAP_BRDF = 25,
};

Shader_Uniform_Data_Type :: enum u32
{
	SHADER_UNIFORM_FLOAT = 0,
	SHADER_UNIFORM_VEC2 = 1,
	SHADER_UNIFORM_VEC3 = 2,
	SHADER_UNIFORM_VEC4 = 3,
	SHADER_UNIFORM_INT = 4,
	SHADER_UNIFORM_IVEC2 = 5,
	SHADER_UNIFORM_IVEC3 = 6,
	SHADER_UNIFORM_IVEC4 = 7,
	SHADER_UNIFORM_SAMPLER2D = 8,
};

Shader_Attribute_Data_Type :: enum u32
{
	SHADER_ATTRIB_FLOAT = 0,
	SHADER_ATTRIB_VEC2 = 1,
	SHADER_ATTRIB_VEC3 = 2,
	SHADER_ATTRIB_VEC4 = 3,
};

Pixel_Format :: enum u32
{
	PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1,
	PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2,
	PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3,
	PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4,
	PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5,
	PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6,
	PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7,
	PIXELFORMAT_UNCOMPRESSED_R32 = 8,
	PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9,
	PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10,
	PIXELFORMAT_COMPRESSED_DXT1_RGB = 11,
	PIXELFORMAT_COMPRESSED_DXT1_RGBA = 12,
	PIXELFORMAT_COMPRESSED_DXT3_RGBA = 13,
	PIXELFORMAT_COMPRESSED_DXT5_RGBA = 14,
	PIXELFORMAT_COMPRESSED_ETC1_RGB = 15,
	PIXELFORMAT_COMPRESSED_ETC2_RGB = 16,
	PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 17,
	PIXELFORMAT_COMPRESSED_PVRT_RGB = 18,
	PIXELFORMAT_COMPRESSED_PVRT_RGBA = 19,
	PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 20,
	PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 21,
};

Texture_Filter :: enum u32
{
	TEXTURE_FILTER_POINT = 0,
	TEXTURE_FILTER_BILINEAR = 1,
	TEXTURE_FILTER_TRILINEAR = 2,
	TEXTURE_FILTER_ANISOTROPIC_4X = 3,
	TEXTURE_FILTER_ANISOTROPIC_8X = 4,
	TEXTURE_FILTER_ANISOTROPIC_16X = 5,
};

Texture_Wrap :: enum u32
{
	TEXTURE_WRAP_REPEAT = 0,
	TEXTURE_WRAP_CLAMP = 1,
	TEXTURE_WRAP_MIRROR_REPEAT = 2,
	TEXTURE_WRAP_MIRROR_CLAMP = 3,
};

Cubemap_Layout :: enum u32
{
	CUBEMAP_LAYOUT_AUTO_DETECT = 0,
	CUBEMAP_LAYOUT_LINE_VERTICAL = 1,
	CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2,
	CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3,
	CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4,
	CUBEMAP_LAYOUT_PANORAMA = 5,
};

Font_Type :: enum u32
{
	FONT_DEFAULT = 0,
	FONT_BITMAP = 1,
	FONT_SDF = 2,
};

Blend_Mode :: enum u32
{
	BLEND_ALPHA = 0,
	BLEND_ADDITIVE = 1,
	BLEND_MULTIPLIED = 2,
	BLEND_ADD_COLORS = 3,
	BLEND_SUBTRACT_COLORS = 4,
	BLEND_CUSTOM = 5,
};

Gesture :: enum u32
{
	GESTURE_NONE = 0,
	GESTURE_TAP = 1,
	GESTURE_DOUBLETAP = 2,
	GESTURE_HOLD = 4,
	GESTURE_DRAG = 8,
	GESTURE_SWIPE_RIGHT = 16,
	GESTURE_SWIPE_LEFT = 32,
	GESTURE_SWIPE_UP = 64,
	GESTURE_SWIPE_DOWN = 128,
	GESTURE_PINCH_IN = 256,
	GESTURE_PINCH_OUT = 512,
};

Camera_Mode :: enum u32
{
	CAMERA_CUSTOM = 0,
	CAMERA_FREE = 1,
	CAMERA_ORBITAL = 2,
	CAMERA_FIRST_PERSON = 3,
	CAMERA_THIRD_PERSON = 4,
};

Camera_Projection :: enum u32
{
	CAMERA_PERSPECTIVE = 0,
	CAMERA_ORTHOGRAPHIC = 1,
};

N_Patch_Layout :: enum u32
{
	NPATCH_NINE_PATCH = 0,
	NPATCH_THREE_PATCH_VERTICAL = 1,
	NPATCH_THREE_PATCH_HORIZONTAL = 2,
};

@(default_calling_convention="c")
foreign raylib
{

	// Initialize window and OpenGL context
	@(link_name="InitWindow")
	init_window :: proc(width: i32, height: i32, title: cstring) ---;

	// Check if KEY_ESCAPE pressed or Close icon pressed
	@(link_name="WindowShouldClose")
	window_should_close :: proc() -> bool ---;

	// Close window and unload OpenGL context
	@(link_name="CloseWindow")
	close_window :: proc() ---;

	// Check if window has been initialized successfully
	@(link_name="IsWindowReady")
	is_window_ready :: proc() -> bool ---;

	// Check if window is currently fullscreen
	@(link_name="IsWindowFullscreen")
	is_window_fullscreen :: proc() -> bool ---;

	// Check if window is currently hidden (only PLATFORM_DESKTOP)
	@(link_name="IsWindowHidden")
	is_window_hidden :: proc() -> bool ---;

	// Check if window is currently minimized (only PLATFORM_DESKTOP)
	@(link_name="IsWindowMinimized")
	is_window_minimized :: proc() -> bool ---;

	// Check if window is currently maximized (only PLATFORM_DESKTOP)
	@(link_name="IsWindowMaximized")
	is_window_maximized :: proc() -> bool ---;

	// Check if window is currently focused (only PLATFORM_DESKTOP)
	@(link_name="IsWindowFocused")
	is_window_focused :: proc() -> bool ---;

	// Check if window has been resized last frame
	@(link_name="IsWindowResized")
	is_window_resized :: proc() -> bool ---;

	// Check if one specific window flag is enabled
	@(link_name="IsWindowState")
	is_window_state :: proc(flag: u32) -> bool ---;

	// Set window configuration state using flags
	@(link_name="SetWindowState")
	set_window_state :: proc(flags: u32) ---;

	// Clear window configuration state flags
	@(link_name="ClearWindowState")
	clear_window_state :: proc(flags: u32) ---;

	// Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
	@(link_name="ToggleFullscreen")
	toggle_fullscreen :: proc() ---;

	// Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
	@(link_name="MaximizeWindow")
	maximize_window :: proc() ---;

	// Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
	@(link_name="MinimizeWindow")
	minimize_window :: proc() ---;

	// Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
	@(link_name="RestoreWindow")
	restore_window :: proc() ---;

	// Set icon for window (only PLATFORM_DESKTOP)
	@(link_name="SetWindowIcon")
	set_window_icon :: proc(image: Image) ---;

	// Set title for window (only PLATFORM_DESKTOP)
	@(link_name="SetWindowTitle")
	set_window_title :: proc(title: cstring) ---;

	// Set window position on screen (only PLATFORM_DESKTOP)
	@(link_name="SetWindowPosition")
	set_window_position :: proc(x: i32, y: i32) ---;

	// Set monitor for the current window (fullscreen mode)
	@(link_name="SetWindowMonitor")
	set_window_monitor :: proc(monitor: i32) ---;

	// Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
	@(link_name="SetWindowMinSize")
	set_window_min_size :: proc(width: i32, height: i32) ---;

	// Set window dimensions
	@(link_name="SetWindowSize")
	set_window_size :: proc(width: i32, height: i32) ---;

	// Get native window handle
	@(link_name="GetWindowHandle")
	get_window_handle :: proc() -> rawptr ---;

	// Get current screen width
	@(link_name="GetScreenWidth")
	get_screen_width :: proc() -> i32 ---;

	// Get current screen height
	@(link_name="GetScreenHeight")
	get_screen_height :: proc() -> i32 ---;

	// Get number of connected monitors
	@(link_name="GetMonitorCount")
	get_monitor_count :: proc() -> i32 ---;

	// Get current connected monitor
	@(link_name="GetCurrentMonitor")
	get_current_monitor :: proc() -> i32 ---;

	// Get specified monitor position
	@(link_name="GetMonitorPosition")
	get_monitor_position :: proc(monitor: i32) -> Vector2 ---;

	// Get specified monitor width (max available by monitor)
	@(link_name="GetMonitorWidth")
	get_monitor_width :: proc(monitor: i32) -> i32 ---;

	// Get specified monitor height (max available by monitor)
	@(link_name="GetMonitorHeight")
	get_monitor_height :: proc(monitor: i32) -> i32 ---;

	// Get specified monitor physical width in millimetres
	@(link_name="GetMonitorPhysicalWidth")
	get_monitor_physical_width :: proc(monitor: i32) -> i32 ---;

	// Get specified monitor physical height in millimetres
	@(link_name="GetMonitorPhysicalHeight")
	get_monitor_physical_height :: proc(monitor: i32) -> i32 ---;

	// Get specified monitor refresh rate
	@(link_name="GetMonitorRefreshRate")
	get_monitor_refresh_rate :: proc(monitor: i32) -> i32 ---;

	// Get window position XY on monitor
	@(link_name="GetWindowPosition")
	get_window_position :: proc() -> Vector2 ---;

	// Get window scale DPI factor
	@(link_name="GetWindowScaleDPI")
	get_window_scale_dpi :: proc() -> Vector2 ---;

	// Get the human-readable, UTF-8 encoded name of the primary monitor
	@(link_name="GetMonitorName")
	get_monitor_name :: proc(monitor: i32) -> cstring ---;

	// Set clipboard text content
	@(link_name="SetClipboardText")
	set_clipboard_text :: proc(text: cstring) ---;

	// Get clipboard text content
	@(link_name="GetClipboardText")
	get_clipboard_text :: proc() -> cstring ---;

	// Swap back buffer with front buffer (screen drawing)
	@(link_name="SwapScreenBuffer")
	swap_screen_buffer :: proc() ---;

	// Register all input events
	@(link_name="PollInputEvents")
	poll_input_events :: proc() ---;

	// Wait for some milliseconds (halt program execution)
	@(link_name="WaitTime")
	wait_time :: proc(ms: f32) ---;

	// Hides cursor
	@(link_name="HideCursor")
	hide_cursor :: proc() ---;

	// Check if cursor is not visible
	@(link_name="IsCursorHidden")
	is_cursor_hidden :: proc() -> bool ---;

	// Enables cursor (unlock cursor)
	@(link_name="EnableCursor")
	enable_cursor :: proc() ---;

	// Disables cursor (lock cursor)
	@(link_name="DisableCursor")
	disable_cursor :: proc() ---;

	// Check if cursor is on the screen
	@(link_name="IsCursorOnScreen")
	is_cursor_on_screen :: proc() -> bool ---;

	// Set background color (framebuffer clear color)
	@(link_name="ClearBackground")
	clear_background :: proc(color: Color) ---;

	// Setup canvas (framebuffer) to start drawing
	@(link_name="BeginDrawing")
	begin_drawing :: proc() ---;

	// End canvas drawing and swap buffers (double buffering)
	@(link_name="EndDrawing")
	end_drawing :: proc() ---;

	// Begin 2D mode with custom camera (2D)
	@(link_name="BeginMode2D")
	begin_mode2d :: proc(camera: Camera2d) ---;

	// Ends 2D mode with custom camera
	@(link_name="EndMode2D")
	end_mode2d :: proc() ---;

	// Begin 3D mode with custom camera (3D)
	@(link_name="BeginMode3D")
	begin_mode3d :: proc(camera: Camera3d) ---;

	// Ends 3D mode and returns to default 2D orthographic mode
	@(link_name="EndMode3D")
	end_mode3d :: proc() ---;

	// Begin drawing to render texture
	@(link_name="BeginTextureMode")
	begin_texture_mode :: proc(target: Render_Texture2d) ---;

	// Ends drawing to render texture
	@(link_name="EndTextureMode")
	end_texture_mode :: proc() ---;

	// Begin custom shader drawing
	@(link_name="BeginShaderMode")
	begin_shader_mode :: proc(shader: Shader) ---;

	// End custom shader drawing (use default shader)
	@(link_name="EndShaderMode")
	end_shader_mode :: proc() ---;

	// Begin blending mode (alpha, additive, multiplied, subtract, custom)
	@(link_name="BeginBlendMode")
	begin_blend_mode :: proc(mode: Blend_Mode) ---;

	// End blending mode (reset to default: alpha blending)
	@(link_name="EndBlendMode")
	end_blend_mode :: proc() ---;

	// Begin scissor mode (define screen area for following drawing)
	@(link_name="BeginScissorMode")
	begin_scissor_mode :: proc(x: i32, y: i32, width: i32, height: i32) ---;

	// End scissor mode
	@(link_name="EndScissorMode")
	end_scissor_mode :: proc() ---;

	// Begin stereo rendering (requires VR simulator)
	@(link_name="BeginVrStereoMode")
	begin_vr_stereo_mode :: proc(config: Vr_Stereo_Config) ---;

	// End stereo rendering (requires VR simulator)
	@(link_name="EndVrStereoMode")
	end_vr_stereo_mode :: proc() ---;

	// Load VR stereo config for VR simulator device parameters
	@(link_name="LoadVrStereoConfig")
	load_vr_stereo_config :: proc(device: Vr_Device_Info) -> Vr_Stereo_Config ---;

	// Unload VR stereo config
	@(link_name="UnloadVrStereoConfig")
	unload_vr_stereo_config :: proc(config: Vr_Stereo_Config) ---;

	// Load shader from files and bind default locations
	@(link_name="LoadShader")
	load_shader :: proc(vs_file_name: cstring, fs_file_name: cstring) -> Shader ---;

	// Load shader from code strings and bind default locations
	@(link_name="LoadShaderFromMemory")
	load_shader_from_memory :: proc(vs_code: cstring, fs_code: cstring) -> Shader ---;

	// Get shader uniform location
	@(link_name="GetShaderLocation")
	get_shader_location :: proc(shader: Shader, uniform_name: cstring) -> i32 ---;

	// Get shader attribute location
	@(link_name="GetShaderLocationAttrib")
	get_shader_location_attrib :: proc(shader: Shader, attrib_name: cstring) -> i32 ---;

	// Set shader uniform value
	@(link_name="SetShaderValue")
	set_shader_value :: proc(shader: Shader, loc_index: Shader_Location_Index, value: rawptr, uniform_type: Shader_Uniform_Data_Type) ---;

	// Set shader uniform value vector
	@(link_name="SetShaderValueV")
	set_shader_value_v :: proc(shader: Shader, loc_index: Shader_Location_Index, value: rawptr, uniform_type: Shader_Uniform_Data_Type, count: i32) ---;

	// Set shader uniform value (matrix 4x4)
	@(link_name="SetShaderValueMatrix")
	set_shader_value_matrix :: proc(shader: Shader, loc_index: Shader_Location_Index, mat: Matrix) ---;

	// Set shader uniform value for texture (sampler2d)
	@(link_name="SetShaderValueTexture")
	set_shader_value_texture :: proc(shader: Shader, loc_index: Shader_Location_Index, texture: Texture2d) ---;

	// Unload shader from GPU memory (VRAM)
	@(link_name="UnloadShader")
	unload_shader :: proc(shader: Shader) ---;

	// Get a ray trace from mouse position
	@(link_name="GetMouseRay")
	get_mouse_ray :: proc(mouse_position: Vector2, camera: Camera) -> Ray ---;

	// Get camera transform matrix (view matrix)
	@(link_name="GetCameraMatrix")
	get_camera_matrix :: proc(camera: Camera) -> Matrix ---;

	// Get camera 2d transform matrix
	@(link_name="GetCameraMatrix2D")
	get_camera_matrix2d :: proc(camera: Camera2d) -> Matrix ---;

	// Get the screen space position for a 3d world space position
	@(link_name="GetWorldToScreen")
	get_world_to_screen :: proc(position: Vector3, camera: Camera) -> Vector2 ---;

	// Get size position for a 3d world space position
	@(link_name="GetWorldToScreenEx")
	get_world_to_screen_ex :: proc(position: Vector3, camera: Camera, width: i32, height: i32) -> Vector2 ---;

	// Get the screen space position for a 2d camera world space position
	@(link_name="GetWorldToScreen2D")
	get_world_to_screen2d :: proc(position: Vector2, camera: Camera2d) -> Vector2 ---;

	// Get the world space position for a 2d camera screen space position
	@(link_name="GetScreenToWorld2D")
	get_screen_to_world2d :: proc(position: Vector2, camera: Camera2d) -> Vector2 ---;

	// Set target FPS (maximum)
	@(link_name="SetTargetFPS")
	set_target_fps :: proc(fps: i32) ---;

	// Get current FPS
	@(link_name="GetFPS")
	get_fps :: proc() -> i32 ---;

	// Get time in seconds for last frame drawn (delta time)
	@(link_name="GetFrameTime")
	get_frame_time :: proc() -> f32 ---;

	// Get elapsed time in seconds since InitWindow()
	@(link_name="GetTime")
	get_time :: proc() -> f64 ---;

	// Get a random value between min and max (both included)
	@(link_name="GetRandomValue")
	get_random_value :: proc(min: i32, max: i32) -> i32 ---;

	// Set the seed for the random number generator
	@(link_name="SetRandomSeed")
	set_random_seed :: proc(seed: u32) ---;

	// Takes a screenshot of current screen (filename extension defines format)
	@(link_name="TakeScreenshot")
	take_screenshot :: proc(file_name: cstring) ---;

	// Setup init configuration flags (view FLAGS)
	@(link_name="SetConfigFlags")
	set_config_flags :: proc(flags: Config_Flags) ---;

	// Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
	@(link_name="TraceLog")
	trace_log :: proc(log_level: Trace_Log_Level, text: cstring, #c_vararg args: ..any) ---;

	// Set the current threshold (minimum) log level
	@(link_name="SetTraceLogLevel")
	set_trace_log_level :: proc(log_level: i32) ---;

	// Internal memory allocator
	@(link_name="MemAlloc")
	mem_alloc :: proc(size: i32) -> rawptr ---;

	// Internal memory reallocator
	@(link_name="MemRealloc")
	mem_realloc :: proc(ptr: rawptr, size: i32) -> rawptr ---;

	// Internal memory free
	@(link_name="MemFree")
	mem_free :: proc(ptr: rawptr) ---;

	// Set custom trace log
	@(link_name="SetTraceLogCallback")
	set_trace_log_callback :: proc(callback: Trace_Log_Callback) ---;

	// Set custom file binary data loader
	@(link_name="SetLoadFileDataCallback")
	set_load_file_data_callback :: proc(callback: Load_File_Data_Callback) ---;

	// Set custom file binary data saver
	@(link_name="SetSaveFileDataCallback")
	set_save_file_data_callback :: proc(callback: Save_File_Data_Callback) ---;

	// Set custom file text data loader
	@(link_name="SetLoadFileTextCallback")
	set_load_file_text_callback :: proc(callback: Load_File_Text_Callback) ---;

	// Set custom file text data saver
	@(link_name="SetSaveFileTextCallback")
	set_save_file_text_callback :: proc(callback: Save_File_Text_Callback) ---;

	// Load file data as byte array (read)
	@(link_name="LoadFileData")
	load_file_data :: proc(file_name: cstring, bytes_read: ^u32) -> ^u8 ---;

	// Unload file data allocated by LoadFileData()
	@(link_name="UnloadFileData")
	unload_file_data :: proc(data: ^u8) ---;

	// Save data to file from byte array (write), returns true on success
	@(link_name="SaveFileData")
	save_file_data :: proc(file_name: cstring, data: rawptr, bytes_to_write: u32) -> bool ---;

	// Load text data from file (read), returns a ' 0' terminated string
	@(link_name="LoadFileText")
	load_file_text :: proc(file_name: cstring) -> ^u8 ---;

	// Unload file text data allocated by LoadFileText()
	@(link_name="UnloadFileText")
	unload_file_text :: proc(text: ^u8) ---;

	// Save text data to file (write), string must be ' 0' terminated, returns true on success
	@(link_name="SaveFileText")
	save_file_text :: proc(file_name: cstring, text: ^u8) -> bool ---;

	// Check if file exists
	@(link_name="FileExists")
	file_exists :: proc(file_name: cstring) -> bool ---;

	// Check if a directory path exists
	@(link_name="DirectoryExists")
	directory_exists :: proc(dir_path: cstring) -> bool ---;

	// Check file extension (including point: .png, .wav)
	@(link_name="IsFileExtension")
	is_file_extension :: proc(file_name: cstring, ext: cstring) -> bool ---;

	// Get pointer to extension for a filename string (includes dot: '.png')
	@(link_name="GetFileExtension")
	get_file_extension :: proc(file_name: cstring) -> cstring ---;

	// Get pointer to filename for a path string
	@(link_name="GetFileName")
	get_file_name :: proc(file_path: cstring) -> cstring ---;

	// Get filename string without extension (uses static string)
	@(link_name="GetFileNameWithoutExt")
	get_file_name_without_ext :: proc(file_path: cstring) -> cstring ---;

	// Get full path for a given fileName with path (uses static string)
	@(link_name="GetDirectoryPath")
	get_directory_path :: proc(file_path: cstring) -> cstring ---;

	// Get previous directory path for a given path (uses static string)
	@(link_name="GetPrevDirectoryPath")
	get_prev_directory_path :: proc(dir_path: cstring) -> cstring ---;

	// Get current working directory (uses static string)
	@(link_name="GetWorkingDirectory")
	get_working_directory :: proc() -> cstring ---;

	// Get filenames in a directory path (memory should be freed)
	@(link_name="GetDirectoryFiles")
	get_directory_files :: proc(dir_path: cstring, count: ^i32) -> ^cstring ---;

	// Clear directory files paths buffers (free memory)
	@(link_name="ClearDirectoryFiles")
	clear_directory_files :: proc() ---;

	// Change working directory, return true on success
	@(link_name="ChangeDirectory")
	change_directory :: proc(dir: cstring) -> bool ---;

	// Check if a file has been dropped into window
	@(link_name="IsFileDropped")
	is_file_dropped :: proc() -> bool ---;

	// Get dropped files names (memory should be freed)
	@(link_name="GetDroppedFiles")
	get_dropped_files :: proc(count: ^i32) -> ^cstring ---;

	// Clear dropped files paths buffer (free memory)
	@(link_name="ClearDroppedFiles")
	clear_dropped_files :: proc() ---;

	// Get file modification time (last write time)
	@(link_name="GetFileModTime")
	get_file_mod_time :: proc(file_name: cstring) -> i32 ---;

	// Compress data (DEFLATE algorithm)
	@(link_name="CompressData")
	compress_data :: proc(data: ^u8, data_length: i32, comp_data_length: ^i32) -> ^u8 ---;

	// Decompress data (DEFLATE algorithm)
	@(link_name="DecompressData")
	decompress_data :: proc(comp_data: ^u8, comp_data_length: i32, data_length: ^i32) -> ^u8 ---;

	// Save integer value to storage file (to defined position), returns true on success
	@(link_name="SaveStorageValue")
	save_storage_value :: proc(position: u32, value: i32) -> bool ---;

	// Load integer value from storage file (from defined position)
	@(link_name="LoadStorageValue")
	load_storage_value :: proc(position: u32) -> i32 ---;

	// Open URL with default system browser (if available)
	@(link_name="OpenURL")
	open_url :: proc(url: cstring) ---;

	// Check if a key has been pressed once
	@(link_name="IsKeyPressed")
	is_key_pressed :: proc(key: Keyboard_Key) -> bool ---;

	// Check if a key is being pressed
	@(link_name="IsKeyDown")
	is_key_down :: proc(key: Keyboard_Key) -> bool ---;

	// Check if a key has been released once
	@(link_name="IsKeyReleased")
	is_key_released :: proc(key: Keyboard_Key) -> bool ---;

	// Check if a key is NOT being pressed
	@(link_name="IsKeyUp")
	is_key_up :: proc(key: Keyboard_Key) -> bool ---;

	// Set a custom key to exit program (default is ESC)
	@(link_name="SetExitKey")
	set_exit_key :: proc(key: Keyboard_Key) ---;

	// Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
	@(link_name="GetKeyPressed")
	get_key_pressed :: proc() -> i32 ---;

	// Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
	@(link_name="GetCharPressed")
	get_char_pressed :: proc() -> i32 ---;

	// Check if a gamepad is available
	@(link_name="IsGamepadAvailable")
	is_gamepad_available :: proc(gamepad: i32) -> bool ---;

	// Check gamepad name (if available)
	@(link_name="IsGamepadName")
	is_gamepad_name :: proc(gamepad: i32, name: cstring) -> bool ---;

	// Get gamepad internal name id
	@(link_name="GetGamepadName")
	get_gamepad_name :: proc(gamepad: i32) -> cstring ---;

	// Check if a gamepad button has been pressed once
	@(link_name="IsGamepadButtonPressed")
	is_gamepad_button_pressed :: proc(gamepad: i32, button: Gamepad_Button) -> bool ---;

	// Check if a gamepad button is being pressed
	@(link_name="IsGamepadButtonDown")
	is_gamepad_button_down :: proc(gamepad: i32, button: Gamepad_Button) -> bool ---;

	// Check if a gamepad button has been released once
	@(link_name="IsGamepadButtonReleased")
	is_gamepad_button_released :: proc(gamepad: i32, button: Gamepad_Button) -> bool ---;

	// Check if a gamepad button is NOT being pressed
	@(link_name="IsGamepadButtonUp")
	is_gamepad_button_up :: proc(gamepad: i32, button: Gamepad_Button) -> bool ---;

	// Get the last gamepad button pressed
	@(link_name="GetGamepadButtonPressed")
	get_gamepad_button_pressed :: proc() -> i32 ---;

	// Get gamepad axis count for a gamepad
	@(link_name="GetGamepadAxisCount")
	get_gamepad_axis_count :: proc(gamepad: i32) -> i32 ---;

	// Get axis movement value for a gamepad axis
	@(link_name="GetGamepadAxisMovement")
	get_gamepad_axis_movement :: proc(gamepad: i32, axis: Gamepad_Axis) -> f32 ---;

	// Set internal gamepad mappings (SDL_GameControllerDB)
	@(link_name="SetGamepadMappings")
	set_gamepad_mappings :: proc(mappings: cstring) -> i32 ---;

	// Check if a mouse button has been pressed once
	@(link_name="IsMouseButtonPressed")
	is_mouse_button_pressed :: proc(button: Mouse_Button) -> bool ---;

	// Check if a mouse button is being pressed
	@(link_name="IsMouseButtonDown")
	is_mouse_button_down :: proc(button: Mouse_Button) -> bool ---;

	// Check if a mouse button has been released once
	@(link_name="IsMouseButtonReleased")
	is_mouse_button_released :: proc(button: Mouse_Button) -> bool ---;

	// Check if a mouse button is NOT being pressed
	@(link_name="IsMouseButtonUp")
	is_mouse_button_up :: proc(button: Mouse_Button) -> bool ---;

	// Get mouse position X
	@(link_name="GetMouseX")
	get_mouse_x :: proc() -> i32 ---;

	// Get mouse position Y
	@(link_name="GetMouseY")
	get_mouse_y :: proc() -> i32 ---;

	// Get mouse position XY
	@(link_name="GetMousePosition")
	get_mouse_position :: proc() -> Vector2 ---;

	// Get mouse delta between frames
	@(link_name="GetMouseDelta")
	get_mouse_delta :: proc() -> Vector2 ---;

	// Set mouse position XY
	@(link_name="SetMousePosition")
	set_mouse_position :: proc(x: i32, y: i32) ---;

	// Set mouse offset
	@(link_name="SetMouseOffset")
	set_mouse_offset :: proc(offset_x: i32, offset_y: i32) ---;

	// Set mouse scaling
	@(link_name="SetMouseScale")
	set_mouse_scale :: proc(scale_x: f32, scale_y: f32) ---;

	// Get mouse wheel movement Y
	@(link_name="GetMouseWheelMove")
	get_mouse_wheel_move :: proc() -> f32 ---;

	// Set mouse cursor
	@(link_name="SetMouseCursor")
	set_mouse_cursor :: proc(cursor: Mouse_Cursor) ---;

	// Get touch position X for touch point 0 (relative to screen size)
	@(link_name="GetTouchX")
	get_touch_x :: proc() -> i32 ---;

	// Get touch position Y for touch point 0 (relative to screen size)
	@(link_name="GetTouchY")
	get_touch_y :: proc() -> i32 ---;

	// Get touch position XY for a touch point index (relative to screen size)
	@(link_name="GetTouchPosition")
	get_touch_position :: proc(index: i32) -> Vector2 ---;

	// Get touch point identifier for given index
	@(link_name="GetTouchPointId")
	get_touch_point_id :: proc(index: i32) -> i32 ---;

	// Get number of touch points
	@(link_name="GetTouchPointCount")
	get_touch_point_count :: proc() -> i32 ---;

	// Get last touch event registered
	@(link_name="GetTouchEvent")
	get_touch_event :: proc() -> i32 ---;

	// Enable a set of gestures using flags
	@(link_name="SetGesturesEnabled")
	set_gestures_enabled :: proc(flags: u32) ---;

	// Check if a gesture have been detected
	@(link_name="IsGestureDetected")
	is_gesture_detected :: proc(gesture: Gesture) -> bool ---;

	// Get latest detected gesture
	@(link_name="GetGestureDetected")
	get_gesture_detected :: proc() -> i32 ---;

	// Get gesture hold time in milliseconds
	@(link_name="GetGestureHoldDuration")
	get_gesture_hold_duration :: proc() -> f32 ---;

	// Get gesture drag vector
	@(link_name="GetGestureDragVector")
	get_gesture_drag_vector :: proc() -> Vector2 ---;

	// Get gesture drag angle
	@(link_name="GetGestureDragAngle")
	get_gesture_drag_angle :: proc() -> f32 ---;

	// Get gesture pinch delta
	@(link_name="GetGesturePinchVector")
	get_gesture_pinch_vector :: proc() -> Vector2 ---;

	// Get gesture pinch angle
	@(link_name="GetGesturePinchAngle")
	get_gesture_pinch_angle :: proc() -> f32 ---;

	// Set camera mode (multiple camera modes available)
	@(link_name="SetCameraMode")
	set_camera_mode :: proc(camera: Camera, mode: Camera_Mode) ---;

	// Update camera position for selected mode
	@(link_name="UpdateCamera")
	update_camera :: proc(camera: ^Camera) ---;

	// Set camera pan key to combine with mouse movement (free camera)
	@(link_name="SetCameraPanControl")
	set_camera_pan_control :: proc(key_pan: i32) ---;

	// Set camera alt key to combine with mouse movement (free camera)
	@(link_name="SetCameraAltControl")
	set_camera_alt_control :: proc(key_alt: i32) ---;

	// Set camera smooth zoom key to combine with mouse (free camera)
	@(link_name="SetCameraSmoothZoomControl")
	set_camera_smooth_zoom_control :: proc(key_smooth_zoom: i32) ---;

	// Set camera move controls (1st person and 3rd person cameras)
	@(link_name="SetCameraMoveControls")
	set_camera_move_controls :: proc(key_front: i32, key_back: i32, key_right: i32, key_left: i32, key_up: i32, key_down: i32) ---;

	// Set texture and rectangle to be used on shapes drawing
	@(link_name="SetShapesTexture")
	set_shapes_texture :: proc(texture: Texture2d, source: Rectangle) ---;

	// Draw a pixel
	@(link_name="DrawPixel")
	draw_pixel :: proc(pos_x: i32, pos_y: i32, color: Color) ---;

	// Draw a pixel (Vector version)
	@(link_name="DrawPixelV")
	draw_pixel_v :: proc(position: Vector2, color: Color) ---;

	// Draw a line
	@(link_name="DrawLine")
	draw_line :: proc(start_pos_x: i32, start_pos_y: i32, end_pos_x: i32, end_pos_y: i32, color: Color) ---;

	// Draw a line (Vector version)
	@(link_name="DrawLineV")
	draw_line_v :: proc(start_pos: Vector2, end_pos: Vector2, color: Color) ---;

	// Draw a line defining thickness
	@(link_name="DrawLineEx")
	draw_line_ex :: proc(start_pos: Vector2, end_pos: Vector2, thick: f32, color: Color) ---;

	// Draw a line using cubic-bezier curves in-out
	@(link_name="DrawLineBezier")
	draw_line_bezier :: proc(start_pos: Vector2, end_pos: Vector2, thick: f32, color: Color) ---;

	// raw line using quadratic bezier curves with a control point
	@(link_name="DrawLineBezierQuad")
	draw_line_bezier_quad :: proc(start_pos: Vector2, end_pos: Vector2, control_pos: Vector2, thick: f32, color: Color) ---;

	// Draw lines sequence
	@(link_name="DrawLineStrip")
	draw_line_strip :: proc(points: ^Vector2, point_count: i32, color: Color) ---;

	// Draw a color-filled circle
	@(link_name="DrawCircle")
	draw_circle :: proc(center_x: i32, center_y: i32, radius: f32, color: Color) ---;

	// Draw a piece of a circle
	@(link_name="DrawCircleSector")
	draw_circle_sector :: proc(center: Vector2, radius: f32, start_angle: f32, end_angle: f32, segments: i32, color: Color) ---;

	// Draw circle sector outline
	@(link_name="DrawCircleSectorLines")
	draw_circle_sector_lines :: proc(center: Vector2, radius: f32, start_angle: f32, end_angle: f32, segments: i32, color: Color) ---;

	// Draw a gradient-filled circle
	@(link_name="DrawCircleGradient")
	draw_circle_gradient :: proc(center_x: i32, center_y: i32, radius: f32, color1: Color, color2: Color) ---;

	// Draw a color-filled circle (Vector version)
	@(link_name="DrawCircleV")
	draw_circle_v :: proc(center: Vector2, radius: f32, color: Color) ---;

	// Draw circle outline
	@(link_name="DrawCircleLines")
	draw_circle_lines :: proc(center_x: i32, center_y: i32, radius: f32, color: Color) ---;

	// Draw ellipse
	@(link_name="DrawEllipse")
	draw_ellipse :: proc(center_x: i32, center_y: i32, radius_h: f32, radius_v: f32, color: Color) ---;

	// Draw ellipse outline
	@(link_name="DrawEllipseLines")
	draw_ellipse_lines :: proc(center_x: i32, center_y: i32, radius_h: f32, radius_v: f32, color: Color) ---;

	// Draw ring
	@(link_name="DrawRing")
	draw_ring :: proc(center: Vector2, inner_radius: f32, outer_radius: f32, start_angle: f32, end_angle: f32, segments: i32, color: Color) ---;

	// Draw ring outline
	@(link_name="DrawRingLines")
	draw_ring_lines :: proc(center: Vector2, inner_radius: f32, outer_radius: f32, start_angle: f32, end_angle: f32, segments: i32, color: Color) ---;

	// Draw a color-filled rectangle
	@(link_name="DrawRectangle")
	draw_rectangle :: proc(pos_x: i32, pos_y: i32, width: i32, height: i32, color: Color) ---;

	// Draw a color-filled rectangle (Vector version)
	@(link_name="DrawRectangleV")
	draw_rectangle_v :: proc(position: Vector2, size: Vector2, color: Color) ---;

	// Draw a color-filled rectangle
	@(link_name="DrawRectangleRec")
	draw_rectangle_rec :: proc(rec: Rectangle, color: Color) ---;

	// Draw a color-filled rectangle with pro parameters
	@(link_name="DrawRectanglePro")
	draw_rectangle_pro :: proc(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) ---;

	// Draw a vertical-gradient-filled rectangle
	@(link_name="DrawRectangleGradientV")
	draw_rectangle_gradient_v :: proc(pos_x: i32, pos_y: i32, width: i32, height: i32, color1: Color, color2: Color) ---;

	// Draw a horizontal-gradient-filled rectangle
	@(link_name="DrawRectangleGradientH")
	draw_rectangle_gradient_h :: proc(pos_x: i32, pos_y: i32, width: i32, height: i32, color1: Color, color2: Color) ---;

	// Draw a gradient-filled rectangle with custom vertex colors
	@(link_name="DrawRectangleGradientEx")
	draw_rectangle_gradient_ex :: proc(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color) ---;

	// Draw rectangle outline
	@(link_name="DrawRectangleLines")
	draw_rectangle_lines :: proc(pos_x: i32, pos_y: i32, width: i32, height: i32, color: Color) ---;

	// Draw rectangle outline with extended parameters
	@(link_name="DrawRectangleLinesEx")
	draw_rectangle_lines_ex :: proc(rec: Rectangle, line_thick: f32, color: Color) ---;

	// Draw rectangle with rounded edges
	@(link_name="DrawRectangleRounded")
	draw_rectangle_rounded :: proc(rec: Rectangle, roundness: f32, segments: i32, color: Color) ---;

	// Draw rectangle with rounded edges outline
	@(link_name="DrawRectangleRoundedLines")
	draw_rectangle_rounded_lines :: proc(rec: Rectangle, roundness: f32, segments: i32, line_thick: f32, color: Color) ---;

	// Draw a color-filled triangle (vertex in counter-clockwise order!)
	@(link_name="DrawTriangle")
	draw_triangle :: proc(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) ---;

	// Draw triangle outline (vertex in counter-clockwise order!)
	@(link_name="DrawTriangleLines")
	draw_triangle_lines :: proc(v1: Vector2, v2: Vector2, v3: Vector2, color: Color) ---;

	// Draw a triangle fan defined by points (first vertex is the center)
	@(link_name="DrawTriangleFan")
	draw_triangle_fan :: proc(points: ^Vector2, point_count: i32, color: Color) ---;

	// Draw a triangle strip defined by points
	@(link_name="DrawTriangleStrip")
	draw_triangle_strip :: proc(points: ^Vector2, point_count: i32, color: Color) ---;

	// Draw a regular polygon (Vector version)
	@(link_name="DrawPoly")
	draw_poly :: proc(center: Vector2, sides: i32, radius: f32, rotation: f32, color: Color) ---;

	// Draw a polygon outline of n sides
	@(link_name="DrawPolyLines")
	draw_poly_lines :: proc(center: Vector2, sides: i32, radius: f32, rotation: f32, color: Color) ---;

	// Draw a polygon outline of n sides with extended parameters
	@(link_name="DrawPolyLinesEx")
	draw_poly_lines_ex :: proc(center: Vector2, sides: i32, radius: f32, rotation: f32, line_thick: f32, color: Color) ---;

	// Check collision between two rectangles
	@(link_name="CheckCollisionRecs")
	check_collision_recs :: proc(rec1: Rectangle, rec2: Rectangle) -> bool ---;

	// Check collision between two circles
	@(link_name="CheckCollisionCircles")
	check_collision_circles :: proc(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) -> bool ---;

	// Check collision between circle and rectangle
	@(link_name="CheckCollisionCircleRec")
	check_collision_circle_rec :: proc(center: Vector2, radius: f32, rec: Rectangle) -> bool ---;

	// Check if point is inside rectangle
	@(link_name="CheckCollisionPointRec")
	check_collision_point_rec :: proc(point: Vector2, rec: Rectangle) -> bool ---;

	// Check if point is inside circle
	@(link_name="CheckCollisionPointCircle")
	check_collision_point_circle :: proc(point: Vector2, center: Vector2, radius: f32) -> bool ---;

	// Check if point is inside a triangle
	@(link_name="CheckCollisionPointTriangle")
	check_collision_point_triangle :: proc(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2) -> bool ---;

	// Check the collision between two lines defined by two points each, returns collision point by reference
	@(link_name="CheckCollisionLines")
	check_collision_lines :: proc(start_pos1: Vector2, end_pos1: Vector2, start_pos2: Vector2, end_pos2: Vector2, collision_point: ^Vector2) -> bool ---;

	// Get collision rectangle for two rectangles collision
	@(link_name="GetCollisionRec")
	get_collision_rec :: proc(rec1: Rectangle, rec2: Rectangle) -> Rectangle ---;

	// Load image from file into CPU memory (RAM)
	@(link_name="LoadImage")
	load_image :: proc(file_name: cstring) -> Image ---;

	// Load image from RAW file data
	@(link_name="LoadImageRaw")
	load_image_raw :: proc(file_name: cstring, width: i32, height: i32, format: i32, header_size: i32) -> Image ---;

	// Load image sequence from file (frames appended to image.data)
	@(link_name="LoadImageAnim")
	load_image_anim :: proc(file_name: cstring, frames: ^i32) -> Image ---;

	// Load image from memory buffer, fileType refers to extension: i.e. '.png'
	@(link_name="LoadImageFromMemory")
	load_image_from_memory :: proc(file_type: cstring, file_data: ^u8, data_size: i32) -> Image ---;

	// Load image from GPU texture data
	@(link_name="LoadImageFromTexture")
	load_image_from_texture :: proc(texture: Texture2d) -> Image ---;

	// Load image from screen buffer and (screenshot)
	@(link_name="LoadImageFromScreen")
	load_image_from_screen :: proc() -> Image ---;

	// Unload image from CPU memory (RAM)
	@(link_name="UnloadImage")
	unload_image :: proc(image: Image) ---;

	// Export image data to file, returns true on success
	@(link_name="ExportImage")
	export_image :: proc(image: Image, file_name: cstring) -> bool ---;

	// Export image as code file defining an array of bytes, returns true on success
	@(link_name="ExportImageAsCode")
	export_image_as_code :: proc(image: Image, file_name: cstring) -> bool ---;

	// Generate image: plain color
	@(link_name="GenImageColor")
	gen_image_color :: proc(width: i32, height: i32, color: Color) -> Image ---;

	// Generate image: vertical gradient
	@(link_name="GenImageGradientV")
	gen_image_gradient_v :: proc(width: i32, height: i32, top: Color, bottom: Color) -> Image ---;

	// Generate image: horizontal gradient
	@(link_name="GenImageGradientH")
	gen_image_gradient_h :: proc(width: i32, height: i32, left: Color, right: Color) -> Image ---;

	// Generate image: radial gradient
	@(link_name="GenImageGradientRadial")
	gen_image_gradient_radial :: proc(width: i32, height: i32, density: f32, inner: Color, outer: Color) -> Image ---;

	// Generate image: checked
	@(link_name="GenImageChecked")
	gen_image_checked :: proc(width: i32, height: i32, checks_x: i32, checks_y: i32, col1: Color, col2: Color) -> Image ---;

	// Generate image: white noise
	@(link_name="GenImageWhiteNoise")
	gen_image_white_noise :: proc(width: i32, height: i32, factor: f32) -> Image ---;

	// Generate image: perlin noise
	@(link_name="GenImagePerlinNoise")
	gen_image_perlin_noise :: proc(width: i32, height: i32, offset_x: i32, offset_y: i32, scale: f32) -> Image ---;

	// Generate image: cellular algorithm, bigger tileSize means bigger cells
	@(link_name="GenImageCellular")
	gen_image_cellular :: proc(width: i32, height: i32, tile_size: i32) -> Image ---;

	// Create an image duplicate (useful for transformations)
	@(link_name="ImageCopy")
	image_copy :: proc(image: Image) -> Image ---;

	// Create an image from another image piece
	@(link_name="ImageFromImage")
	image_from_image :: proc(image: Image, rec: Rectangle) -> Image ---;

	// Create an image from text (default font)
	@(link_name="ImageText")
	image_text :: proc(text: cstring, font_size: i32, color: Color) -> Image ---;

	// Create an image from text (custom sprite font)
	@(link_name="ImageTextEx")
	image_text_ex :: proc(font: Font, text: cstring, font_size: f32, spacing: f32, tint: Color) -> Image ---;

	// Convert image data to desired format
	@(link_name="ImageFormat")
	image_format :: proc(image: ^Image, new_format: i32) ---;

	// Convert image to POT (power-of-two)
	@(link_name="ImageToPOT")
	image_to_pot :: proc(image: ^Image, fill: Color) ---;

	// Crop an image to a defined rectangle
	@(link_name="ImageCrop")
	image_crop :: proc(image: ^Image, crop: Rectangle) ---;

	// Crop image depending on alpha value
	@(link_name="ImageAlphaCrop")
	image_alpha_crop :: proc(image: ^Image, threshold: f32) ---;

	// Clear alpha channel to desired color
	@(link_name="ImageAlphaClear")
	image_alpha_clear :: proc(image: ^Image, color: Color, threshold: f32) ---;

	// Apply alpha mask to image
	@(link_name="ImageAlphaMask")
	image_alpha_mask :: proc(image: ^Image, alpha_mask: Image) ---;

	// Premultiply alpha channel
	@(link_name="ImageAlphaPremultiply")
	image_alpha_premultiply :: proc(image: ^Image) ---;

	// Resize image (Bicubic scaling algorithm)
	@(link_name="ImageResize")
	image_resize :: proc(image: ^Image, new_width: i32, new_height: i32) ---;

	// Resize image (Nearest-Neighbor scaling algorithm)
	@(link_name="ImageResizeNN")
	image_resize_nn :: proc(image: ^Image, new_width: i32, new_height: i32) ---;

	// Resize canvas and fill with color
	@(link_name="ImageResizeCanvas")
	image_resize_canvas :: proc(image: ^Image, new_width: i32, new_height: i32, offset_x: i32, offset_y: i32, fill: Color) ---;

	// Compute all mipmap levels for a provided image
	@(link_name="ImageMipmaps")
	image_mipmaps :: proc(image: ^Image) ---;

	// Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
	@(link_name="ImageDither")
	image_dither :: proc(image: ^Image, r_bpp: i32, g_bpp: i32, b_bpp: i32, a_bpp: i32) ---;

	// Flip image vertically
	@(link_name="ImageFlipVertical")
	image_flip_vertical :: proc(image: ^Image) ---;

	// Flip image horizontally
	@(link_name="ImageFlipHorizontal")
	image_flip_horizontal :: proc(image: ^Image) ---;

	// Rotate image clockwise 90deg
	@(link_name="ImageRotateCW")
	image_rotate_cw :: proc(image: ^Image) ---;

	// Rotate image counter-clockwise 90deg
	@(link_name="ImageRotateCCW")
	image_rotate_ccw :: proc(image: ^Image) ---;

	// Modify image color: tint
	@(link_name="ImageColorTint")
	image_color_tint :: proc(image: ^Image, color: Color) ---;

	// Modify image color: invert
	@(link_name="ImageColorInvert")
	image_color_invert :: proc(image: ^Image) ---;

	// Modify image color: grayscale
	@(link_name="ImageColorGrayscale")
	image_color_grayscale :: proc(image: ^Image) ---;

	// Modify image color: contrast (-100 to 100)
	@(link_name="ImageColorContrast")
	image_color_contrast :: proc(image: ^Image, contrast: f32) ---;

	// Modify image color: brightness (-255 to 255)
	@(link_name="ImageColorBrightness")
	image_color_brightness :: proc(image: ^Image, brightness: i32) ---;

	// Modify image color: replace color
	@(link_name="ImageColorReplace")
	image_color_replace :: proc(image: ^Image, color: Color, replace: Color) ---;

	// Load color data from image as a Color array (RGBA - 32bit)
	@(link_name="LoadImageColors")
	load_image_colors :: proc(image: Image) -> ^Color ---;

	// Load colors palette from image as a Color array (RGBA - 32bit)
	@(link_name="LoadImagePalette")
	load_image_palette :: proc(image: Image, max_palette_size: i32, color_count: ^i32) -> ^Color ---;

	// Unload color data loaded with LoadImageColors()
	@(link_name="UnloadImageColors")
	unload_image_colors :: proc(colors: ^Color) ---;

	// Unload colors palette loaded with LoadImagePalette()
	@(link_name="UnloadImagePalette")
	unload_image_palette :: proc(colors: ^Color) ---;

	// Get image alpha border rectangle
	@(link_name="GetImageAlphaBorder")
	get_image_alpha_border :: proc(image: Image, threshold: f32) -> Rectangle ---;

	// Clear image background with given color
	@(link_name="ImageClearBackground")
	image_clear_background :: proc(dst: ^Image, color: Color) ---;

	// Draw pixel within an image
	@(link_name="ImageDrawPixel")
	image_draw_pixel :: proc(dst: ^Image, pos_x: i32, pos_y: i32, color: Color) ---;

	// Draw pixel within an image (Vector version)
	@(link_name="ImageDrawPixelV")
	image_draw_pixel_v :: proc(dst: ^Image, position: Vector2, color: Color) ---;

	// Draw line within an image
	@(link_name="ImageDrawLine")
	image_draw_line :: proc(dst: ^Image, start_pos_x: i32, start_pos_y: i32, end_pos_x: i32, end_pos_y: i32, color: Color) ---;

	// Draw line within an image (Vector version)
	@(link_name="ImageDrawLineV")
	image_draw_line_v :: proc(dst: ^Image, start: Vector2, end: Vector2, color: Color) ---;

	// Draw circle within an image
	@(link_name="ImageDrawCircle")
	image_draw_circle :: proc(dst: ^Image, center_x: i32, center_y: i32, radius: i32, color: Color) ---;

	// Draw circle within an image (Vector version)
	@(link_name="ImageDrawCircleV")
	image_draw_circle_v :: proc(dst: ^Image, center: Vector2, radius: i32, color: Color) ---;

	// Draw rectangle within an image
	@(link_name="ImageDrawRectangle")
	image_draw_rectangle :: proc(dst: ^Image, pos_x: i32, pos_y: i32, width: i32, height: i32, color: Color) ---;

	// Draw rectangle within an image (Vector version)
	@(link_name="ImageDrawRectangleV")
	image_draw_rectangle_v :: proc(dst: ^Image, position: Vector2, size: Vector2, color: Color) ---;

	// Draw rectangle within an image
	@(link_name="ImageDrawRectangleRec")
	image_draw_rectangle_rec :: proc(dst: ^Image, rec: Rectangle, color: Color) ---;

	// Draw rectangle lines within an image
	@(link_name="ImageDrawRectangleLines")
	image_draw_rectangle_lines :: proc(dst: ^Image, rec: Rectangle, thick: i32, color: Color) ---;

	// Draw a source image within a destination image (tint applied to source)
	@(link_name="ImageDraw")
	image_draw :: proc(dst: ^Image, src: Image, src_rec: Rectangle, dst_rec: Rectangle, tint: Color) ---;

	// Draw text (using default font) within an image (destination)
	@(link_name="ImageDrawText")
	image_draw_text :: proc(dst: ^Image, text: cstring, pos_x: i32, pos_y: i32, font_size: i32, color: Color) ---;

	// Draw text (custom sprite font) within an image (destination)
	@(link_name="ImageDrawTextEx")
	image_draw_text_ex :: proc(dst: ^Image, font: Font, text: cstring, position: Vector2, font_size: f32, spacing: f32, tint: Color) ---;

	// Load texture from file into GPU memory (VRAM)
	@(link_name="LoadTexture")
	load_texture :: proc(file_name: cstring) -> Texture2d ---;

	// Load texture from image data
	@(link_name="LoadTextureFromImage")
	load_texture_from_image :: proc(image: Image) -> Texture2d ---;

	// Load cubemap from image, multiple image cubemap layouts supported
	@(link_name="LoadTextureCubemap")
	load_texture_cubemap :: proc(image: Image, layout: Cubemap_Layout) -> Texture_Cubemap ---;

	// Load texture for rendering (framebuffer)
	@(link_name="LoadRenderTexture")
	load_render_texture :: proc(width: i32, height: i32) -> Render_Texture2d ---;

	// Unload texture from GPU memory (VRAM)
	@(link_name="UnloadTexture")
	unload_texture :: proc(texture: Texture2d) ---;

	// Unload render texture from GPU memory (VRAM)
	@(link_name="UnloadRenderTexture")
	unload_render_texture :: proc(target: Render_Texture2d) ---;

	// Update GPU texture with new data
	@(link_name="UpdateTexture")
	update_texture :: proc(texture: Texture2d, pixels: rawptr) ---;

	// Update GPU texture rectangle with new data
	@(link_name="UpdateTextureRec")
	update_texture_rec :: proc(texture: Texture2d, rec: Rectangle, pixels: rawptr) ---;

	// Generate GPU mipmaps for a texture
	@(link_name="GenTextureMipmaps")
	gen_texture_mipmaps :: proc(texture: ^Texture2d) ---;

	// Set texture scaling filter mode
	@(link_name="SetTextureFilter")
	set_texture_filter :: proc(texture: Texture2d, filter: Texture_Filter) ---;

	// Set texture wrapping mode
	@(link_name="SetTextureWrap")
	set_texture_wrap :: proc(texture: Texture2d, wrap: Texture_Wrap) ---;

	// Draw a Texture2D
	@(link_name="DrawTexture")
	draw_texture :: proc(texture: Texture2d, pos_x: i32, pos_y: i32, tint: Color) ---;

	// Draw a Texture2D with position defined as Vector2
	@(link_name="DrawTextureV")
	draw_texture_v :: proc(texture: Texture2d, position: Vector2, tint: Color) ---;

	// Draw a Texture2D with extended parameters
	@(link_name="DrawTextureEx")
	draw_texture_ex :: proc(texture: Texture2d, position: Vector2, rotation: f32, scale: f32, tint: Color) ---;

	// Draw a part of a texture defined by a rectangle
	@(link_name="DrawTextureRec")
	draw_texture_rec :: proc(texture: Texture2d, source: Rectangle, position: Vector2, tint: Color) ---;

	// Draw texture quad with tiling and offset parameters
	@(link_name="DrawTextureQuad")
	draw_texture_quad :: proc(texture: Texture2d, tiling: Vector2, offset: Vector2, quad: Rectangle, tint: Color) ---;

	// Draw part of a texture (defined by a rectangle) with rotation and scale tiled into dest.
	@(link_name="DrawTextureTiled")
	draw_texture_tiled :: proc(texture: Texture2d, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, scale: f32, tint: Color) ---;

	// Draw a part of a texture defined by a rectangle with 'pro' parameters
	@(link_name="DrawTexturePro")
	draw_texture_pro :: proc(texture: Texture2d, source: Rectangle, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) ---;

	// Draws a texture (or part of it) that stretches or shrinks nicely
	@(link_name="DrawTextureNPatch")
	draw_texture_n_patch :: proc(texture: Texture2d, n_patch_info: N_Patch_Info, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) ---;

	// Draw a textured polygon
	@(link_name="DrawTexturePoly")
	draw_texture_poly :: proc(texture: Texture2d, center: Vector2, points: ^Vector2, texcoords: ^Vector2, point_count: i32, tint: Color) ---;

	// Get color with alpha applied, alpha goes from 0.0f to 1.0f
	@(link_name="Fade")
	fade :: proc(color: Color, alpha: f32) -> Color ---;

	// Get hexadecimal value for a Color
	@(link_name="ColorToInt")
	color_to_int :: proc(color: Color) -> i32 ---;

	// Get Color normalized as float [0..1]
	@(link_name="ColorNormalize")
	color_normalize :: proc(color: Color) -> Vector4 ---;

	// Get Color from normalized values [0..1]
	@(link_name="ColorFromNormalized")
	color_from_normalized :: proc(normalized: Vector4) -> Color ---;

	// Get HSV values for a Color, hue [0..360], saturation/value [0..1]
	@(link_name="ColorToHSV")
	color_to_hsv :: proc(color: Color) -> Vector3 ---;

	// Get a Color from HSV values, hue [0..360], saturation/value [0..1]
	@(link_name="ColorFromHSV")
	color_from_hsv :: proc(hue: f32, saturation: f32, value: f32) -> Color ---;

	// Get color with alpha applied, alpha goes from 0.0f to 1.0f
	@(link_name="ColorAlpha")
	color_alpha :: proc(color: Color, alpha: f32) -> Color ---;

	// Get src alpha-blended into dst color with tint
	@(link_name="ColorAlphaBlend")
	color_alpha_blend :: proc(dst: Color, src: Color, tint: Color) -> Color ---;

	// Get Color structure from hexadecimal value
	@(link_name="GetColor")
	get_color :: proc(hex_value: u32) -> Color ---;

	// Get Color from a source pixel pointer of certain format
	@(link_name="GetPixelColor")
	get_pixel_color :: proc(src_ptr: rawptr, format: Pixel_Format) -> Color ---;

	// Set color formatted into destination pixel pointer
	@(link_name="SetPixelColor")
	set_pixel_color :: proc(dst_ptr: rawptr, color: Color, format: Pixel_Format) ---;

	// Get pixel data size in bytes for certain format
	@(link_name="GetPixelDataSize")
	get_pixel_data_size :: proc(width: i32, height: i32, format: Pixel_Format) -> i32 ---;

	// Get the default Font
	@(link_name="GetFontDefault")
	get_font_default :: proc() -> Font ---;

	// Load font from file into GPU memory (VRAM)
	@(link_name="LoadFont")
	load_font :: proc(file_name: cstring) -> Font ---;

	// Load font from file with extended parameters
	@(link_name="LoadFontEx")
	load_font_ex :: proc(file_name: cstring, font_size: i32, font_chars: ^i32, glyph_count: i32) -> Font ---;

	// Load font from Image (XNA style)
	@(link_name="LoadFontFromImage")
	load_font_from_image :: proc(image: Image, key: Color, first_char: i32) -> Font ---;

	// Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
	@(link_name="LoadFontFromMemory")
	load_font_from_memory :: proc(file_type: cstring, file_data: ^u8, data_size: i32, font_size: i32, font_chars: ^i32, glyph_count: i32) -> Font ---;

	// Load font data for further use
	@(link_name="LoadFontData")
	load_font_data :: proc(file_data: ^u8, data_size: i32, font_size: i32, font_chars: ^i32, glyph_count: i32, type: i32) -> ^Glyph_Info ---;

	// Generate image font atlas using chars info
	@(link_name="GenImageFontAtlas")
	gen_image_font_atlas :: proc(chars: ^Glyph_Info, recs: ^^Rectangle, glyph_count: i32, font_size: i32, padding: i32, pack_method: i32) -> Image ---;

	// Unload font chars info data (RAM)
	@(link_name="UnloadFontData")
	unload_font_data :: proc(chars: ^Glyph_Info, glyph_count: i32) ---;

	// Unload Font from GPU memory (VRAM)
	@(link_name="UnloadFont")
	unload_font :: proc(font: Font) ---;

	// Draw current FPS
	@(link_name="DrawFPS")
	draw_fps :: proc(pos_x: i32, pos_y: i32) ---;

	// Draw text (using default font)
	@(link_name="DrawText")
	draw_text :: proc(text: cstring, pos_x: i32, pos_y: i32, font_size: i32, color: Color) ---;

	// Draw text using font and additional parameters
	@(link_name="DrawTextEx")
	draw_text_ex :: proc(font: Font, text: cstring, position: Vector2, font_size: f32, spacing: f32, tint: Color) ---;

	// Draw text using Font and pro parameters (rotation)
	@(link_name="DrawTextPro")
	draw_text_pro :: proc(font: Font, text: cstring, position: Vector2, origin: Vector2, rotation: f32, font_size: f32, spacing: f32, tint: Color) ---;

	// Draw one character (codepoint)
	@(link_name="DrawTextCodepoint")
	draw_text_codepoint :: proc(font: Font, codepoint: i32, position: Vector2, font_size: f32, tint: Color) ---;

	// Measure string width for default font
	@(link_name="MeasureText")
	measure_text :: proc(text: cstring, font_size: i32) -> i32 ---;

	// Measure string size for Font
	@(link_name="MeasureTextEx")
	measure_text_ex :: proc(font: Font, text: cstring, font_size: f32, spacing: f32) -> Vector2 ---;

	// Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
	@(link_name="GetGlyphIndex")
	get_glyph_index :: proc(font: Font, codepoint: i32) -> i32 ---;

	// Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
	@(link_name="GetGlyphInfo")
	get_glyph_info :: proc(font: Font, codepoint: i32) -> Glyph_Info ---;

	// Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
	@(link_name="GetGlyphAtlasRec")
	get_glyph_atlas_rec :: proc(font: Font, codepoint: i32) -> Rectangle ---;

	// Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
	@(link_name="LoadCodepoints")
	load_codepoints :: proc(text: cstring, count: ^i32) -> ^i32 ---;

	// Unload codepoints data from memory
	@(link_name="UnloadCodepoints")
	unload_codepoints :: proc(codepoints: ^i32) ---;

	// Get total number of codepoints in a UTF-8 encoded string
	@(link_name="GetCodepointCount")
	get_codepoint_count :: proc(text: cstring) -> i32 ---;

	// Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
	@(link_name="GetCodepoint")
	get_codepoint :: proc(text: cstring, bytes_processed: ^i32) -> i32 ---;

	// Encode one codepoint into UTF-8 byte array (array length returned as parameter)
	@(link_name="CodepointToUTF8")
	codepoint_to_utf8 :: proc(codepoint: i32, byte_size: ^i32) -> cstring ---;

	// Encode text as codepoints array into UTF-8 text string (WARNING: memory must be freed!)
	@(link_name="TextCodepointsToUTF8")
	text_codepoints_to_utf8 :: proc(codepoints: ^i32, length: i32) -> ^u8 ---;

	// Copy one string to another, returns bytes copied
	@(link_name="TextCopy")
	text_copy :: proc(dst: ^u8, src: cstring) -> i32 ---;

	// Check if two text string are equal
	@(link_name="TextIsEqual")
	text_is_equal :: proc(text1: cstring, text2: cstring) -> bool ---;

	// Get text length, checks for ' 0' ending
	@(link_name="TextLength")
	text_length :: proc(text: cstring) -> u32 ---;

	// Text formatting with variables (sprintf() style)
	@(link_name="TextFormat")
	text_format :: proc(text: cstring, #c_vararg args: ..any) -> cstring ---;

	// Get a piece of a text string
	@(link_name="TextSubtext")
	text_subtext :: proc(text: cstring, position: i32, length: i32) -> cstring ---;

	// Replace text string (WARNING: memory must be freed!)
	@(link_name="TextReplace")
	text_replace :: proc(text: ^u8, replace: cstring, by: cstring) -> ^u8 ---;

	// Insert text in a position (WARNING: memory must be freed!)
	@(link_name="TextInsert")
	text_insert :: proc(text: cstring, insert: cstring, position: i32) -> ^u8 ---;

	// Join text strings with delimiter
	@(link_name="TextJoin")
	text_join :: proc(text_list: ^cstring, count: i32, delimiter: cstring) -> cstring ---;

	// Split text into multiple strings
	@(link_name="TextSplit")
	text_split :: proc(text: cstring, delimiter: u8, count: ^i32) -> ^cstring ---;

	// Append text at specific position and move cursor!
	@(link_name="TextAppend")
	text_append :: proc(text: ^u8, append: cstring, position: ^i32) ---;

	// Find first text occurrence within a string
	@(link_name="TextFindIndex")
	text_find_index :: proc(text: cstring, find: cstring) -> i32 ---;

	// Get upper case version of provided string
	@(link_name="TextToUpper")
	text_to_upper :: proc(text: cstring) -> cstring ---;

	// Get lower case version of provided string
	@(link_name="TextToLower")
	text_to_lower :: proc(text: cstring) -> cstring ---;

	// Get Pascal case notation version of provided string
	@(link_name="TextToPascal")
	text_to_pascal :: proc(text: cstring) -> cstring ---;

	// Get integer value from text (negative values not supported)
	@(link_name="TextToInteger")
	text_to_integer :: proc(text: cstring) -> i32 ---;

	// Draw a line in 3D world space
	@(link_name="DrawLine3D")
	draw_line3d :: proc(start_pos: Vector3, end_pos: Vector3, color: Color) ---;

	// Draw a point in 3D space, actually a small line
	@(link_name="DrawPoint3D")
	draw_point3d :: proc(position: Vector3, color: Color) ---;

	// Draw a circle in 3D world space
	@(link_name="DrawCircle3D")
	draw_circle3d :: proc(center: Vector3, radius: f32, rotation_axis: Vector3, rotation_angle: f32, color: Color) ---;

	// Draw a color-filled triangle (vertex in counter-clockwise order!)
	@(link_name="DrawTriangle3D")
	draw_triangle3d :: proc(v1: Vector3, v2: Vector3, v3: Vector3, color: Color) ---;

	// Draw a triangle strip defined by points
	@(link_name="DrawTriangleStrip3D")
	draw_triangle_strip3d :: proc(points: ^Vector3, point_count: i32, color: Color) ---;

	// Draw cube
	@(link_name="DrawCube")
	draw_cube :: proc(position: Vector3, width: f32, height: f32, length: f32, color: Color) ---;

	// Draw cube (Vector version)
	@(link_name="DrawCubeV")
	draw_cube_v :: proc(position: Vector3, size: Vector3, color: Color) ---;

	// Draw cube wires
	@(link_name="DrawCubeWires")
	draw_cube_wires :: proc(position: Vector3, width: f32, height: f32, length: f32, color: Color) ---;

	// Draw cube wires (Vector version)
	@(link_name="DrawCubeWiresV")
	draw_cube_wires_v :: proc(position: Vector3, size: Vector3, color: Color) ---;

	// Draw cube textured
	@(link_name="DrawCubeTexture")
	draw_cube_texture :: proc(texture: Texture2d, position: Vector3, width: f32, height: f32, length: f32, color: Color) ---;

	// Draw cube with a region of a texture
	@(link_name="DrawCubeTextureRec")
	draw_cube_texture_rec :: proc(texture: Texture2d, source: Rectangle, position: Vector3, width: f32, height: f32, length: f32, color: Color) ---;

	// Draw sphere
	@(link_name="DrawSphere")
	draw_sphere :: proc(center_pos: Vector3, radius: f32, color: Color) ---;

	// Draw sphere with extended parameters
	@(link_name="DrawSphereEx")
	draw_sphere_ex :: proc(center_pos: Vector3, radius: f32, rings: i32, slices: i32, color: Color) ---;

	// Draw sphere wires
	@(link_name="DrawSphereWires")
	draw_sphere_wires :: proc(center_pos: Vector3, radius: f32, rings: i32, slices: i32, color: Color) ---;

	// Draw a cylinder/cone
	@(link_name="DrawCylinder")
	draw_cylinder :: proc(position: Vector3, radius_top: f32, radius_bottom: f32, height: f32, slices: i32, color: Color) ---;

	// Draw a cylinder/cone wires
	@(link_name="DrawCylinderWires")
	draw_cylinder_wires :: proc(position: Vector3, radius_top: f32, radius_bottom: f32, height: f32, slices: i32, color: Color) ---;

	// Draw a plane XZ
	@(link_name="DrawPlane")
	draw_plane :: proc(center_pos: Vector3, size: Vector2, color: Color) ---;

	// Draw a ray line
	@(link_name="DrawRay")
	draw_ray :: proc(ray: Ray, color: Color) ---;

	// Draw a grid (centered at (0, 0, 0))
	@(link_name="DrawGrid")
	draw_grid :: proc(slices: i32, spacing: f32) ---;

	// Load model from files (meshes and materials)
	@(link_name="LoadModel")
	load_model :: proc(file_name: cstring) -> Model ---;

	// Load model from generated mesh (default material)
	@(link_name="LoadModelFromMesh")
	load_model_from_mesh :: proc(mesh: Mesh) -> Model ---;

	// Unload model (including meshes) from memory (RAM and/or VRAM)
	@(link_name="UnloadModel")
	unload_model :: proc(model: Model) ---;

	// Unload model (but not meshes) from memory (RAM and/or VRAM)
	@(link_name="UnloadModelKeepMeshes")
	unload_model_keep_meshes :: proc(model: Model) ---;

	// Compute model bounding box limits (considers all meshes)
	@(link_name="GetModelBoundingBox")
	get_model_bounding_box :: proc(model: Model) -> Bounding_Box ---;

	// Draw a model (with texture if set)
	@(link_name="DrawModel")
	draw_model :: proc(model: Model, position: Vector3, scale: f32, tint: Color) ---;

	// Draw a model with extended parameters
	@(link_name="DrawModelEx")
	draw_model_ex :: proc(model: Model, position: Vector3, rotation_axis: Vector3, rotation_angle: f32, scale: Vector3, tint: Color) ---;

	// Draw a model wires (with texture if set)
	@(link_name="DrawModelWires")
	draw_model_wires :: proc(model: Model, position: Vector3, scale: f32, tint: Color) ---;

	// Draw a model wires (with texture if set) with extended parameters
	@(link_name="DrawModelWiresEx")
	draw_model_wires_ex :: proc(model: Model, position: Vector3, rotation_axis: Vector3, rotation_angle: f32, scale: Vector3, tint: Color) ---;

	// Draw bounding box (wires)
	@(link_name="DrawBoundingBox")
	draw_bounding_box :: proc(box: Bounding_Box, color: Color) ---;

	// Draw a billboard texture
	@(link_name="DrawBillboard")
	draw_billboard :: proc(camera: Camera, texture: Texture2d, position: Vector3, size: f32, tint: Color) ---;

	// Draw a billboard texture defined by source
	@(link_name="DrawBillboardRec")
	draw_billboard_rec :: proc(camera: Camera, texture: Texture2d, source: Rectangle, position: Vector3, size: Vector2, tint: Color) ---;

	// Draw a billboard texture defined by source and rotation
	@(link_name="DrawBillboardPro")
	draw_billboard_pro :: proc(camera: Camera, texture: Texture2d, source: Rectangle, position: Vector3, up: Vector3, size: Vector2, origin: Vector2, rotation: f32, tint: Color) ---;

	// Upload mesh vertex data in GPU and provide VAO/VBO ids
	@(link_name="UploadMesh")
	upload_mesh :: proc(mesh: ^Mesh, _dynamic: bool) ---;

	// Update mesh vertex data in GPU for a specific buffer index
	@(link_name="UpdateMeshBuffer")
	update_mesh_buffer :: proc(mesh: Mesh, index: i32, data: rawptr, data_size: i32, offset: i32) ---;

	// Unload mesh data from CPU and GPU
	@(link_name="UnloadMesh")
	unload_mesh :: proc(mesh: Mesh) ---;

	// Draw a 3d mesh with material and transform
	@(link_name="DrawMesh")
	draw_mesh :: proc(mesh: Mesh, material: Material, transform: Matrix) ---;

	// Draw multiple mesh instances with material and different transforms
	@(link_name="DrawMeshInstanced")
	draw_mesh_instanced :: proc(mesh: Mesh, material: Material, transforms: ^Matrix, instances: i32) ---;

	// Export mesh data to file, returns true on success
	@(link_name="ExportMesh")
	export_mesh :: proc(mesh: Mesh, file_name: cstring) -> bool ---;

	// Compute mesh bounding box limits
	@(link_name="GetMeshBoundingBox")
	get_mesh_bounding_box :: proc(mesh: Mesh) -> Bounding_Box ---;

	// Compute mesh tangents
	@(link_name="GenMeshTangents")
	gen_mesh_tangents :: proc(mesh: ^Mesh) ---;

	// Compute mesh binormals
	@(link_name="GenMeshBinormals")
	gen_mesh_binormals :: proc(mesh: ^Mesh) ---;

	// Generate polygonal mesh
	@(link_name="GenMeshPoly")
	gen_mesh_poly :: proc(sides: i32, radius: f32) -> Mesh ---;

	// Generate plane mesh (with subdivisions)
	@(link_name="GenMeshPlane")
	gen_mesh_plane :: proc(width: f32, length: f32, res_x: i32, res_z: i32) -> Mesh ---;

	// Generate cuboid mesh
	@(link_name="GenMeshCube")
	gen_mesh_cube :: proc(width: f32, height: f32, length: f32) -> Mesh ---;

	// Generate sphere mesh (standard sphere)
	@(link_name="GenMeshSphere")
	gen_mesh_sphere :: proc(radius: f32, rings: i32, slices: i32) -> Mesh ---;

	// Generate half-sphere mesh (no bottom cap)
	@(link_name="GenMeshHemiSphere")
	gen_mesh_hemi_sphere :: proc(radius: f32, rings: i32, slices: i32) -> Mesh ---;

	// Generate cylinder mesh
	@(link_name="GenMeshCylinder")
	gen_mesh_cylinder :: proc(radius: f32, height: f32, slices: i32) -> Mesh ---;

	// Generate cone/pyramid mesh
	@(link_name="GenMeshCone")
	gen_mesh_cone :: proc(radius: f32, height: f32, slices: i32) -> Mesh ---;

	// Generate torus mesh
	@(link_name="GenMeshTorus")
	gen_mesh_torus :: proc(radius: f32, size: f32, rad_seg: i32, sides: i32) -> Mesh ---;

	// Generate trefoil knot mesh
	@(link_name="GenMeshKnot")
	gen_mesh_knot :: proc(radius: f32, size: f32, rad_seg: i32, sides: i32) -> Mesh ---;

	// Generate heightmap mesh from image data
	@(link_name="GenMeshHeightmap")
	gen_mesh_heightmap :: proc(heightmap: Image, size: Vector3) -> Mesh ---;

	// Generate cubes-based map mesh from image data
	@(link_name="GenMeshCubicmap")
	gen_mesh_cubicmap :: proc(cubicmap: Image, cube_size: Vector3) -> Mesh ---;

	// Load materials from model file
	@(link_name="LoadMaterials")
	load_materials :: proc(file_name: cstring, material_count: ^i32) -> ^Material ---;

	// Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
	@(link_name="LoadMaterialDefault")
	load_material_default :: proc() -> Material ---;

	// Unload material from GPU memory (VRAM)
	@(link_name="UnloadMaterial")
	unload_material :: proc(material: Material) ---;

	// Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
	@(link_name="SetMaterialTexture")
	set_material_texture :: proc(material: ^Material, map_type: Material_Map_Index, texture: Texture2d) ---;

	// Set material for a mesh
	@(link_name="SetModelMeshMaterial")
	set_model_mesh_material :: proc(model: ^Model, mesh_id: i32, material_id: i32) ---;

	// Load model animations from file
	@(link_name="LoadModelAnimations")
	load_model_animations :: proc(file_name: cstring, anim_count: ^u32) -> ^Model_Animation ---;

	// Update model animation pose
	@(link_name="UpdateModelAnimation")
	update_model_animation :: proc(model: Model, anim: Model_Animation, frame: i32) ---;

	// Unload animation data
	@(link_name="UnloadModelAnimation")
	unload_model_animation :: proc(anim: Model_Animation) ---;

	// Unload animation array data
	@(link_name="UnloadModelAnimations")
	unload_model_animations :: proc(animations: ^Model_Animation, count: u32) ---;

	// Check model animation skeleton match
	@(link_name="IsModelAnimationValid")
	is_model_animation_valid :: proc(model: Model, anim: Model_Animation) -> bool ---;

	// Check collision between two spheres
	@(link_name="CheckCollisionSpheres")
	check_collision_spheres :: proc(center1: Vector3, radius1: f32, center2: Vector3, radius2: f32) -> bool ---;

	// Check collision between two bounding boxes
	@(link_name="CheckCollisionBoxes")
	check_collision_boxes :: proc(box1: Bounding_Box, box2: Bounding_Box) -> bool ---;

	// Check collision between box and sphere
	@(link_name="CheckCollisionBoxSphere")
	check_collision_box_sphere :: proc(box: Bounding_Box, center: Vector3, radius: f32) -> bool ---;

	// Get collision info between ray and sphere
	@(link_name="GetRayCollisionSphere")
	get_ray_collision_sphere :: proc(ray: Ray, center: Vector3, radius: f32) -> Ray_Collision ---;

	// Get collision info between ray and box
	@(link_name="GetRayCollisionBox")
	get_ray_collision_box :: proc(ray: Ray, box: Bounding_Box) -> Ray_Collision ---;

	// Get collision info between ray and model
	@(link_name="GetRayCollisionModel")
	get_ray_collision_model :: proc(ray: Ray, model: Model) -> Ray_Collision ---;

	// Get collision info between ray and mesh
	@(link_name="GetRayCollisionMesh")
	get_ray_collision_mesh :: proc(ray: Ray, mesh: Mesh, transform: Matrix) -> Ray_Collision ---;

	// Get collision info between ray and triangle
	@(link_name="GetRayCollisionTriangle")
	get_ray_collision_triangle :: proc(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3) -> Ray_Collision ---;

	// Get collision info between ray and quad
	@(link_name="GetRayCollisionQuad")
	get_ray_collision_quad :: proc(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3) -> Ray_Collision ---;

	// Initialize audio device and context
	@(link_name="InitAudioDevice")
	init_audio_device :: proc() ---;

	// Close the audio device and context
	@(link_name="CloseAudioDevice")
	close_audio_device :: proc() ---;

	// Check if audio device has been initialized successfully
	@(link_name="IsAudioDeviceReady")
	is_audio_device_ready :: proc() -> bool ---;

	// Set master volume (listener)
	@(link_name="SetMasterVolume")
	set_master_volume :: proc(volume: f32) ---;

	// Load wave data from file
	@(link_name="LoadWave")
	load_wave :: proc(file_name: cstring) -> Wave ---;

	// Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
	@(link_name="LoadWaveFromMemory")
	load_wave_from_memory :: proc(file_type: cstring, file_data: ^u8, data_size: i32) -> Wave ---;

	// Load sound from file
	@(link_name="LoadSound")
	load_sound :: proc(file_name: cstring) -> Sound ---;

	// Load sound from wave data
	@(link_name="LoadSoundFromWave")
	load_sound_from_wave :: proc(wave: Wave) -> Sound ---;

	// Update sound buffer with new data
	@(link_name="UpdateSound")
	update_sound :: proc(sound: Sound, data: rawptr, sample_count: i32) ---;

	// Unload wave data
	@(link_name="UnloadWave")
	unload_wave :: proc(wave: Wave) ---;

	// Unload sound
	@(link_name="UnloadSound")
	unload_sound :: proc(sound: Sound) ---;

	// Export wave data to file, returns true on success
	@(link_name="ExportWave")
	export_wave :: proc(wave: Wave, file_name: cstring) -> bool ---;

	// Export wave sample data to code (.h), returns true on success
	@(link_name="ExportWaveAsCode")
	export_wave_as_code :: proc(wave: Wave, file_name: cstring) -> bool ---;

	// Play a sound
	@(link_name="PlaySound")
	play_sound :: proc(sound: Sound) ---;

	// Stop playing a sound
	@(link_name="StopSound")
	stop_sound :: proc(sound: Sound) ---;

	// Pause a sound
	@(link_name="PauseSound")
	pause_sound :: proc(sound: Sound) ---;

	// Resume a paused sound
	@(link_name="ResumeSound")
	resume_sound :: proc(sound: Sound) ---;

	// Play a sound (using multichannel buffer pool)
	@(link_name="PlaySoundMulti")
	play_sound_multi :: proc(sound: Sound) ---;

	// Stop any sound playing (using multichannel buffer pool)
	@(link_name="StopSoundMulti")
	stop_sound_multi :: proc() ---;

	// Get number of sounds playing in the multichannel
	@(link_name="GetSoundsPlaying")
	get_sounds_playing :: proc() -> i32 ---;

	// Check if a sound is currently playing
	@(link_name="IsSoundPlaying")
	is_sound_playing :: proc(sound: Sound) -> bool ---;

	// Set volume for a sound (1.0 is max level)
	@(link_name="SetSoundVolume")
	set_sound_volume :: proc(sound: Sound, volume: f32) ---;

	// Set pitch for a sound (1.0 is base level)
	@(link_name="SetSoundPitch")
	set_sound_pitch :: proc(sound: Sound, pitch: f32) ---;

	// Convert wave data to desired format
	@(link_name="WaveFormat")
	wave_format :: proc(wave: ^Wave, sample_rate: i32, sample_size: i32, channels: i32) ---;

	// Copy a wave to a new wave
	@(link_name="WaveCopy")
	wave_copy :: proc(wave: Wave) -> Wave ---;

	// Crop a wave to defined samples range
	@(link_name="WaveCrop")
	wave_crop :: proc(wave: ^Wave, init_sample: i32, final_sample: i32) ---;

	// Load samples data from wave as a floats array
	@(link_name="LoadWaveSamples")
	load_wave_samples :: proc(wave: Wave) -> ^f32 ---;

	// Unload samples data loaded with LoadWaveSamples()
	@(link_name="UnloadWaveSamples")
	unload_wave_samples :: proc(samples: ^f32) ---;

	// Load music stream from file
	@(link_name="LoadMusicStream")
	load_music_stream :: proc(file_name: cstring) -> Music ---;

	// Load music stream from data
	@(link_name="LoadMusicStreamFromMemory")
	load_music_stream_from_memory :: proc(file_type: cstring, data: ^u8, data_size: i32) -> Music ---;

	// Unload music stream
	@(link_name="UnloadMusicStream")
	unload_music_stream :: proc(music: Music) ---;

	// Start music playing
	@(link_name="PlayMusicStream")
	play_music_stream :: proc(music: Music) ---;

	// Check if music is playing
	@(link_name="IsMusicStreamPlaying")
	is_music_stream_playing :: proc(music: Music) -> bool ---;

	// Updates buffers for music streaming
	@(link_name="UpdateMusicStream")
	update_music_stream :: proc(music: Music) ---;

	// Stop music playing
	@(link_name="StopMusicStream")
	stop_music_stream :: proc(music: Music) ---;

	// Pause music playing
	@(link_name="PauseMusicStream")
	pause_music_stream :: proc(music: Music) ---;

	// Resume playing paused music
	@(link_name="ResumeMusicStream")
	resume_music_stream :: proc(music: Music) ---;

	// Seek music to a position (in seconds)
	@(link_name="SeekMusicStream")
	seek_music_stream :: proc(music: Music, position: f32) ---;

	// Set volume for music (1.0 is max level)
	@(link_name="SetMusicVolume")
	set_music_volume :: proc(music: Music, volume: f32) ---;

	// Set pitch for a music (1.0 is base level)
	@(link_name="SetMusicPitch")
	set_music_pitch :: proc(music: Music, pitch: f32) ---;

	// Get music time length (in seconds)
	@(link_name="GetMusicTimeLength")
	get_music_time_length :: proc(music: Music) -> f32 ---;

	// Get current music time played (in seconds)
	@(link_name="GetMusicTimePlayed")
	get_music_time_played :: proc(music: Music) -> f32 ---;

	// Load audio stream (to stream raw audio pcm data)
	@(link_name="LoadAudioStream")
	load_audio_stream :: proc(sample_rate: u32, sample_size: u32, channels: u32) -> Audio_Stream ---;

	// Unload audio stream and free memory
	@(link_name="UnloadAudioStream")
	unload_audio_stream :: proc(stream: Audio_Stream) ---;

	// Update audio stream buffers with data
	@(link_name="UpdateAudioStream")
	update_audio_stream :: proc(stream: Audio_Stream, data: rawptr, frame_count: i32) ---;

	// Check if any audio stream buffers requires refill
	@(link_name="IsAudioStreamProcessed")
	is_audio_stream_processed :: proc(stream: Audio_Stream) -> bool ---;

	// Play audio stream
	@(link_name="PlayAudioStream")
	play_audio_stream :: proc(stream: Audio_Stream) ---;

	// Pause audio stream
	@(link_name="PauseAudioStream")
	pause_audio_stream :: proc(stream: Audio_Stream) ---;

	// Resume audio stream
	@(link_name="ResumeAudioStream")
	resume_audio_stream :: proc(stream: Audio_Stream) ---;

	// Check if audio stream is playing
	@(link_name="IsAudioStreamPlaying")
	is_audio_stream_playing :: proc(stream: Audio_Stream) -> bool ---;

	// Stop audio stream
	@(link_name="StopAudioStream")
	stop_audio_stream :: proc(stream: Audio_Stream) ---;

	// Set volume for audio stream (1.0 is max level)
	@(link_name="SetAudioStreamVolume")
	set_audio_stream_volume :: proc(stream: Audio_Stream, volume: f32) ---;

	// Set pitch for audio stream (1.0 is base level)
	@(link_name="SetAudioStreamPitch")
	set_audio_stream_pitch :: proc(stream: Audio_Stream, pitch: f32) ---;

	// Default size for new audio streams
	@(link_name="SetAudioStreamBufferSizeDefault")
	set_audio_stream_buffer_size_default :: proc(size: i32) ---;
}
