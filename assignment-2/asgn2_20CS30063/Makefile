ass2: main.o libass2_20CS30063.a
	gcc main.o -o ass2 -L. -lass2_20CS30063

main.o: main.c myl.h
	gcc -Wall -c main.c

libass2_20CS30063.a: libass2_20CS30063.o
	ar rcs libass2_20CS30063.a libass2_20CS30063.o

libass2_20CS30063.o: libass2_20CS30063.c myl.h
	gcc -c libass2_20CS30063.c

clean:
	rm -f ass2 main.o libass2_20CS30063.a libass2_20CS30063.o