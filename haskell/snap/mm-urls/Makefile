.PHONY: deps tests

build: configure
	cabal build

configure:
	cabal configure

install:
	cabal install

deps:
	cabal-dev install --only-dependencies

tests:
	cabal configure --enable-tests
	cabal build
	cabal test
