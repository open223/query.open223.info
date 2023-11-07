.PHONY: index.html compile-models all templates/index.html

all: index.html

environment:
	poetry run ontoenv init

gather-files:
	./tools/gather-files.sh

compiled-models/%.ttl: models/%.ttl tools/compile.py ontologies/*.ttl
	poetry run python tools/compile.py -r -i -o $@ $< ontologies/223p.ttl

compile-models: compiled-models/pritoni-latest.ttl compiled-models/doe-medium-office-ahu-vav.ttl compiled-models/lbnl-example.ttl compiled-models/nrel-example.ttl

index.html: templates/index.html tools/compile-html.py queries.toml compile-models
	poetry run python tools/compile-html.py

clean:
	rm -f compiled-models/*.ttl
	rm -f index.html
	rm -f 223p.ttl
	rm -f compiled-models/*
