all: parser

clean:
	rm -f segm.yy.cpp segm.tab.{cpp,hpp} parser example.txt

segm.yy.cpp: segm.l
	flex -o segm.yy.cpp segm.l

segm.tab.cpp: segm.y
	yacc -o segm.tab.cpp -d segm.y

parser: segm.yy.cpp segm.tab.cpp
	g++ -D_GLIBCXX_USE_CXX11_ABI=0 -w -o parser segm.yy.cpp segm.tab.cpp
