open Core
(* open Yojson *)

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

(* JSON specification 
type json = [ 
  | `Assoc of (string * json) list
  | `Bool of bool
  | `Float of float
  | `Int of int
  | `List of json list
  | `Null
  | `String of string
  ] *)

(* see: https://medium.com/@aleksandrasays/tutorial-parsing-json-with-ocaml-579cc054924f \
  also see: https://dev.realworldocaml.org/json.html   
*)
let parse_json_demo json_file =
  let buf = In_channel.read_all json_file in
  let json = Yojson.Basic.from_string buf in
  let open Yojson.Basic.Util in
  let title = json |> member "title" |> to_string in
  let tags = json |> member "tags" |> to_list |> filter_string in
  let pages = json |> member "pages" |> to_int in
  let is_online = json |> member "is_online" |> to_bool_option in
  let is_translated = json |> member "is_translated" |> to_bool_option in
  let authors = json |> member "authors" |> to_list in
  let names = List.map authors ~f:(fun json -> member "name" json |> to_string) in
  printf "Title: %s (%d) \n" title pages;
  printf "Authors: %s\n" (String.concat ~sep:", " names);
  printf "Tags: %s\n" (String.concat ~sep:", " tags);
  let string_of_bool_option = function
    | None -> "unknow"
    | Some true -> "yes"
    | Some false -> "No"
  in
  printf "Online: %s\n" (string_of_bool_option is_online);
  printf "Translated: %s\n" (string_of_bool_option is_translated)
;;
