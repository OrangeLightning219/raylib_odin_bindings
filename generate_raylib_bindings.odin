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
	int_value: int,
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
	"int" = "i32",
	"unsigned int" = "u32",
	"long" = "i32" when (ODIN_OS == "windows" || size_of(builtin.rawptr) == 4) else "i64",
	"unsigned long" = "u32" when (ODIN_OS == "windows" || size_of(builtin.rawptr) == 4) else "u64",
	"long long" = "i64",
	"unsigned long long" = "u64",
	"float" = "f32",
	"double" = "f64",
	"void *" = "rawptr",
};

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
	typedefs := "Quaternion :: Vector4;\nTexture2d :: Texture;\nTexture_Cubemap :: Texture;\nRender_Texture2d :: Render_Texture;\nCamera :: Camera3d;\n";
	os.write(file, transmute([]u8)typedefs);

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

}

generate_enums :: proc(file: os.Handle, enums: ^[dynamic]Enum_Info)
{

}

parse_functions :: proc(reader: ^bufio.Reader, functions: ^[dynamic]Function_Info)
{

}

generate_functions :: proc(file: os.Handle, functions: ^[dynamic]Function_Info)
{

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

	generate_structs(file, &structs);
	generate_enums(file, &enums);
	generate_functions(file, &functions);
}
