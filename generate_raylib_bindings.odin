package raylib_bindings

import "core:fmt"
import "core:os"
import "core:bufio"
import "core:strings"
import "core:strconv"
import "core:builtin"
import "core:encoding/json"

ignore_line :: proc(reader: ^bufio.Reader)
{
	bufio.reader_read_string(reader, '\n');
}

types := map[string]string{
	"bool" = "bool",
	"char" = "u8",
	"byte" = "byte",
	"signed char" = "i8",
	"unsigned char" = "u8",
	"short" = "i16",
	"unsigned short" = "u16",
	"int" = "i32",
	"unsigned int" = "u32",
	"long" = "i32" when (ODIN_OS == "windows" || size_of(builtin.rawptr) == 4) else "i64",
	"unsigned long" = "u32" when (ODIN_OS == "windows" || size_of(builtin.rawptr) == 4) else "u64",
	"long long" = "i64",
	"unsigned long long" = "u64",
	"float" = "f32",
	"double" = "f64",
	"void *" = "rawptr",
	"const void *" = "rawptr",
	"const char *" = "cstring",
	"char **" = "^cstring",
};

parse_type :: proc(type: string) -> string
{
	using strings;
	
	parameter_type := type;
	
	if parameter_type != "const char *"
	{
		ignored: bool;
		parameter_type, ignored = remove_all(parameter_type, "const");
		parameter_type = trim_space(parameter_type);		
	}
	
	if parameter_type in types
	{
		parameter_type = types[parameter_type];
	}
	
	if contains(parameter_type, "*") && !contains(parameter_type, "void")
	{
		star_index := index(parameter_type, "*");
		temp: [2]string;
		temp[0], _ = replace_all(parameter_type[star_index:], "*", "^");
		space := ' ';
		if parameter_type[star_index] != cast(u8)space
		{
			star_index += 1;
		}
		temp[1] = trim_space(parameter_type[:star_index - 1]);
		
		if temp[1] in types
		{
			temp[1] = types[temp[1]];
		}
		
		parameter_type = concatenate(temp[:]);
	}
	
	return to_ada_case(parameter_type);
}

