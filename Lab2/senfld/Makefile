all: parser

clean:
	rm -f senfld.yy.cpp senfld.tab.{cpp,hpp} parser example.txt

senfld.yy.cpp: senfld.l
	flex -o senfld.yy.cpp senfld.l

senfld.tab.cpp: senfld.y
	yacc -o senfld.tab.cpp -d senfld.y

parser: senfld.yy.cpp senfld.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser senfld.yy.cpp senfld.tab.cpp
