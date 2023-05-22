open Tools
open Core
(* dune exec -- bin/how/process_json/main.exe *)

let () =
  print_endline "\n";
  (* Shows how to use a different module in the same library Tools *)
  (* print_endline (Math.add 1 10 |> string_of_int); *)

  (* Show how to process json *)
  Common.parse_json_demo "/home/zw/code/ocaml-programming/ocaml_in_action/tmp/book.json"
;;