generate_typedefs :: proc(file: os.Handle)
{
	typedefs := "Quaternion :: Vector4;\nTexture2d :: Texture;\nTexture_Cubemap :: Texture;\nRender_Texture2d :: Render_Texture;\nCamera :: Camera3d;\n";
	os.write(file, transmute([]u8)typedefs);
	callback := "Trace_Log_Callback :: proc(log_level: Trace_Log_Level, text: cstring, args: ..any);\n";
	os.write(file, transmute([]u8)callback);
	callback = "Load_File_Data_Callback :: proc(filename: cstring, bytes_read: ^u8) -> ^u8;\n";
	os.write(file, transmute([]u8)callback);
	callback = "Save_File_Data_Callback :: proc(filename: cstring, data: rawptr, bytes_to_write: u8) -> bool;\n";
	os.write(file, transmute([]u8)callback);
	callback = "Load_File_Text_Callback :: proc(filename: cstring) -> ^u8;\n";
	os.write(file, transmute([]u8)callback);
	callback = "Save_File_Text_Callback :: proc(filename: cstring, text: ^u8) -> bool;\n";
	os.write(file, transmute([]u8)callback);
	
	color := "LIGHTGRAY :: Color {200, 200, 200, 255};\n";
	os.write(file, transmute([]u8)color);	
	color = "GRAY      :: Color{ 130, 130, 130, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "DARKGRAY  :: Color{ 80, 80, 80, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "YELLOW    :: Color{ 253, 249, 0, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "GOLD      :: Color{ 255, 203, 0, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "ORANGE    :: Color{ 255, 161, 0, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "PINK      :: Color{ 255, 109, 194, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "RED       :: Color{ 230, 41, 55, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "MAROON    :: Color{ 190, 33, 55, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "GREEN     :: Color{ 0, 228, 48, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "LIME      :: Color{ 0, 158, 47, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "DARKGREEN :: Color{ 0, 117, 44, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "SKYBLUE   :: Color{ 102, 191, 255, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "BLUE      :: Color{ 0, 121, 241, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "DARKBLUE  :: Color{ 0, 82, 172, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "PURPLE    :: Color{ 200, 122, 255, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "VIOLET    :: Color{ 135, 60, 190, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "DARKPURPLE:: Color{ 112, 31, 126, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "BEIGE     :: Color{ 211, 176, 131, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "BROWN     :: Color{ 127, 106, 79, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "DARKBROWN :: Color{ 76, 63, 47, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "WHITE     :: Color{ 255, 255, 255, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "BLACK     :: Color{ 0, 0, 0, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "BLANK     :: Color{ 0, 0, 0, 0 };\n";
	os.write(file, transmute([]u8)color);
	color = "MAGENTA   :: Color{ 255, 0, 255, 255 };\n";
	os.write(file, transmute([]u8)color);
	color = "RAYWHITE  :: Color{ 245, 245, 245, 255 };\n";
	os.write(file, transmute([]u8)color);
	
}

generate_structs :: proc(file: os.Handle, structs_json: json.Array)
{
	using strings;
	
	r_audio_buffer := "r_Audio_Buffer :: struct {};\n";
	os.write(file, transmute([]u8)r_audio_buffer);
	
	for s in structs_json
	{
		struct_builder := make_builder_none();
		defer destroy_builder(&struct_builder);
		
		struct_name := s.value.(json.Object)["name"].value.(json.String);
		struct_name = to_ada_case(struct_name);
		fields := s.value.(json.Object)["fields"].value.(json.Array);
		
		write_string_builder(&struct_builder, "\n");
		write_string_builder(&struct_builder, struct_name);
		write_string_builder(&struct_builder, " :: struct\n");
		write_string_builder(&struct_builder, "{\n");
		
		for field in fields
		{
			field_name := field.value.(json.Object)["name"].value.(json.String);
			field_type := field.value.(json.Object)["type"].value.(json.String);
			field_desc := field.value.(json.Object)["description"].value.(json.String);
			
			field_type = parse_type(field_type);
			names := split(field_name, " ");
			for name in names
			{
				temp_name, _ := remove_all(name, ",");
				final_type := field_type;
				
				bracket_index := strings.index(temp_name, "[");
				if bracket_index != -1
				{
					temp: [2]string;
					temp[0] = temp_name[bracket_index:];
					temp[1] = field_type;
					final_type = concatenate(temp[:]);
					temp_name = temp_name[:bracket_index];
				}
				
				final_name := to_snake_case(temp_name);

				name_and_type: [2]string = {struct_name, final_name};

				if(struct_member_exceptions[name_and_type] != "") 
				{
					final_type = struct_member_exceptions[name_and_type];
				}

				write_string_builder(&struct_builder, "\t");
				write_string_builder(&struct_builder, final_name);
				write_string_builder(&struct_builder, ": ");
				write_string_builder(&struct_builder, final_type);
				write_string_builder(&struct_builder, ", // ");
				write_string_builder(&struct_builder, field_desc);
				write_string_builder(&struct_builder, "\n");
			}
		}
		
		write_string_builder(&struct_builder, "};\n");
		os.write(file, transmute([]u8)to_string(struct_builder));
	}
}

generate_enums :: proc(file: os.Handle, enums_json: json.Array)
{
	using strings;
	
	for e in enums_json
	{
		enum_builder := make_builder_none();
		defer destroy_builder(&enum_builder);
		
		enum_name := e.value.(json.Object)["name"].value.(json.String);
		values := e.value.(json.Object)["values"].value.(json.Array);
		
		write_string_builder(&enum_builder, "\n");
		write_string_builder(&enum_builder, to_ada_case(enum_name));
		write_string_builder(&enum_builder, " :: enum\n");
		write_string_builder(&enum_builder, "{\n");
		
		for value in values
		{
			value_name := value.value.(json.Object)["name"].value.(json.String);
			enum_value := value.value.(json.Object)["value"].value.(json.Integer);
			write_string_builder(&enum_builder, "\t");
			write_string_builder(&enum_builder, value_name);
			write_string_builder(&enum_builder, " = ");
			buf: [10]byte;
			write_string_builder(&enum_builder, strconv.itoa(buf[:], cast(int)enum_value));
			write_string_builder(&enum_builder, ",\n");
		}
		
		write_string_builder(&enum_builder, "};\n");
		os.write(file, transmute([]u8)to_string(enum_builder));
	}
}

generate_functions :: proc(file: os.Handle, functions_json: json.Array)
{
	using strings;
	foreign_block := "\n@(default_calling_convention=\"c\")\nforeign raylib\n{\n";
	os.write(file, transmute([]u8)foreign_block);
	for f in functions_json
	{
		function_name := f.value.(json.Object)["name"].value.(json.String);
		
		if function_name == "ShowCursor"
		{
			// Show cursor is colliding with another foreign function in user32.odin
			continue;
		}
		function_builder := make_builder_none();
		defer destroy_builder(&function_builder);
		
		function_desc := f.value.(json.Object)["description"].value.(json.String);
		
		write_string_builder(&function_builder, "\n");
		write_string_builder(&function_builder, "\t// ");
		write_string_builder(&function_builder, function_desc);
		write_string_builder(&function_builder, "\n");
		
		write_string_builder(&function_builder, "\t@(link_name=\"");
		write_string_builder(&function_builder, function_name);
		write_string_builder(&function_builder, "\")\n\t");
		function_name = to_snake_case(function_name);
		write_string_builder(&function_builder, function_name);
		write_string_builder(&function_builder, " :: proc(");
		
		has_params := f.value.(json.Object)["params"].value != nil;
		if has_params
		{
			parameters := f.value.(json.Object)["params"].value.(json.Object);
			for parameter_name, param_type in parameters
			{
				param_name := parameter_name;
				type := param_type.value.(json.String);
				
				if param_name == "dynamic"
				{
					param_name = "_dynamic";
				} 
				else if param_name == ""
				{
					param_name = "#c_vararg args";
					type = "..any";
				}
				else
				{
					param_name = to_snake_case(parameter_name);
					type = parse_type(type);
				}
				
				name_and_type: [2]string = {function_name, param_name};
				if(procedure_argument_type_exceptions[name_and_type] != "") 
				{
					type = procedure_argument_type_exceptions[name_and_type];
				}

				write_string_builder(&function_builder, param_name);
				write_string_builder(&function_builder, ": ");
				write_string_builder(&function_builder, type);
				write_string_builder(&function_builder, ", ");
			}
			pop_byte(&function_builder);
			pop_byte(&function_builder);
		}
		
		write_string_builder(&function_builder, ") ");
		
		return_type := parse_type(f.value.(json.Object)["returnType"].value.(json.String));
		
		if return_type != "void"
		{
			write_string_builder(&function_builder, "-> ");
			write_string_builder(&function_builder, return_type);
			write_string_builder(&function_builder, " ");
		}
		write_string_builder(&function_builder, "---;\n");
		
		os.write(file, transmute([]u8)to_string(function_builder));
	}
	block_end := "}\n";
	os.write(file, transmute([]u8)block_end);
}

main ::proc()
{
	defer delete(types);
	
	bytes, ok := os.read_entire_file("raylib_parser.json");
	
	raylib_json, parsed := json.parse(bytes, json.Specification.JSON, true);
	
	structs_json := raylib_json.value.(json.Object)["structs"].value.(json.Array);
	enums_json := raylib_json.value.(json.Object)["enums"].value.(json.Array);
	functions_json := raylib_json.value.(json.Object)["functions"].value.(json.Array);
	
	file, error := os.open("./raylib.odin", os.O_RDWR);
	assert(error == 0);
	defer os.close(file);
	
	header := "package raylib\n\nforeign import raylib \"raylib.lib\"\n\n";
	os.write(file, transmute([]u8)header);

	generate_typedefs(file);
	generate_structs(file, structs_json);
	generate_enums(file, enums_json);
	generate_functions(file, functions_json);
}
