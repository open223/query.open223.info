.PHONY: all environment gather-files compile-models clean

MODEL_SOURCES = $(wildcard models/*.ttl)
COMPILED_MODELS = $(patsubst models/%.ttl,compiled-models/%.ttl,$(MODEL_SOURCES))

all: index.html

environment:
	poetry run ontoenv init

gather-files:
	./tools/gather-files.sh

compiled-models/%.ttl: models/%.ttl tools/compile.py ontologies/*.ttl
	poetry run ontoenv refresh
	poetry run python tools/compile.py -r -i -o $@ $< ontologies/223p.ttl

compile-models: $(COMPILED_MODELS)

index.html: templates/index.html tools/compile-html.py queries.toml compile-models
	poetry run python tools/compile-html.py

clean:
	rm -f compiled-models/*.ttl
	rm -f index.html
	rm -f 223p.ttl

$(COMPILED_MODELS): | compiled-models

compiled-models:
	mkdir -p $@
