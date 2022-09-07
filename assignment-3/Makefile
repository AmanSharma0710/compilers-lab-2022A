ass3_20CS30063_20CS10003_output.txt: lexical_analyzer ass3_20CS30063_20CS10003_test.c
	./lexical_analyzer < ass3_20CS30063_20CS10003_test.c > ass3_20CS30063_20CS10003_output.txt

lexical_analyzer: lex.yy.c
	gcc lex.yy.c -lfl -o lexical_analyzer

lex.yy.c: ass3_20CS30063_20CS10003.l ass3_20CS30063_20CS10003_main.c
	lex ass3_20CS30063_20CS10003.l ass3_20CS30063_20CS10003_main.c

clean:
	rm lexical_analyzer lex.yy.c ass3_20CS30063_20CS10003_output.txt