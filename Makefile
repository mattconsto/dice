all:
	jison dice.jison
	uglifyjs dice.js -o dice.min.js

clean:
	@rm dice.js dice.min.js

test:
	./node_modules/.bin/mocha --reporter spec

.PHONY: test