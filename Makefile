ssite:
	bundle exec staticmatic build .
	mkdir -p site/dataset/api
	./node_modules/.bin/jsdoc projects/dataset/src \
		--destination site/dataset/api \
		--template ../jsdoc-template-miso/src \
		--configure ./jsdoc-config.json \
		--query "layout=./site/dataset/api.html&externalExBase=./projects/dataset/examples/api"
	mkdir -p site/d3-chart/api
	./node_modules/.bin/jsdoc projects/d3-chart/src \
		--destination site/d3-chart/api \
		--template ../jsdoc-template-miso/src \
		--configure ./jsdoc-config.json \
		--query "layout=./site/d3-chart/api.html&externalExBase=./projects/d3-chart/examples/api"

clean: site
	rm -rf site
