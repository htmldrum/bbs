CC=gcc
CPP=g++
CFLAGS=-I .
CPPFLAGS=-Wall
SIZEOF=stat -f%z
CALC=README.md
all: hello hello-cpp hello-r
hello: hello.c
	$(CC) -o hello hello.c $(CFLAGS)
hello-cpp: hello-cpp.cpp
	$(CPP) -o hello-cpp hello-cpp.cpp $(CPPFLAGS)
hello-r: hello-rust/src/main.rs
	cd hello-rust; cargo build;
clean:
	rm hello hello-cpp; cd hello-rust; cargo clean;
calc: all
	echo "bbs - big binary size" > $(CALC)
	echo "=====================" >> $(CALC)
	echo "hello `$(SIZEOF) ./hello`b" >> $(CALC)
	echo "hello-cpp `$(SIZEOF) ./hello-cpp`b" >> $(CALC)
	echo "hello-rust `$(SIZEOF) ./hello-rust/target/debug/hello-rust`b" >> $(CALC)
	cat $(CALC)
.PHONY:
	hello-r all clean
