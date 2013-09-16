CABAL?=cabal-dev

.PHONY: tests build configure install

build: configure
	$(CABAL) build

configure:
	$(CABAL) configure

install:
	$(CABAL) install

deps:
	$(CABAL) install --enable-tests --only-dependencies

test: tests
tests: deps
	$(CABAL) configure --enable-tests
	$(CABAL) build
	$(CABAL) test
