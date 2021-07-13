#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/memory.h>
#include <caml/signals.h>
#include <caml/alloc.h>
#include <caml/bigarray.h>

#include <assert.h>

__attribute__((export_name("js_to_ocaml")))
CAMLprim value js_to_ocaml() {
  puts("C call works\n");
  const value* js_to_ocaml;
  js_to_ocaml = caml_named_value("js_to_ocaml");
  assert(js_to_ocaml != NULL);
  return caml_callback(*js_to_ocaml, Val_unit);
}
