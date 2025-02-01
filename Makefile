.PHONY: all environment gather-files clean

all: index.html

environment:
	uv run ontoenv init

gather-files:
	cp 223standard/data/*.ttl instance-models/

index.html: templates/index.html queries.toml
	uv run python tools/compile-html.py

clean:
	rm -f index.html
	rm -f 223p.ttl
