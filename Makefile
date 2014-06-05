default: site site/d3-chart/api site/dataset/api

site:
	bundle exec staticmatic build .
	cp -R src/* site

site/%/api : projects/%
	$(eval commit=$(word 1, $(shell git submodule status $<)))
	$(eval name=$(subst -,.,$(notdir $<)))
	$(eval srcUrl=https://github.com/misoproject/$(name)/blob/$(commit)/src/)
	$(eval srcFileUrl=$(srcUrl){{ fileName }})
	$(eval srcLineUrl=$(srcFileUrl)\#L{{ lineNumber }})
	$(eval exDir=$</examples/api)

	mkdir -p $@
	./node_modules/.bin/jsdoc $</src \
		--destination $@ \
		--template ../jsdoc-template-miso/src \
		--configure ./jsdoc-config.json \
		--query "layout=$@.html&externalExBase=$(exDir)&sourceFileUrl=$(srcFileUrl)&sourceLineUrl=$(srcLineUrl)"

.PHONY: clean
clean:
	rm -rf site
