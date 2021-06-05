@echo off
if ["%~1"]==[""] (
    echo Please provide example name to run. Example command: run_example.bat core/basic_window
    exit /B 1
)

set source_path=%cd%/examples/%1.odin
set out_path=%cd%/examples/out
for /f "tokens=1,2 delims=/" %%a in ("%1") do (
    if %%a == %1 (
        echo Please provide a valid example path. Example command: run_example.bat core/basic_window
        exit /B 1
    )
    set exe_path=%out_path%/%%b.exe
)

echo source %source_path%
echo out %exe_path%

odin build %source_path% -out="%exe_path%"
set current_dir=%cd%
cd %out_path%
%exe_path%
cd %current_dir%