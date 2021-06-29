default:
	mkdir -p _build
	cp test.ml _build/
	cd _build && ~/.wasicaml/bin/ocamlc -g test.ml
	cd _build && ~/.wasicaml/bin/wasicaml a.out -o test.wasm
	chmod +x _build/a.out
