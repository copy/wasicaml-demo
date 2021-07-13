default:
	mkdir -p _build
	cp test.ml stubs.c _build/
	cd _build && ~/.wasicaml/bin/ocamlc -custom -g stubs.c test.ml
	cd _build && ~/.wasicaml/bin/wasicaml -cclib stubs.o a.out -o test.wasm
	chmod +x _build/a.out
