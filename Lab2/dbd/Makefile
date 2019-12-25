all: parser

clean:
	rm -f dbd.yy.cpp dbd.tab.{cpp,hpp} parser example.txt

dbd.yy.cpp: dbd.l
	flex -o dbd.yy.cpp dbd.l

dbd.tab.cpp: dbd.y
	yacc -o dbd.tab.cpp -d dbd.y

parser: dbd.yy.cpp dbd.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser dbd.yy.cpp dbd.tab.cpp
