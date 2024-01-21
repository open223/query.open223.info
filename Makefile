.PHONY: all environment gather-files clean

all: index.html

environment:
	poetry run ontoenv init

gather-files:
	./tools/gather-files.sh

index.html: templates/index.html queries.toml
	poetry run python tools/compile-html.py

clean:
	rm -f index.html
	rm -f 223p.ttl
