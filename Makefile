default: site site/d3-chart/api site/dataset/api

site:
	bundle exec staticmatic build .
	cp -R src/* site

site/%/api : projects/%
	#name = $(notdir $<)
	#@echo $@ --- $< --- $(name)
	mkdir -p $@
	./node_modules/.bin/jsdoc $</src \
		--destination $@ \
		--template ../jsdoc-template-miso/src \
		--configure ./jsdoc-config.json \
		--query "layout=./$@.html&externalExBase=./$</examples/api"

.PHONY: clean
clean:
	rm -rf site
