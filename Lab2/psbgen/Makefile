all: parser

clean:
	rm -f psbgen.yy.cpp psbgen.tab.{cpp,hpp} parser example.txt

psbgen.yy.cpp: psbgen.l
	flex -o psbgen.yy.cpp psbgen.l

psbgen.tab.cpp: psbgen.y
	yacc -o psbgen.tab.cpp -d psbgen.y

parser: psbgen.yy.cpp psbgen.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser psbgen.yy.cpp psbgen.tab.cpp
