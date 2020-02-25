.PHONY: build clean

build:
	clang -Werror -framework Cocoa pblink.m -o pblink

run: build
	./pblink

clean:
	rm -f pblink
