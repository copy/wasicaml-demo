let () = print_endline "Hello from wasm+OCaml!"

let rec fib x = if x <= 2 then 1 else fib (x - 1) + fib (x - 2)
let () = Printf.printf "fib(%d) = %d\n" 20 (fib 20)

let () = Callback.register "js_to_ocaml" (fun () -> print_endline "js_to_ocaml called")
