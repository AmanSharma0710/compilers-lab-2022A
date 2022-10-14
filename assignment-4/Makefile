ass4_20CS10003_20CS30063_output.txt: parser ass4_20CS10003_20CS30063_test.c
	./parser < ass4_20CS10003_20CS30063_test.c > ass4_20CS10003_20CS30063_output.txt

parser: lex.yy.o y.tab.o ass4_20CS10003_20CS30063_main.o
	gcc lex.yy.o y.tab.o ass4_20CS10003_20CS30063_main.o -lfl -o parser

ass4_20CS10003_20CS30063_main.o: ass4_20CS10003_20CS30063_main.c
	gcc -c ass4_20CS10003_20CS30063_main.c

lex.yy.o: lex.yy.c
	gcc -c lex.yy.c

y.tab.o: y.tab.c
	gcc -c y.tab.c

lex.yy.c: ass4_20CS10003_20CS30063.l y.tab.h
	flex ass4_20CS10003_20CS30063.l

y.tab.c y.tab.h: ass4_20CS10003_20CS30063.y
	bison -dty --report=all ass4_20CS10003_20CS30063.y

clean:
	rm parser ass4_20CS10003_20CS30063_main.o lex.yy.* y.tab.* y.output
