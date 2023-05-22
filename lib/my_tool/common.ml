open Core
let message = "Hello OCaml!"



(* 
suppose we want to parse json like this:
{
  "title": "Real World OCaml",
  "tags" : [ "functional programming", "ocaml", "algorithms" ],
  "pages": 450,
  "authors": [
    { "name": "Jason Hickey", "affiliation": "Google" },
    { "name": "Anil Madhavapeddy", "affiliation": "Cambridge"},
    { "name": "Yaron Minsky", "affiliation": "Jane Street"}
  ],
  "is_online": true
} *)

type json = [
  | `Assoc of (string * json) list
  | `Bool of bool
  | `Float of float
  | `Int of int
  | `List of json list
  | `Null
  | `String of string
]

(* see: https://medium.com/@aleksandrasays/tutorial-parsing-json-with-ocaml-579cc054924f *)
let parse_json json_file = 
  let buf = In_channel.read_all json_file in 
  Yojson.Basic.from_string buf