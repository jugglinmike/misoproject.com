site: ssite site/d3-chart/api site/dataset/api

.PHONY: ssite
ssite:
	bundle exec staticmatic build .

site/%/api : projects/%
	name=$(notdir $<)
	@echo $@ --- $< --- $(name)
	mkdir -p $@
	./node_modules/.bin/jsdoc $</src \
		--destination $@ \
		--template ../jsdoc-template-miso/src \
		--configure ./jsdoc-config.json \
		--query "layout=./$@.html&externalExBase=./$</examples/api"

.PHONY: clean
clean:
	rm -rf site
