.PHONY: compile preview

pdf:
	typst compile ./src/main.typ ./resume.pdf --root .

png:
	typst compile ./src/main.typ ./assets/resume.png --root . --format png

preview:
	tinymist preview ./src/main.typ --partial-rendering true --root .
