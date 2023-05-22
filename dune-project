(lang dune 3.7)

(name ocaml_in_action)

(generate_opam_files true)

(source
  (github zwpdbgh/ocaml_in_action))

(authors "Wei Zhao")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package 
  (name ocaml_in_action)
  (synopsis "A short synopsis")
  (description "A longer description")
  (depends 
    ocaml 
    core
    dune
    lwt 
    yojson
    cohttp
    caqti
    )
  (tags
    (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
