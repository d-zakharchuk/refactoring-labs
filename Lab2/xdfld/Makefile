all: parser

clean:
	rm -f xdfld.yy.cpp xdfld.tab.{cpp,hpp} parser example.txt

xdfld.yy.cpp: xdfld.l
	flex -o xdfld.yy.cpp xdfld.l

xdfld.tab.cpp: xdfld.y
	yacc -o xdfld.tab.cpp -d xdfld.y

parser: xdfld.yy.cpp xdfld.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser xdfld.yy.cpp xdfld.tab.cpp
