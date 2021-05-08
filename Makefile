bminor: main.o scanner.o parser.o
	gcc main.o scanner.o parser.o -o bminor

main.o: main.c token.h
	gcc -w main.c -c -o main.o

scanner.o: scanner.c token.h
	gcc scanner.c -c -o scanner.o

scanner.c: scanner.flex
	flex -oscanner.c scanner.flex

parser.c: parser1.bison token.h
	bison -v --defines=token.h --output=parser.c parser1.bison

parser.o: parser.c token.h
	gcc parser.c -c -o parser.o
    
clean:
	rm -f scanner.c scanner.o main.o bminor
	rm -f parser.c parser.o parser.output
