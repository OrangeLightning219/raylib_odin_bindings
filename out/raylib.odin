package raylib

foreign import raylib "raylib.lib"

Quaternion :: Vector4;
Texture2d :: Texture;
Texture_Cubemap :: Texture;
Render_Texture2d :: Render_Texture;
Camera :: Camera3d;
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
	format: i32, // Data format (PixelFormat type)
};

Texture :: struct
{
	id: u32, // OpenGL texture id
	width: i32, // Texture base width
	height: i32, // Texture base height
	mipmaps: i32, // Mipmap levels, 1 by default
	format: i32, // Data format (PixelFormat type)
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

Char_Info :: struct
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
	chars_count: i32, // Number of characters
	chars_padding: i32, // Padding around the chars
	texture: Texture2d, // Characters texture atlas
	recs: ^Rectangle, // Characters rectangles in texture
	chars: ^Char_Info, // Characters info data
};

Camera3d :: struct
{
	position: Vector3, // Camera position
	target: Vector3, // Camera target it looks-at
	up: Vector3, // Camera up vector (rotation over its axis)
	fovy: f32, // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
	projection: i32, // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
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
	locs: ^i32, // Shader locations array (MAX_SHADER_LOCATIONS)
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
	sample_count: u32, // Total number of samples (considering channels!)
	sample_rate: u32, // Frequency (samples per second)
	sample_size: u32, // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	channels: u32, // Number of channels (1-mono, 2-stereo)
	data: rawptr, // Buffer data pointer
};

Audio_Stream :: struct
{
	buffer: ^r_Audio_Buffer, // Pointer to internal data used by the audio system
	sample_rate: u32, // Frequency (samples per second)
	sample_size: u32, // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	channels: u32, // Number of channels (1-mono, 2-stereo)
};

Sound :: struct
{
	stream: Audio_Stream, // Audio stream
	sample_count: u32, // Total number of samples
};

Music :: struct
{
	stream: Audio_Stream, // Audio stream
	sample_count: u32, // Total number of samples
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
