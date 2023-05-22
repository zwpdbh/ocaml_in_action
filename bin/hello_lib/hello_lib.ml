open My_tool
(* dune exec -- bin/hello_lib/hello_lib.exe *)
let () = 
  (* let build_dir = (Filename.dirname Sys.argv.(0)) in  *)
  print_endline Common.message;
  Common.parse_json_demo "/Users/zw/code/ocaml_programming/ocaml_in_action_tmp/tmp/book.json"


