.PHONY: compile preview

pdf:
	@typst compile ./src/main.typ ./assets/resume.pdf --root .

png:
	@mkdir -p ./assets
	@typst compile ./src/main.typ ./assets/resume.png --root . --format png

preview:
	tinymist preview ./src/main.typ --partial-rendering true --root .
