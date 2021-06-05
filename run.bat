@echo off
set binding_dir=%cd%
set raylib_parser_path=%cd%/../../raylib/parser
if not ["%1"]==[""] (
    set raylib_parser_path=%1
)

if not exist %raylib_parser_path%/raylib_parser.exe (
    echo raylib_parser.exe not found in %raylib_parser_path%
    exit /B 1
)

odin build generate_raylib_bindings.odin -out="raylib/generate_raylib_bindings.exe"

cd %raylib_parser_path%
%raylib_parser_path%/raylib_parser.exe > %binding_dir%/raylib/raylib_parser.output

cd %binding_dir%/raylib
del raylib.odin
nul > raylib.odin 2>NUL
generate_raylib_bindings.exe < raylib_parser.output
cd ..