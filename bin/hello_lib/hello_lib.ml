open My_tool

let () = print_endline Common.message

let () = 
  let json_parsed = Common.parse_json "book.json" in 
  print_endline json_parsed.
