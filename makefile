.PHONY: compile preview

compile:
	typst compile ./src/main.typ ./resume.pdf --root .
preview:
	tinymist preview ./src/main.typ --partial-rendering true --root .
