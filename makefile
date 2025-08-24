.PHONY: compile preview

compile:
	typst compile ./src/main.typ ./main.pdf --root .
preview:
	tinymist preview ./src/main.typ --partial-rendering true --root .
