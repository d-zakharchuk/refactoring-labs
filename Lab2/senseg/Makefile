all: parser

clean:
	rm -f senseg.yy.cpp senseg.tab.{cpp,hpp} parser example.txt

senseg.yy.cpp: senseg.l
	flex -o senseg.yy.cpp senseg.l

senseg.tab.cpp: senseg.y
	yacc -o senseg.tab.cpp -d senseg.y

parser: senseg.yy.cpp senseg.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser senseg.yy.cpp senseg.tab.cpp
