.PHONY: info clean clean-local all build dist
.DEFAULT_GOAL := info

# app environment
ENV ?= dev
# repository / source control related vars
REPO = ssh-client
BRANCH = $(shell git rev-parse --abbrev-ref HEAD)
COMMIT = $(shell git rev-parse --short HEAD)
NAME ?= $(REPO)-test
# NAME ?= $(REPO)_$(BRANCH)
# NAME ?= $(REPO)_$(BRANCH)_$(COMMIT)
# container related vars
# application related vars
# using only values of current dev env (dev)
# ...

info:
	@echo "# $(NAME) #"
	@echo "Environment: $(ENV)"
	@echo "Repository: $(REPO), branch: $(BRANCH), commit: $(COMMIT)"
	@v version
	@echo "Main tasks here are: "
	@echo "all, test, run, build, dist, run, etc"
	@echo "For a quick build and run, use the task: build-and-run"
	@echo "Look into Makefile for details and other tasks ..."
	@echo "----"

all: info clean

clean-local:
	@echo "clean local binary artefacts (list manually updated)..."
	@rm -f ./ssh-client
	@find . -name '*_test' | xargs rm -f 

clean: clean-local
	@echo "clean output/temporary artefacts..."
	@rm -rf ./build && mkdir -p ./build
	@rm -rf ./dist  && mkdir -p ./dist
	@rm -rf ./temp  && mkdir -p ./temp

setup: 
	@echo "setup folder structure etc..."
	@mkdir -p ./build
	@mkdir -p ./dist
	@mkdir -p ./temp

build-local: clean-local setup
	@echo "Build all sources with destination in the same folder..."
	@v .

test:
	@echo "Run Unit Test all sources..."
	@v test .

clean-build:
	@echo "Clean the folder './build'..."
	@rm -rf ./build/*

clean-dist:
	@echo "Clean the folder './dist'..."
	@rm -rf ./dist/*

fix-build:
	@sudo chown $(USER):$(USER) -R ./build/*

fix-dist:
	@sudo chown $(USER):$(USER) -R ./dist/*

# TODO: add build, etc ...
