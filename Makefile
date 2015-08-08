# get name of containing directory
project := $(shell basename "$(realpath $(shell dirname "$(lastword $(MAKEFILE_LIST))"))" | sed 's/\.user\.js$$//g')
version = $(shell grep -oP '\/\/ @version\s+\K\S+' "dist/${project}.meta.js")

dist: dist/${project}.user.js dist/${project}.meta.js

dist/${project}.user.js: ${project}.js
	cp "$<" "$@"

dist/${project}.meta.js: dist/${project}.user.js
	awk '/\/\/ ==UserScript==/,/\/\/ ==\/UserScript==|^$$/' "$<" > "$@"

deploy: dist
	#git add .
	#git commit -m ${version}
	#git push

clean:
	rm dist/*
