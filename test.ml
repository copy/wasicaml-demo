let () = print_endline "Hello from wasm+OCaml!"

let width = 200
let height = 200
let buffer1 = Bytes.create (4 * width * height)
let buffer2 = Bytes.create (4 * width * height)
let iteration = ref 0
let fg = 0xFF_00_00_00l
let bg = 0xFF_FF_FF_FFl

external set_int32_unsafe : bytes -> int -> int32 -> unit = "%caml_bytes_set32u"
external get_int32_unsafe : bytes -> int -> int32 = "%caml_bytes_get32u"

let () = Callback.register "init" (fun () ->
    Random.init 0;
    for i = 0 to height - 1 do
      let offset = width * i in
      for j = 0 to width - 1 do
        let offset = offset + j in
        let c = if Random.bool () then fg else bg in
        set_int32_unsafe buffer1 (4 * offset) c;
        set_int32_unsafe buffer2 (4 * offset) c;
      done
    done;
  )

let () = Callback.register "step" (fun () ->
    (* print_endline "js_to_ocaml called"; *)
    let front, back = if !iteration mod 2 = 0 then buffer1, buffer2 else buffer2, buffer1 in
    iteration := !iteration + 1;
    for i = 1 to height - 2 do
      let offset = width * i in
      for j = 1 to width - 2 do
        let offset = offset + j in
        let[@inline] get x = if get_int32_unsafe back x = fg then 1 else 0 in
        let nw = get (4 * (offset - width - 1)) in
        let n  = get (4 * (offset - width    )) in
        let ne = get (4 * (offset - width + 1)) in
        let  w = get (4 * (offset         - 1)) in
        let  c = get (4 * (offset            )) in
        let  e = get (4 * (offset         + 1)) in
        let sw = get (4 * (offset + width - 1)) in
        let s  = get (4 * (offset + width    )) in
        let se = get (4 * (offset + width + 1)) in
        let t = nw + n + ne + w + e + sw + s + se in
        set_int32_unsafe front (4 * offset) (if t = 3 || t = 2 && c = 1 then fg else bg)
      done
    done;
    front
  )
