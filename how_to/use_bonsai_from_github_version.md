# Description 
Sometimes, we need to use the latest packages that is not available in default opam repo. 
And we need to add extra repo.

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
  dune init proj hello
  ```
  Then, cd into the project folder and open vscode by `code .`

- Create a local switch for this project 
  ```sh 
  opam switch create . ocaml-base-compiler 5.0.0  
  opam install dune utop ocamlformat ocaml-lsp-server
  ```
  
# Add extra repo 
- Add extra repo
  ```sh 
  opam repo add janestreet-bleeding-external https://github.com/janestreet/opam-repository.git#external-packages
  ```
- Add repos to current switch 
  ```sh 
  opam repo --all
  # Repository                 # Url                                                                   # Switches(rank)
  default                      https://opam.ocaml.org                                                  <default> /home/zw/code/ocaml-programming/learning_bonsai ocaml-base-compiler(3/3) /home/zw/code/ocaml-programming/ocaml_in_action(3/3)
  janestreet-bleeding          https://ocaml.janestreet.com/opam-repository                            ocaml-base-compiler(2/3) /home/zw/code/ocaml-programming/ocaml_in_action(2/3)
  janestreet-bleeding-external git+https://github.com/janestreet/opam-repository.git#external-packages ocaml-base-compiler(1/3) /home/zw/code/ocaml-programming/ocaml_in_action(1/3)

  opam repo add janestreet-bleeding
  opam repo add janestreet-bleeding-external

  opam repo
  [NOTE] These are the repositories in use by the current switch. Use '--all' to see all configured repositories.

  <><> Repository configuration for switch /home/zw/code/ocaml-programming/learning_bonsai 
  1 janestreet-bleeding-external git+https://github.com/janestreet/opam-repository.git#external-packages
  2 janestreet-bleeding          https://ocaml.janestreet.com/opam-repository
  3 default                      https://opam.ocaml.org
  ```

# Add extra library 
Suppose we want to install bonsai with specific version.
- Edit the `dune-project` file to add bonsai in depends
  ```dune 
   (depends 
    ocaml 
    dune 
    (bonsai (>= "v0.16~preview"))
   )
  ```
- Update `hello.opam` file (do not edit it directly).
  ``` sh 
  dune build
  ```
- Install dependencies to current switch
  ```sh 
  opam install --deps-only .
  ```
- (Optional) Sometimes you don't want to commit changes to add new library
  ```sh
  opam install --deps-only .
  [NOTE] Ignoring uncommitted changes in /home/zw/code/ocaml-programming/learning_bonsai (`--working-dir' not active).
  [learning_bonsai.~dev] synchronised (no changes)
  ```

  This could be solved by unpin 
  ```sh
  opam pin remove opam learning_bonsai
  Ok, learning_bonsai is no longer pinned to git+file:///home/zw/code/ocaml-programming/learning_bonsai#master (version ~dev)
  [NOTE] opam is not pinned.
  The following actions will be performed:
    ⊘ remove learning_bonsai ~dev
  Do you want to continue? [Y/n] Y

  <><> Processing actions <><><><><><><><><><><><><><><><><><><><><><><><><><><><>
  ⊘ removed   learning_bonsai.~dev
  Done.
  ```
- We better pin our project's package 
  ```sh
  opam pin add . -yn 
  ```
# Other useful commands
## Use Opam to pin packages
``` sh 
# This is actually a powerful mechanism to divert any package definition, and can even be used to locally create packages that don't have entries in the repositories.
# Check current pinned packages within current switch 
opam pin . 

# opam pin add <package name> <target>
opam pin add camlpdf 1.7                                      # version pin
opam pin add camlpdf ~/src/camlpdf                            # path
opam pin add opam-lib https://github.com/ocaml/opam.git#1.2   # specific branch or commit
opam pin add bonsai https://github.com/janestreet/bonsai.git
opam pin add opam-lib --dev-repo                              # upstream repository

# Pin the package contained in the current directory (.) with the name hello 
opam pin add -yn hello . 

# Pin a specific package
opam pin bonsai https://github.com/janestreet/bonsai.git#v0.16~preview.128.14+51

# Remove a pinned packages
opam pin remove hello

# This can be used in conjunction with opam source to patch an existing package in a breeze:
opam source <package> --dev-repo --pin
cd <package>; # hack hack hack
opam upgrade .
```
