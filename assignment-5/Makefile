parser.out: lex.yy.o ass5_20CS10003_20CS30063.tab.o ass5_20CS10003_20CS30063_translator.o
	g++ lex.yy.o ass5_20CS10003_20CS30063.tab.o ass5_20CS10003_20CS30063_translator.o -lfl -o parser.out

ass5_20CS10003_20CS30063_translator.o: ass5_20CS10003_20CS30063_translator.cxx ass5_20CS10003_20CS30063_translator.h
	g++ -c ass5_20CS10003_20CS30063_translator.cxx

lex.yy.o: lex.yy.c
	g++ -c lex.yy.c

ass5_20CS10003_20CS30063.tab.o: ass5_20CS10003_20CS30063.tab.c
	g++ -c ass5_20CS10003_20CS30063.tab.c

lex.yy.c: ass5_20CS10003_20CS30063.l ass5_20CS10003_20CS30063.tab.h ass5_20CS10003_20CS30063_translator.h
	flex ass5_20CS10003_20CS30063.l

ass5_20CS10003_20CS30063.tab.c ass5_20CS10003_20CS30063.tab.h: ass5_20CS10003_20CS30063.y
	bison -dt --report=all ass5_20CS10003_20CS30063.y

clean:
	rm parser.out ass5_20CS10003_20CS30063_translator.o lex.yy.* ass5_20CS10003_20CS30063.tab.* ass5_20CS10003_20CS30063.output

test: parser.out
	@echo "test 1 (simple expressions)"
	./parser.out < ass5_20CS10003_20CS30063_test1.c > ass5_20CS10003_20CS30063_quads1.out
	@echo "Test 1 complete\n"

	@echo "test 2 (Function calls)"
	./parser.out < ass5_20CS10003_20CS30063_test2.c > ass5_20CS10003_20CS30063_quads2.out
	@echo "Test 2 complete\n"

	@echo "test 3 (if-else blocks)"
	./parser.out < ass5_20CS10003_20CS30063_test3.c > ass5_20CS10003_20CS30063_quads3.out
	@echo "Test 3 complete\n"

	@echo "test 4 (Arrays and pointers)"
	./parser.out < ass5_20CS10003_20CS30063_test4.c > ass5_20CS10003_20CS30063_quads4.out
	@echo "Test 4 complete\n"

	@echo "test 5 (Loops)"
	./parser.out < ass5_20CS10003_20CS30063_test5.c > ass5_20CS10003_20CS30063_quads5.out
	@echo "Test 5 complete\n"




	