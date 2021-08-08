#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/memory.h>
#include <caml/signals.h>
#include <caml/alloc.h>
#include <caml/bigarray.h>

#include <assert.h>

__attribute__((export_name("init")))
CAMLprim value init() {
  //puts("C call works\n");
  const value* f = caml_named_value("init");
  assert(f != NULL);
  return caml_callback(*f, Val_unit);
}

__attribute__((export_name("step")))
CAMLprim value step() {
  const value* f = caml_named_value("step");
  assert(f != NULL);
  return caml_callback(*f, Val_unit);
}
