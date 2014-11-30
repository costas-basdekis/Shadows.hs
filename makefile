build: dependencies

dependencies:
	cabal install --only-dependencies

tests:
	echo "./runtests.sh" | cabal exec bash

.PHONY: build tests
