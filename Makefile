default: clean build
	bundle exec staticmatic preview .

.PHONY: build
build: site site/d3-chart/api site/dataset/api

site:
	bundle exec staticmatic build .
	cp -R src/* site

node_modules: package.json
	npm install
	@touch package.json node_modules

site/%/api : projects/% node_modules
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

.PHONY: deploy
deploy: clean build
	git checkout -B gh-pages
	# Keep untracked files and .gitignore
	git ls-files -z * | xargs --null git rm
	mv site/* .
	git add .
	git commit -m "Deploy site"
	#git push --force upstream gh-pages
