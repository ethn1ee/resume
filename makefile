.PHONY: compile preview

compile:
	typst compile ./src/main.typ --root .
preview:
	tinymist preview ./src/main.typ --partial-rendering true --root .
