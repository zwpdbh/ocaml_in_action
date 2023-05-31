# Prerequisites
- Install OCaml package manager: [opam](https://opam.ocaml.org/)
- Use `opam` to install [dune](https://dune.readthedocs.io/en/stable/quick-start.html) which is the OCaml project build system 
- After opam is installed, we could install common OCaml packages 
  ```sh
  opam update
  opam switch list-available
  ```
# Create global switch
```sh
opam switch create ocaml-base-compiler 5.0.0 
opam install dune utop ocamlformat ocaml-lsp-server
```

# Create project
In this project we will get familar with 
- Use `dune` to create a project 
  ```sh 
  dune init proj learn_caqti
  ```
  Then, cd into the project folder and open vscode by `code .`
- Create a local switch for this project 
  ```sh 
  opam switch create . ocaml-base-compiler 5.0.0  
  opam install dune utop ocamlformat ocaml-lsp-server
  ```
- Edit the `dune-project` file to make depends looks like this: 
  ```dune  
  (depends ocaml dune lwt lwt_ppx caqti caqti-lwt caqti-driver-postgresql)
  ```
- Update `learn_caqti.opam` file (do not edit it directly).
  ``` sh 
  dune build
  ```
- Install dependencies to current switch
  ```shell 
  opam install --deps-only .
  ```
# Modify the lib and bin 
- For lib, we modify the `dune` file in the lib folder 
  ```
  (library
    (name lib)
    (libraries lwt caqti caqti-lwt caqti-driver-postgresql)
    (preprocess (pps lwt_ppx))
  )
  ```
  - The `name` specifies the name of lib which will be built out and used by others.
  - The `libraries` specifies the dependencies used by this lib.
  - The `preprocess` registered `lwt_ppx` as a preprocessor so the `Lwt` syntax extension could be used.

- For bin, we modify the `dune` file in the bin folder 
  ```
  (executable
    (public_name learn_caqti)
    (name main)
    (libraries lib))
  ```
  - The `libraries` specifies this `executable` will use the library `lib` which is specified above.
- Some notes about dune 
  - Any files want to be compiled must be located inside a folder with a `dune` file.

# Use Opam to pin packages
``` sh 
# This is actually a powerful mechanism to divert any package definition, and can even be used to locally create packages that don't have entries in the repositories.
# opam pin add <package name> <target>
opam pin add camlpdf 1.7                                      # version pin
opam pin add camlpdf ~/src/camlpdf                            # path
opam pin add opam-lib https://github.com/ocaml/opam.git#1.2   # specific branch or commit
opam pin add opam-lib --dev-repo                              # upstream repository

# Pin the package contained in the current directory (.) with the name learn_caqti 
opam pin add -yn learn_caqti . 

# Check current pinned packages within current switch 
opam pin

# Remove a pinned packages
opam pin remove learn_caqti

# This can be used in conjunction with opam source to patch an existing package in a breeze:
opam source <package> --dev-repo --pin
cd <package>; # hack hack hack
opam upgrade .
```