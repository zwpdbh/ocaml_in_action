# How to install init project 
- Git clone it into a project. 
- Cd into that project, run 
  ```sh 
  opam update
  opam switch list-available
  opam switch create . ocaml-base-compiler 5.0.0
  opam install utop ocamlformat ocaml-lsp-server
  ```
  Now, open it from vscode.

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
  - 