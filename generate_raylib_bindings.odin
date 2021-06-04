package raylib_bindings

import "core:fmt"
import "core:os"
import "core:io"
import "core:bufio"
import "core:strings"
import "core:strconv"
import "core:builtin"

Parameter_Info :: struct
{
	name: string,
	type: string,
};

Function_Info :: struct
{
	name: string,
	description: string,
	return_type: string,
	parameters: [dynamic]Parameter_Info,
};

Enum_Value_Info :: struct
{
	string_value: string,
	int_value: string,
};

Enum_Info :: struct 
{
	name: string,
	values: [dynamic]Enum_Value_Info,
};

Field_Info :: struct
{
	type: string,
	name: string,
	comment: string,
};

Struct_Info :: struct
{
	name: string,
	fields: [dynamic]Field_Info,
};

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
	"int" = "int",
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

generate_typedefs :: proc(file: os.Handle)
{
	typedefs := "Quaternion :: Vector4;\nTexture2d :: Texture;\nTexture_Cubemap :: Texture;\nRender_Texture2d :: Render_Texture;\nCamera :: Camera3d;\n";
	os.write(file, transmute([]u8)typedefs);
	callback := "Trace_Log_Callback :: proc(log_level: int, text: cstring, args: ..any);\n";
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

parse_structs :: proc(reader: ^bufio.Reader, structs: ^[dynamic]Struct_Info)
{
	ignore_line(reader);
	line, err := bufio.reader_read_string(reader, '\n');

	split := strings.split(strings.trim_space(line), " ");
	struct_count, ok := strconv.parse_int(split[2]);
	assert(ok);
	ignore_line(reader);

	for i in 0..<struct_count
	{
		line, err = bufio.reader_read_string(reader, '\n');
		struct_string := strings.split(strings.trim_space(line), " ");
		
		index := 0;
		index, ok = strconv.parse_int(struct_string[1][0:len(struct_string[1]) - 1]);
		assert(ok);

		name := strings.to_ada_case(struct_string[2]);
		
		fields_count := 0;
		fields_count, ok = strconv.parse_int(struct_string[3][1:]);
		assert(ok);

		fields: [dynamic]Field_Info;
		current_struct := Struct_Info{name, fields};

		for j in 0..<fields_count
		{
			line, err = bufio.reader_read_string(reader, '\n');
			line = strings.trim_space(line);

			split = strings.split(line, "//");
			
			comment := split[1];
			field_string := strings.split(strings.trim_space(split[0]), " ");
			type := "";
			names: []string;
			if field_string[2] == "unsigned"
			{
				join_index := 4;
				if strings.contains(field_string[4], "*")
				{
					join_index = 5;
				}
				type = strings.join(field_string[2:join_index], " ");
				names = field_string[join_index:];
			}
			else 
			{
				if strings.contains(field_string[3], "*") 
				{
					type = strings.join(field_string[2:4], " ");
					names = field_string[4:];
				}
				else
				{
					type = field_string[2];
					names = field_string[3:];
				}
			}

			for name in names
			{
				field_info: Field_Info;
				field_info.comment = comment;
				temp_name, _ := strings.remove_all(name, ",");

				if type in types
				{
					type = types[type];
				}
				
				if strings.contains(type, "*") && !strings.contains(type, "void")
				{
					star_index := strings.index(type, "*");
					temp: [2]string;
					temp[0], _ = strings.replace_all(type[star_index:], "*", "^");
					temp[1] = type[:star_index - 1];

					if temp[1] in types
					{
						temp[1] = types[temp[1]];
					}

					type = strings.concatenate(temp[:]);
				}
				type = strings.to_ada_case(type);

				bracket_index := strings.index(temp_name, "[");
				if bracket_index != -1
				{
					temp: [2]string;
					temp[0] = strings.clone(temp_name[bracket_index:]);
					temp[1] = strings.clone(type);
					type = strings.concatenate(temp[:]);
					temp_name = temp_name[:bracket_index];
				}

				field_info.type = type;
				field_info.name = strings.to_snake_case(temp_name);
				append(&current_struct.fields, field_info);
			}
		}
		append(structs, current_struct);
	}
}

generate_structs :: proc(file: os.Handle, structs: ^[dynamic]Struct_Info)
{
	r_audio_buffer := "r_Audio_Buffer :: struct {};\n";
	os.write(file, transmute([]u8)r_audio_buffer);

	for struct_info in structs
	{
		struct_builder := strings.make_builder_none();
		defer strings.destroy_builder(&struct_builder);

		strings.write_string_builder(&struct_builder, "\n");
		strings.write_string_builder(&struct_builder, struct_info.name);
		strings.write_string_builder(&struct_builder, " :: struct\n");
		strings.write_string_builder(&struct_builder, "{\n");

		for field_info in struct_info.fields
		{
			strings.write_string_builder(&struct_builder, "\t");
			strings.write_string_builder(&struct_builder, field_info.name);
			strings.write_string_builder(&struct_builder, ": ");
			strings.write_string_builder(&struct_builder, field_info.type);
			strings.write_string_builder(&struct_builder, ", //");
			strings.write_string_builder(&struct_builder, field_info.comment);
			strings.write_string_builder(&struct_builder, "\n");
		}

		strings.write_string_builder(&struct_builder, "};\n");
		os.write(file, transmute([]u8)strings.to_string(struct_builder));
	}
}

parse_enums :: proc(reader: ^bufio.Reader, enums: ^[dynamic]Enum_Info)
{
	ignore_line(reader);
	line, err := bufio.reader_read_string(reader, '\n');

	split := strings.split(strings.trim_space(line), " ");
	enum_count, ok := strconv.parse_int(split[2]);
	assert(ok);
	ignore_line(reader);

	for i in 0..<enum_count
	{
		line, err = bufio.reader_read_string(reader, '\n');
		enum_string := strings.split(strings.trim_space(line), " ");
		
		index := 0;
		index, ok = strconv.parse_int(enum_string[1][0:len(enum_string[1]) - 1]);
		assert(ok);

		name := strings.to_ada_case(enum_string[2]);
		
		values_count := 0;
		values_count, ok = strconv.parse_int(enum_string[3][1:]);
		assert(ok);

		values: [dynamic]Enum_Value_Info;
		current_enum := Enum_Info{name, values};
		for j in 0..<values_count
		{
			line, err = bufio.reader_read_string(reader, '\n');
			value_string := strings.split(strings.trim_space(line), " ");
			value_name := value_string[1][:len(value_string[1]) - 1];
			value := value_string[2];
			append(&current_enum.values, Enum_Value_Info{value_name, value});
		}
		append(enums, current_enum);
	}
}

generate_enums :: proc(file: os.Handle, enums: ^[dynamic]Enum_Info)
{
	for enum_info in enums
	{
		enum_builder := strings.make_builder_none();
		defer strings.destroy_builder(&enum_builder);

		strings.write_string_builder(&enum_builder, "\n");
		strings.write_string_builder(&enum_builder, enum_info.name);
		strings.write_string_builder(&enum_builder, " :: enum\n");
		strings.write_string_builder(&enum_builder, "{\n");

		for value_info in enum_info.values
		{
			strings.write_string_builder(&enum_builder, "\t");
			strings.write_string_builder(&enum_builder, value_info.string_value);
			strings.write_string_builder(&enum_builder, " = ");
			strings.write_string_builder(&enum_builder, value_info.int_value);
			strings.write_string_builder(&enum_builder, ",\n");
			// strings.write_string_builder(&enum_builder, field_info.comment);
			// strings.write_string_builder(&enum_builder, "\n");
		}

		strings.write_string_builder(&enum_builder, "};\n");
		os.write(file, transmute([]u8)strings.to_string(enum_builder));
	}
}

parse_type :: proc(type: string) -> string
{
	parameter_type := type;

	if parameter_type != "const char *"
	{
		ignored: bool;
		parameter_type, ignored = strings.remove_all(parameter_type, "const");
		parameter_type = strings.trim_space(parameter_type);		
	}

	if parameter_type in types
	{
		parameter_type = types[parameter_type];
	}
	
	if strings.contains(parameter_type, "*") && !strings.contains(parameter_type, "void")
	{
		star_index := strings.index(parameter_type, "*");
		temp: [2]string;
		temp[0], _ = strings.replace_all(parameter_type[star_index:], "*", "^");
		space := ' ';
		if parameter_type[star_index] != cast(u8)space
		{
			star_index += 1;
		}
		temp[1] = strings.trim_space(parameter_type[:star_index - 1]);
		
		if temp[1] in types
		{
			temp[1] = types[temp[1]];
		}

		parameter_type = strings.concatenate(temp[:]);
	}
	return strings.to_ada_case(parameter_type);
}

parse_functions :: proc(reader: ^bufio.Reader, functions: ^[dynamic]Function_Info)
{
	ignore_line(reader);
	line, err := bufio.reader_read_string(reader, '\n');

	split := strings.split(strings.trim_space(line), " ");
	function_count, ok := strconv.parse_int(split[2]);
	assert(ok);
	ignore_line(reader);

	for i in 0..<function_count
	{
		line, err = bufio.reader_read_string(reader, '\n');
		function_string := strings.split(strings.trim_space(line), " ");
		
		index := 0;
		index, ok = strconv.parse_int(function_string[1][0:len(function_string[1]) - 1]);
		assert(ok);

		name := function_string[2][:len(function_string[2]) - 2];
		
		parameters_count := 0;
		parameters_count, ok = strconv.parse_int(function_string[3][1:]);
		assert(ok);

		line, err = bufio.reader_read_string(reader, '\n');
		description := strings.trim_space(strings.split(line, "//")[1]);

		line, err = bufio.reader_read_string(reader, '\n');
		return_type := parse_type(strings.join(strings.split(strings.trim_space(line), " ")[2:], " "));

		parameters: [dynamic]Parameter_Info;
		current_function := Function_Info{name, description, return_type, parameters};

		if parameters_count == 0
		{
			ignore_line(reader);
		}

		for j in 0..<parameters_count
		{
			
			line, err = bufio.reader_read_string(reader, '\n');
			parameter_string := strings.split(strings.trim_space(line), " ");
			parameter_name := strings.to_snake_case(parameter_string[2]);
			parameter_type: string;

			if parameter_name == "dynamic"
			{
				parameter_name = "_dynamic";
			} 
			
			if parameter_name == ""
			{
				parameter_name = "args";
				parameter_type = "..any";
			}
			else
			{
				parameter_type = strings.join(parameter_string[4:], " ");
				parameter_type = parse_type(parameter_type[:len(parameter_type) - 1]);
			}
			
			append(&current_function.parameters, Parameter_Info{parameter_name, parameter_type});
		}
		append(functions, current_function);
	}
}

generate_functions :: proc(file: os.Handle, functions: ^[dynamic]Function_Info)
{
	foreign_block := "\n@(default_calling_convention=\"c\")\nforeign raylib\n{\n";
	os.write(file, transmute([]u8)foreign_block);

	for function_info in functions
	{
		if function_info.name == "ShowCursor"
		{
			// Show cursor is colliding with another foreign function in user32.odin
			continue;
		}
		function_builder := strings.make_builder_none();
		defer strings.destroy_builder(&function_builder);

		strings.write_string_builder(&function_builder, "\n");
		strings.write_string_builder(&function_builder, "\t// ");
		strings.write_string_builder(&function_builder, function_info.description);
		strings.write_string_builder(&function_builder, "\n");
		
		strings.write_string_builder(&function_builder, "\t@(link_name=\"");
		strings.write_string_builder(&function_builder, function_info.name);
		strings.write_string_builder(&function_builder, "\")\n\t");
		strings.write_string_builder(&function_builder, strings.to_snake_case(function_info.name));
		strings.write_string_builder(&function_builder, " :: proc(");

		for parameter_info in function_info.parameters
		{
			strings.write_string_builder(&function_builder, parameter_info.name);
			strings.write_string_builder(&function_builder, ": ");
			strings.write_string_builder(&function_builder, parameter_info.type);
			strings.write_string_builder(&function_builder, ", ");
		}
		if len(function_info.parameters) > 0
		{
			strings.pop_byte(&function_builder);
			strings.pop_byte(&function_builder);
		}
		strings.write_string_builder(&function_builder, ") ");

		if function_info.return_type != "void"
		{
			strings.write_string_builder(&function_builder, "-> ");
			strings.write_string_builder(&function_builder, function_info.return_type);
			strings.write_string_builder(&function_builder, " ");
		}
		strings.write_string_builder(&function_builder, "---;\n");

		os.write(file, transmute([]u8)strings.to_string(function_builder));
	}
	block_end := "}\n";
	os.write(file, transmute([]u8)block_end);
}

main ::proc()
{
	defer delete(types);
	input_stream := os.stream_from_handle(os.stdin);
	reader: bufio.Reader;
	bufio.reader_init(&reader, io.Reader{input_stream});

	structs: [dynamic]Struct_Info;
	enums: [dynamic]Enum_Info;
	functions: [dynamic]Function_Info;

	parse_structs(&reader, &structs);
	parse_enums(&reader, &enums);
	parse_functions(&reader, &functions);

	file, error := os.open("./raylib.odin", os.O_RDWR);
	assert(error == 0);
	defer os.close(file);

	header := "package raylib\n\nforeign import raylib \"raylib.lib\"\n\n";
	os.write(file, transmute([]u8)header);

	generate_typedefs(file);
	generate_structs(file, &structs);
	generate_enums(file, &enums);
	generate_functions(file, &functions);
}
