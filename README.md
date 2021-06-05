# Raylib bindings for Odin

[Raylib](https://www.raylib.com) bindings generator for [Odin](https://odin-lang.org)

This is basically my "Hello world" in Odin so there may be bugs.

## Using the bindings
To use the bindings copy `raylib.odin`, `raylib.lib` and `raylib.dll` from the `raylib` folder to your project.

`raylib.lib` needs to be in the same folder as `raylib.odin`

`raylib.dll` needs to be in the same folder as your project's exe.

Example project structure:
```
raylib
 |-- raylib.lib
 |-- raylib.odin
main.odin
```
To import raylib just point to the folder that contains `raylib.odin`
```
package example
import rl "raylib"

main :: proc()
{
}
```


**IMPORTANT** Raylib function `void ShowCursor()` is currently disabled because of a name collision with a different foreign function in Odin.

## Generating the bindings
If you want to update the bindings yourself there are some additional requirements:

* Visual Studio 2017 or 2019
* x64 Native Tools Command Prompt for VS running
* Raylib version 3.8+ with the raylib parser built and named `raylib_parser.exe`
* `raylib.dll` and `raylib.lib` built following these [insturctions](https://github.com/raysan5/raylib/wiki/Create-Visual-Studio-2019-Project) and copied to the `raylib` folder
* Odin [built](https://odin-lang.org/docs/install/) and added to your PATH

To generate the bindings execute `run.bat` with a path pointing to the raylib parser folder. For example `run.bat c:\raylib\parser`.

## Running examples
To run an example copy `raylib.dll` to `examples/out` folder and execute `run_example.bat` with an example name. For example `run_example.bat textures/bunnymark`.

## TODO
- [ ] Linux support
- [ ] More examples to make sure all major feautures are working
