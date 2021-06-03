set binding_dir=%cd%
set raylib_parser_path=%cd%/../../raylib/parser
odin build generate_raylib_bindings.odin -out="out/generate_raylib_bindings.exe"

cd %raylib_parser_path%
%raylib_parser_path%/raylib_parser.exe > %binding_dir%/out/raylib_parser.output

cd %binding_dir%/out
del raylib.odin
nul > raylib.odin 2>NUL
generate_raylib_bindings.exe < raylib_parser.output
cd ..