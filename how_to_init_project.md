# How to install init project 
- Git clone it into a project. 
- Cd into that project, run 
  ```sh 
  opam update
  opam switch list-available
  opam switch create . ocaml-base-compiler 5.0.0
  opam install utop ocamlformat ocaml-lsp-server
  ```
   - Now, open it from vscode.
   - If you found env doesn't pickup the commands, such as `dune`. Run `eval $(opam env)` in the terminal to sync with opam env. 

# How to build and run
Use `hello_lwt` as example, in the root of our project: 
```sh 
# This will generate <project_name>.opam file. The project name is defined in the dune-project file.
dune build
dune exec -- bin/hello_lwt/hello_lwt.exe
```
- The `bin/hello_lwt` is the folder part.
- The `hello_lwt.exe` is defined by the dune file in folder with `(name hello_lwt)`. 
- Each dune file is corresponding with something needed to be compiled. 
- The library part is defined as `(libraries lwt.unix)`. 
- The `lwt` is installed as dependency in the dune-project file. 
  - So, dune-project file is responsible for list dependencies used in the project. 
  - Each dune file use `libraries` to refer them.

# How to add extra library
- For example, we use yojson to handle json.
- Install `yojson`.
  - Modify the dune-project file to add `yojson` into `depends` parts.
  - Run `dune build`, this will update the content of `ocaml_in_action.opam` file. 
    - Remember, this file is generated automatically by dune. 
    - `dune` is for compliation management, and `opam` is responsible for dependencies/libraries management.
  - Run `opam install . --deps-only`
    - If you meet something like: 
      ```text 
      [NOTE] Ignoring uncommitted changes in /Users/zw/code/ocaml_programming/ocaml_in_action_tmp (`--working-dir' not active).
      [ocaml_in_action.~dev] synchronised (no changes)
      ```
      - And found there is no package installed at all. 
      - You can run `opam pin remove ocaml_in_action` to unpin the project (not sure why this).
- Now you could use it in your project. 

# How to build our own library and use it in another programm. 
- Say we want to wrap the features of parse json into our code as library. Then use it in another .exe programm. 


# Summary 
## Some definitions 
  - `dune-package` is usually contains one `package` which includes the code in the repo. 
  - Each dune file either defines `Executable` or `Library` which contains the code inside its folder (excluding other subfolders which includes `dune` file).
  - All files in the folder which contains `dune` file are all automatically compiled as the part of `Executable` or `Library`. 
  - In other words, we don't need to specify the `.ml` files inside the "dune" folder (this is quite different from F#).
  - Usually, each file defines a `Module`. 
  - When used by other dune unit: 
    - `open`, refers the other dune unit (like other library, say `some_lib` defined by dune file).
    - `xxx.func1`, where `xxx` is the module name. 
    - `xxx` and `some_lib` when used in code, is capitalized as 
      ```ocaml 
      open Xxx 
      Some_lib.func1  
      ```
